import 'dart:async';

import 'package:config_app/features/config/data/repository/photoframe_repository.dart';
import 'package:config_app/features/config/presentation/bloc/config_bloc.dart';
import 'package:config_app/features/config/presentation/bloc/config_bloc_models.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late _Repository repository;
  late ConfigBloc bloc;
  late List<ConfigState> states;

  setUp(() {
    repository = _Repository();
    bloc = ConfigBloc(
      initialState: const ConfigState.initial(),
      client: repository,
    );
    states = [];
    final subscription = bloc.stream.listen(states.add);
    addTearDown(subscription.cancel);
    addTearDown(bloc.close);
  });

  test('loads configuration and accepts a later reload', () async {
    final first = _config(8081);
    final second = _config(8082);

    bloc.add(const ConfigEvent.load());
    await pumpEventQueue();
    expect(states, [isA<ConfigLoadingState>()]);
    repository.loads.single.complete(first);
    await pumpEventQueue();

    expect((bloc.state as ConfigLoadedState).config, same(first));
    bloc.add(const ConfigEvent.load());
    await pumpEventQueue();
    repository.loads.last.complete(second);
    await pumpEventQueue();

    expect(repository.loads, hasLength(2));
    expect((bloc.state as ConfigLoadedState).config, same(second));
  });

  test('acknowledges save before publishing its isolated snapshot', () async {
    final draft = _config(8081);
    draft.slideshow.effects = EffectsConfig(
      items: [EffectConfig(type: EffectType.fade, enabled: true)],
    );

    bloc.add(ConfigEvent.save(draft));
    await pumpEventQueue();

    expect(states, [isA<ConfigSavingState>()]);
    final sent = repository.saved.single;
    expect(sent, isNot(same(draft)));
    expect(sent.webServer, isNot(same(draft.webServer)));
    expect(
      sent.slideshow.effects.items,
      isNot(same(draft.slideshow.effects.items)),
    );

    draft.webServer.port = 9090;
    draft.slideshow.effects = draft.slideshow.effects.put(
      EffectConfig(type: EffectType.mosaic, enabled: true),
    );
    repository.saves.single.complete(const WSResultOk(id: 1));
    await pumpEventQueue();

    expect(states, [
      isA<ConfigSavingState>(),
      isA<ConfigSavedState>(),
      isA<ConfigLoadedState>(),
    ]);
    final acknowledged = (bloc.state as ConfigLoadedState).config;
    expect(acknowledged, same(sent));
    expect(acknowledged.webServer.port, 8081);
    expect(acknowledged.slideshow.effects.items.single.type, EffectType.fade);
    expect(draft.webServer.port, 9090);
  });

  test('save isolates nested options of an unknown future screen', () async {
    final draft = AppConfig.fromJson({
      'slideshow': {
        'specialScreens': [
          {
            'id': 'future-screen',
            'type': 'future-type',
            'options': {
              'layers': [
                {'color': 'original'},
              ],
            },
          },
        ],
      },
    });
    final options =
        draft.slideshow.specialScreens.single.options as UnknownScreenOptions;

    bloc.add(ConfigEvent.save(draft));
    await pumpEventQueue();
    (options.json['layers'] as List).single['color'] = 'edited';
    repository.saves.single.complete(const WSResultOk(id: 1));
    await pumpEventQueue();

    final acknowledged = (bloc.state as ConfigLoadedState).config;
    final savedOptions =
        acknowledged.slideshow.specialScreens.single.options
            as UnknownScreenOptions;
    expect((savedOptions.json['layers'] as List).single['color'], 'original');
    expect((options.json['layers'] as List).single['color'], 'edited');
    expect(
      acknowledged.slideshow.specialScreens.single.toJson()['type'],
      'future-type',
    );
  });

  test('ignores duplicate loads and saves while loading', () async {
    bloc.add(const ConfigEvent.load());
    await pumpEventQueue();

    bloc
      ..add(const ConfigEvent.load())
      ..add(ConfigEvent.save(_config(8082)));
    await pumpEventQueue();

    expect(repository.loads, hasLength(1));
    expect(repository.saves, isEmpty);
    expect(states, [isA<ConfigLoadingState>()]);

    repository.loads.single.complete(_config(8081));
    await pumpEventQueue();
    bloc.add(ConfigEvent.save(_config(8083)));
    await pumpEventQueue();
    expect(repository.saves, hasLength(1));
    repository.saves.single.complete(const WSResultOk(id: 1));
    await pumpEventQueue();
    expect((bloc.state as ConfigLoadedState).config.webServer.port, 8083);
  });

  test('ignores duplicate saves and loads while saving', () async {
    bloc.add(ConfigEvent.save(_config(8081)));
    await pumpEventQueue();

    bloc
      ..add(ConfigEvent.save(_config(8082)))
      ..add(const ConfigEvent.load());
    await pumpEventQueue();

    expect(repository.saves, hasLength(1));
    expect(repository.loads, isEmpty);
    expect(states, [isA<ConfigSavingState>()]);

    repository.saves.single.complete(const WSResultOk(id: 1));
    await pumpEventQueue();
    bloc.add(const ConfigEvent.load());
    await pumpEventQueue();
    expect(repository.loads, hasLength(1));
    repository.loads.single.complete(_config(8083));
    await pumpEventQueue();
    expect((bloc.state as ConfigLoadedState).config.webServer.port, 8083);
  });

  test('a load error releases the operation and allows retry', () async {
    bloc.add(const ConfigEvent.load());
    await pumpEventQueue();
    repository.loads.single.completeError(StateError('download failed'));
    await pumpEventQueue();

    expect(bloc.state, isA<ConfigErrorState>());
    expect(
      (bloc.state as ConfigErrorState).message,
      contains('download failed'),
    );
    bloc.add(const ConfigEvent.load());
    await pumpEventQueue();
    repository.loads.last.complete(_config(8082));
    await pumpEventQueue();

    expect(repository.loads, hasLength(2));
    expect((bloc.state as ConfigLoadedState).config.webServer.port, 8082);
  });

  test('a save error leaves the draft intact and allows retry', () async {
    final draft = _config(8081);
    bloc.add(ConfigEvent.save(draft));
    await pumpEventQueue();
    repository.saves.single.completeError(StateError('upload failed'));
    await pumpEventQueue();

    expect(bloc.state, isA<ConfigErrorState>());
    expect((bloc.state as ConfigErrorState).message, contains('upload failed'));
    expect(states.whereType<ConfigSavedState>(), isEmpty);
    expect(draft.webServer.port, 8081);

    draft.webServer.port = 8082;
    bloc.add(ConfigEvent.save(draft));
    await pumpEventQueue();
    repository.saves.last.complete(const WSResultOk(id: 1));
    await pumpEventQueue();

    expect(repository.saves, hasLength(2));
    expect((bloc.state as ConfigLoadedState).config.webServer.port, 8082);
    expect(draft.webServer.port, 8082);
  });

  for (final save in [false, true]) {
    for (final fails in [false, true]) {
      test('closing during ${save ? 'save' : 'load'} ignores a late '
          '${fails ? 'error' : 'result'}', () async {
        bloc.add(
          save ? ConfigEvent.save(_config(8081)) : const ConfigEvent.load(),
        );
        await pumpEventQueue();
        expect(states, hasLength(1));

        await bloc.close();
        if (save) {
          if (fails) {
            repository.saves.single.completeError(StateError('late failure'));
          } else {
            repository.saves.single.complete(const WSResultOk(id: 1));
          }
        } else if (fails) {
          repository.loads.single.completeError(StateError('late failure'));
        } else {
          repository.loads.single.complete(_config(8082));
        }
        await pumpEventQueue();

        expect(states, hasLength(1));
        expect(bloc.isClosed, isTrue);
      });
    }
  }
}

AppConfig _config(int port) => AppConfig.fromJson({
  'web': {'port': port},
});

class _Repository implements PhotoframeRepository {
  final loads = <Completer<AppConfig>>[];
  final saves = <Completer<WebSocketResult>>[];
  final saved = <AppConfig>[];

  @override
  Future<AppConfig> getConfig() {
    final result = Completer<AppConfig>();
    loads.add(result);
    return result.future;
  }

  @override
  Future<WebSocketResult> saveConfig(AppConfig config) {
    saved.add(config);
    final result = Completer<WebSocketResult>();
    saves.add(result);
    return result.future;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
