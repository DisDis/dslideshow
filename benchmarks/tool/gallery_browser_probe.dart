// Real browser transport checks; no Flutter UI, devices or production server.
// ignore_for_file: depend_on_referenced_packages, avoid_print
import 'dart:async';
import 'dart:convert';

import 'package:config_app/src/gallery/media_image_loader.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;

void check(bool value, String message) {
  if (!value) throw StateError(message);
}

Future<void> eventually(FutureOr<bool> Function() condition) async {
  final watch = Stopwatch()..start();
  while (!await condition()) {
    if (watch.elapsed > const Duration(seconds: 6)) {
      throw TimeoutException('Browser observation did not settle');
    }
    await Future<void>.delayed(const Duration(milliseconds: 20));
  }
}

Future<void> main() async {
  final origin = Uri.base.resolve('/');
  final cross = Uri.parse(Uri.base.queryParameters['cross']!);
  final production = Uri.base.queryParameters['backend'];
  final cases = <Map<String, Object?>>[];
  Future<void> scenario(String name, Future<Object?> Function() run) async {
    final clock = Stopwatch()..start();
    try {
      cases.add({
        'name': name,
        'status': 'passed',
        'observations': await run(),
        'elapsed_ms': clock.elapsedMilliseconds,
      });
    } catch (error, stack) {
      cases.add({
        'name': name,
        'status': 'failed',
        'error': '$error',
        'stack': '$stack',
        'elapsed_ms': clock.elapsedMilliseconds,
      });
    }
  }

  Future<Map<String, dynamic>> stats(String phase, [Uri? server]) async {
    final client = BrowserClient();
    try {
      final result = await client.get(
        (server ?? origin).resolve('/stats?phase=$phase'),
      );
      return jsonDecode(result.body) as Map<String, dynamic>;
    } finally {
      client.close();
    }
  }

  GalleryImageRequest image(
    String phase,
    String id, {
    String revision = '1',
    Uri? server,
  }) => GalleryImageRequest(
    key: GalleryImageKey(
      scope: phase,
      mediaId: id,
      revision: revision,
      variant: GalleryImageVariant.thumbnail,
    ),
    uri: (server ?? origin).resolve('/body?phase=$phase&id=$id'),
  );

  await scenario(
    'same-origin loader cap, deduplication and encoded cache hit',
    () async {
      const phase = 'cap-dedup';
      final loader = MediaImageLoader(
        client: BrowserClient(),
        maxActive: 2,
        maxPrefetch: 0,
      );
      final leases = <GalleryImageLease>[];
      try {
        final first = loader.acquire(image(phase, 'same'));
        final duplicate = loader.acquire(image(phase, 'same'));
        leases.addAll([first, duplicate]);
        leases.addAll([
          for (var index = 0; index < 6; index++)
            loader.acquire(image(phase, '$index')),
        ]);
        var clientPeak = 0;
        final sampling = Timer.periodic(const Duration(milliseconds: 2), (_) {
          if (loader.activeCount > clientPeak) clientPeak = loader.activeCount;
        });
        final results = await Future.wait(leases.map((lease) => lease.result));
        sampling.cancel();
        check(
          identical(results[0], results[1]),
          'Dedup did not return the same payload',
        );
        check(
          results.every((image) => image.byteLength == 262144),
          'Short response accepted',
        );
        final warm = loader.acquire(image(phase, 'same'));
        leases.add(warm);
        await warm.result;
        final changed = loader.acquire(image(phase, 'same', revision: '2'));
        leases.add(changed);
        await changed.result;
        await eventually(() async => (await stats(phase))['active'] == 0);
        final observed = await stats(phase);
        check(
          observed['requests'] == 8,
          'Expected 7 unique transfers + 1 revision change',
        );
        check(
          observed['peak'] == 2 && clientPeak == 2,
          'Actual request cap was not two',
        );
        return {'client_peak': clientPeak, 'server': observed};
      } finally {
        for (final lease in leases) {
          lease.dispose();
        }
        await loader.close();
        check(
          loader.pendingCount == 0 &&
              loader.activeCount == 0 &&
              loader.leasedEncodedBytes == 0,
          'Loader did not release all operations and leases',
        );
      }
    },
  );

  await scenario('BrowserClient abort before response headers', () async {
    const phase = 'before-headers';
    final client = BrowserClient();
    final abort = Completer<void>();
    final request = http.AbortableRequest(
      'GET',
      origin.resolve('/slow-headers?phase=$phase'),
      abortTrigger: abort.future,
    );
    final operation = client.send(request);
    operation.ignore();
    try {
      await eventually(() async => (await stats(phase))['active'] == 1);
      abort.complete();
      var cancelled = false;
      try {
        await operation;
      } on http.RequestAbortedException {
        cancelled = true;
      }
      check(cancelled, 'Abort before headers did not abort the fetch');
      await eventually(() async => (await stats(phase))['active'] == 0);
      final observed = await stats(phase);
      check(
        observed['cancelled'] == 1 && observed['bytes'] == 0,
        'Server did not observe early disconnect',
      );
      return observed;
    } finally {
      client.close();
    }
  });

  await scenario(
    'cross-origin loader cancellation during response body',
    () async {
      const phase = 'body-abort';
      final loader = MediaImageLoader(
        client: BrowserClient(),
        maxActive: 2,
        maxPrefetch: 0,
      );
      final lease = loader.acquire(
        GalleryImageRequest(
          key: image(phase, 'large').key,
          uri: cross.resolve('/large-body?phase=$phase'),
        ),
      );
      try {
        await eventually(
          () async => (await stats(phase, cross))['bytes'] >= 65536,
        );
        lease.dispose();
        var cancelled = false;
        try {
          await lease.result;
        } on GalleryImageCancelled {
          cancelled = true;
        }
        check(cancelled, 'Consumer did not receive cancellation');
        await eventually(
          () => loader.activeCount == 0 && loader.pendingCount == 0,
        );
        await eventually(
          () async => (await stats(phase, cross))['active'] == 0,
        );
        final observed = await stats(phase, cross);
        check(
          observed['cancelled'] == 1 && observed['bytes'] < 33554432,
          'Full body was transferred despite abort',
        );
        check(loader.inFlightBytes == 0, 'Byte reservation was not released');
        return observed;
      } finally {
        lease.dispose();
        await loader.close();
      }
    },
  );

  await scenario(
    'same/cross-origin HEAD, validators, Range and exposed headers',
    () async {
      final client = BrowserClient();
      try {
        for (final server in [origin, cross]) {
          final first = await client.get(
            server.resolve('/headers?phase=headers'),
          );
          check(
            first.statusCode == 200 &&
                first.headers['etag'] == '"gallery-probe"',
            'ETag not exposed',
          );
          for (final header in [
            'last-modified',
            'content-length',
            'content-range',
            'accept-ranges',
            'retry-after',
          ]) {
            check(
              first.headers.containsKey(header),
              '$header was not exposed to JavaScript',
            );
          }
          final unchanged = await client.get(
            server.resolve('/headers?phase=headers'),
            headers: {'If-None-Match': '"gallery-probe"'},
          );
          check(
            unchanged.statusCode == 304 && unchanged.bodyBytes.isEmpty,
            'Conditional GET is not body-free',
          );
          final range = await client.get(
            server.resolve('/headers?phase=headers'),
            headers: {'Range': 'bytes=2-4'},
          );
          check(
            range.statusCode == 206 && range.body == '234',
            'Cross-origin Range failed',
          );
          final head = await client.head(
            server.resolve('/headers?phase=headers'),
          );
          check(
            head.statusCode == 200 && head.bodyBytes.isEmpty,
            'HEAD returned a body',
          );
        }
        final observed = await stats('headers', cross);
        check(
          (observed['options'] as int) >= 1,
          'If-None-Match did not exercise CORS preflight',
        );
        return observed;
      } finally {
        client.close();
      }
    },
  );

  await scenario('cross-origin response without CORS is rejected', () async {
    final client = BrowserClient();
    try {
      var rejected = false;
      try {
        await client.get(cross.resolve('/denied?phase=denied'));
      } on http.ClientException {
        rejected = true;
      }
      check(rejected, 'Browser accepted a response without CORS permission');
      return {'cors_rejected': rejected};
    } finally {
      client.close();
    }
  });

  if (production != null) {
    await scenario(
      'actual WebService cross-origin GET, HEAD, ETag and Range',
      () async {
        final client = BrowserClient();
        try {
          final uri = Uri.parse(production);
          final first = await client.get(uri);
          check(first.statusCode == 200, 'Production GET failed');
          final etag = first.headers['etag'];
          check(etag != null, 'Actual production ETag was not exposed');
          for (final header in [
            'last-modified',
            'content-length',
            'accept-ranges',
          ]) {
            check(
              first.headers.containsKey(header),
              'Production $header was not exposed',
            );
          }
          final unchanged = await client.get(
            uri,
            headers: {'If-None-Match': etag!},
          );
          check(
            unchanged.statusCode == 304 && unchanged.bodyBytes.isEmpty,
            'Actual conditional production response failed',
          );
          // Distinct URLs ensure Chrome cannot synthesize a range/HEAD from the
          // fresh full response in its HTTP cache. Both must reach WebService.
          Uri operation(String name) => uri.replace(
            queryParameters: {...uri.queryParameters, 'galleryProbe': name},
          );
          final ranged = await client.get(
            operation('range'),
            headers: {'Range': 'bytes=2-4'},
          );
          check(
            ranged.statusCode == 206 &&
                ranged.bodyBytes.length == 3 &&
                ranged.headers['content-range'] ==
                    'bytes 2-4/${first.bodyBytes.length}',
            'Actual production Range/CORS failed',
          );
          check(
            List.generate(
              3,
              (index) => ranged.bodyBytes[index] == first.bodyBytes[index + 2],
            ).every((value) => value),
            'Production Range changed original bytes',
          );
          final head = await client.head(operation('head'));
          check(
            head.statusCode == 200 &&
                head.bodyBytes.isEmpty &&
                head.headers['content-length'] == '${first.bodyBytes.length}',
            'Actual production HEAD failed',
          );
          return {
            'original_bytes': first.bodyBytes.length,
            'range_bytes': ranged.bodyBytes.length,
            'conditional_status': unchanged.statusCode,
            'head_body_bytes': head.bodyBytes.length,
          };
        } finally {
          client.close();
        }
      },
    );
  }

  final client = BrowserClient();
  try {
    await client.post(
      origin.resolve('/result'),
      headers: {'content-type': 'application/json'},
      body: jsonEncode({
        'runtime': 'Chrome JavaScript + production MediaImageLoader + actual BrowserClient fetch',
        'cases': cases,
        'passed': cases.every((result) => result['status'] == 'passed'),
      }),
    );
  } finally {
    client.close();
  }
}
