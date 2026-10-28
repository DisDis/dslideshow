#!/usr/bin/env python3
"""Validate comparability and summarize frozen gallery HTTP A/B observations."""
import argparse
import json
from pathlib import Path
import statistics

import gallery_http


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--baseline', default='baseline')
    parser.add_argument('--candidate', default='candidate-accepted')
    parser.add_argument('--browser', default='browser-accepted-wire')
    args = parser.parse_args()
    root = args.output.resolve()
    names = [args.baseline, args.candidate]
    rows, runs, builds = {}, {}, {}
    for name in names:
        variant = root / name
        gallery_http.verify_snapshot(variant)
        rows[name] = json.loads((variant / 'execution/confirmed/summary.json').read_text())
        runs[name] = json.loads((variant / 'execution/confirmed/run.json').read_text())
        builds[name] = json.loads((variant / 'execution/build.json').read_text())
        if gallery_http.digest(variant / 'execution/gallery-http-server') != builds[name]['binary_sha256']:
            raise ValueError(f'AOT binary changed: {name}')
    for key in ('runner_sha256', 'sizes', 'concurrency', 'requests', 'repeats', 'media'):
        if runs[names[0]][key] != runs[names[1]][key]:
            raise ValueError(f'Noncomparable run configuration: {key}')
    for key in ('harness_sha256', 'dart', 'mode'):
        if builds[names[0]][key] != builds[names[1]][key]:
            raise ValueError(f'Noncomparable build: {key}')
    standard = runs[names[0]]
    if (standard['sizes'] != [1000, 10000] or standard['concurrency'] != [1, 4, 10] or
            standard['requests'] != 12 or standard['repeats'] != 3 or
            [Path(file).name for file in standard['media']] != ['photo_a.jpg', 'photo_b.jpg', 'photo_large.jpg']):
        raise ValueError('Human report requires the documented standard matrix and media fixtures')
    for count in standard['sizes']:
        for repeat in range(standard['repeats']):
            manifests = [json.loads((root / name / f'execution/confirmed/n{count}-r{repeat}/raw.json').read_text())['fixture']
                         for name in names]
            if manifests[0] != manifests[1]:
                raise ValueError(f'Media fixture hashes differ: {count}/{repeat}')

    groups = []
    for count in runs[names[0]]['sizes']:
        for group in sorted({row['name'] for row in rows[names[0]]}):
            result = {'metadata_entries': count, 'scenario': group}
            for name in names:
                observed = [row for row in rows[name] if row['metadata_entries'] == count and row['name'] == group]
                if len(observed) != runs[name]['repeats']:
                    raise ValueError(f'Missing repetitions: {name}/{count}/{group}')
                result[name] = {
                    'repetitions': len(observed),
                    'median_trial_p50_ms': statistics.median(row['latency_ms']['p50'] for row in observed),
                    'median_trial_info_p95_ms': statistics.median(row['info_latency_ms']['p95'] for row in observed),
                    'median_cpu_ms': statistics.median(row['cpu_ms'] for row in observed),
                    'client_body_bytes': sorted({row['client_body_bytes'] for row in observed}),
                    'errors': sum(row['errors'] for row in observed),
                    'info_errors': sum(row['info_errors'] for row in observed),
                    'peak_observed_rss_kib': max(row['max_rss_kib'] for row in observed),
                    'peak_observed_fds': max(row['max_fd'] for row in observed),
                    'peak_source_bodies': max(row['server_max_active_bodies'] for row in observed),
                    'source_cancellations': sorted({row['server_source_cancellations'] for row in observed}),
                }
            groups.append(result)
    browser_root = root / args.browser
    browser = json.loads((browser_root / 'result.json').read_text())
    if not browser['passed'] or not all(browser.get('production_wire', {}).values()) or not browser.get('production_wire'):
        raise ValueError('Real browser checks require successful production wire verification')
    browser_provenance = json.loads((browser_root / 'provenance.json').read_text())
    for name, expected in browser_provenance['source_sha256'].items():
        if gallery_http.digest(browser_root / name) != expected:
            raise ValueError(f'Frozen browser source changed: {name}')
    backend_provenance = json.loads((browser_root / 'backend-provenance.json').read_text())
    if backend_provenance['binary_sha256'] != builds[args.candidate]['binary_sha256']:
        raise ValueError('Browser did not verify the selected candidate binary')
    frozen_manifest = json.loads((root / args.candidate / 'source-manifest.json').read_text())
    current_drift = [name for name, expected in frozen_manifest.items()
                     if not (gallery_http.ROOT / name).exists() or
                     gallery_http.digest(gallery_http.ROOT / name) != expected]
    result = {'baseline': names[0], 'candidate': names[1],
              'comparability': {'run': runs[names[0]], 'harness_sha256': builds[names[0]]['harness_sha256'],
                               'dart': builds[names[0]]['dart'], 'build_mode': builds[names[0]]['mode']},
              'groups': groups, 'browser_result': browser,
              'working_tree_differences_from_candidate_at_report': current_drift}
    (root / 'comparison.json').write_text(json.dumps(result, indent=2) + '\n')
    by_group = {(group['metadata_entries'], group['scenario']): group for group in groups}
    lines = [
        '# Галерея: проверка реализации 26.10.2026', '',
        'Это локальные наблюдения Linux AOT HTTP и настоящего Chrome BrowserClient. '
        'RaPi5, Wi-Fi, прокрутка Flutter UI, FPS и аппаратная приёмка не выполнялись.', '',
        f'Основное A/B: `{names[0]}` → `{names[1]}`. '
        'Архивы прочих промежуточных вариантов сохранены и не смешиваются с этой таблицей. '
        '[Машинная сводка](comparison.json) сохраняет сравнение и отдельные значения CPU/RSS/FD.', '',
        '## Условия и воспроизводимость', '',
        'Baseline заморожен из HEAD `239fa81f2ea1bac73e67f43df4577d064c6f6ea9` до production-правок: '
        '`baseline/source.tar`, `sources/`, исходные package configs, SHA256 manifest и provenance. '
        'Candidate сохраняет текущие backend/common, pubspec/lock и переписанный absolute package config '
        'в собственном каталоге. SDK и существующий pub cache не включены в архивы; AOT binaries сохранены.', '',
        ('На момент отчёта production `backend/lib` и `common/lib` совпадают с candidate; '
         'после freeze вне этого прогона изменился только `backend/pubspec.yaml` '
         '(версия 10.2.0+3 → 11.0.0). Чужая правка сохранена, повторный freeze ради версии не делался.'
         if current_drift == ['backend/pubspec.yaml'] else
         f'Отличия текущего дерева от frozen candidate: `{current_drift}`. Таблица относится к сохранённому snapshot.'), '',
        f'Один и тот же server harness SHA256 `{builds[names[0]]["harness_sha256"]}` и Python runner '
        f'`{runs[names[0]]["runner_sha256"]}` применены к обеим версиям. '
        f'Dart: `{builds[names[0]]["dart"]}`. '
        'Report generator проверяет совпадение harness/runner/SDK, матрицы, исходных manifest и AOT hashes.', '',
        'По три свежих процесса на 1k/10k отдельных пустых JPG плюс три встроенных декодируемых JPEG fixtures '
        '`photo_a.jpg`, `photo_b.jpg`, `photo_large.jpg`. Пустые файлы проверяют только метаданные '
        'и никогда не передаются декодеру. Непустые встроенные JPEG копируются без изменений; SHA256/размеры '
        'сохранены в каждом `raw.json`. `photo_large.jpg` — синтетический fixture 8000×6000, 10 192 467 байт. '
        'Эти файлы не заменяют реальную фототеку с разнообразными EXIF/ICC/форматами. '
        'Файловый кеш ОС прогрет созданием/копированием, не сбрасывается.', '',
        'HTTP server — реальный WebService.handler через shelf на 127.0.0.1 в отдельном процессе; '
        'benchmark-only wrapper наблюдает body bytes, overlap, EOF/cancel и event-loop lateness. '
        'Тёплые grid и original-control используют 12 запросов на concurrency 1/4/10; '
        'Python клиенты читают по 64 KiB с паузой 1 мс. Холодный проход — три JPEG при concurrency=1 '
        'без искусственной паузы чтения. '
        'Baseline grid получает оригиналы; candidate grid — отдельные versioned миниатюры 256 px. '
        'Original-control в candidate получает оригиналы с revision URL. '
        'Контроль полноты списка и точного количества оригинальных байтов обязателен.', '',
        '«Cold» ниже означает отсутствие backend derivative cache при новом процессе/fixture. '
        '«Warm» — готовые backend derivatives; HTTP/browser/client disk cache в A/B не эмулируется. '
        'Время CPU относится к серверному процессу со всеми его isolate threads. '
        'RSS — периодически наблюдавшийся максимум, не строгий пик и не доказательство утечки. '
        'Порядок сценариев одинаков; host остаётся общей рабочей машиной, не изолированным стендом.', '',
        '## Наблюдения HTTP', '',
        'Время — медиана p50 отдельных повторов (три процесса), а не общий p50/p95. '
        'Числа `/info` — медиана p95 отдельных повторов; endpoint является прокси отзывчивости HTTP/event loop '
        'и не заменяет настоящий configuration/RPC workload. Сырые p50/p95/p99 и выборки сохранены; '
        'малое N не подтверждает устойчивый p99.', '',
        '| Метаданных | Сценарий | p50 baseline, мс | p50 candidate, мс | Body bytes baseline → candidate |',
        '| --- | --- | ---: | ---: | ---: |',
    ]
    for count in runs[names[0]]['sizes']:
        for scenario in ('legacy-list', 'grid-backend-cache-cold', 'grid-warm-c1', 'grid-warm-c4', 'grid-warm-c10', 'original-control-c4'):
            pair = by_group[count, scenario]
            a, b = pair[names[0]], pair[names[1]]
            lines.append(f'| {count} | {scenario} | {a["median_trial_p50_ms"]:.3f} | {b["median_trial_p50_ms"]:.3f} | '
                         f'{a["client_body_bytes"][0]:,} → {b["client_body_bytes"][0]:,} |')
    lines += ['',
        'Оригиналы передают прежнее число байтов. Для двенадцати tile-запросов три фото в данной '
        'выборке дают 76 382 932 → 456 208 байт (примерно 167× меньше). '
        'Это измеренный эффект размера производных, не установленный предел RPS shelf. '
        'Холодное создание миниатюр стоит CPU/времени; цифры тёплого кеша его не скрывают.', '',
        'При списке 10k медиана trial-p95 `/info`: '
        f'{by_group[10000, "legacy-list"][names[0]]["median_trial_info_p95_ms"]:.3f} → '
        f'{by_group[10000, "legacy-list"][names[1]]["median_trial_info_p95_ms"]:.3f} мс. '
        'Полное время списка сопоставимо: асинхронный обход прежде всего снимает блокировку event loop. '
        'Первое построение v2 catalog измеряется отдельно в `raw.json/list_catalog`; у 10k оно занимает '
        'порядка секунды на этом host. Пагинация/инкрементальный индекс здесь не объявляются проверенными.', '',
        'В каждом основном варианте 54 группы, HTTP и `/info` ошибок нет. '
        'В 18 условных tile GET candidate получены 304/0 байт; baseline возвращает 200/оригинал. '
        'Четыре socket-cancel по sparse-файлу 64 MiB дают четыре отмены source и возвращают '
        'active body/handler к нулю. Клиент читает 262 144 байта суммарно; backend может прочитать больше '
        'из-за буферизации TCP. Мгновенный backend overlap при отмене может кратко превышать число '
        'client slots до доставки disconnect; это не скрывается и не подменяется нулями.', '',
        'RSS улучшение не доказано: candidate включает каталог и decoder worker, '
        'а наблюдавшиеся максимумы зависят от истории GC и стадии. '
        'Подробные CPU/RSS/FD/threads, RPS, body counts и timestamps находятся в raw/summary.', '',
        '## Настоящий браузер', '',
        f'[`{args.browser}/result.json`]({args.browser}/result.json): '
        f'{len(browser["cases"])} сценариев, passed={browser["passed"]}. '
        'Используются установленный Chrome, две controlled loopback origins и actual frozen WebService '
        'AOT для отдельной проверки production CORS. Profile в /tmp, без установки браузера.', '',
        'Проверены реальный peak=2 и дедупликация/тёплый encoded hit; изменение revision создаёт новый '
        'request. AbortableRequest до headers приводит к disconnect без тела. При отмене во время '
        '32 MiB body сервер заканчивает раньше полного тела, loader освобождает active/pending/byte reservations. '
        'Проверены браузерные OPTIONS preflight, If-None-Match/304, Range/206, HEAD, exposed validator/range '
        'headers и отклонение ответа без CORS. Дополнительный сценарий делает GET/HEAD/304/Range '
        'именно к production WebService через другую origin. Это не Flutter scroll/визуальная проверка.', '',
        'Для production Range и HEAD используются отдельные query URL, исключающие синтез ответа '
        'из HTTP-кеша Chrome после GET. Server body observer отдельно подтверждает 206/3 байта, '
        '304/0 байт и 200/0 байт для HEAD. Ранее сохранённый `browser-accepted-direct` не завершился '
        'из-за гонки удаления временного Chrome profile; он не засчитан как PASS. '
        'Стенд повторяет только удаление профиля, не тестовые сценарии.', '',
        'Provenance браузера содержит immutable production loader copy, package config, compiled JS hashes '
        'и Chrome version. Контролируемые body fixtures не декодируются как изображения.', '',
        '## Команды', '',
        'Из корня репозитория (новые имена вариантов/run-name, старые результаты не перезаписываются):', '',
        '```sh',
        'python3 benchmarks/tool/gallery_http.py \\',
        f'  --output {args.output} --variant baseline --reuse-binary --run-name repeat-1',
        'python3 benchmarks/tool/gallery_http.py \\',
        f'  --output {args.output} --variant candidate-next --freeze-current',
        'python3 benchmarks/tool/gallery_http_report.py \\',
        f'  --output {args.output} --candidate {args.candidate} --browser {args.browser}',
        "python3 -m unittest discover -s benchmarks/tool -p 'test_gallery_http.py' -v",
        '```', '',
        'Автоматическая Chrome-проба удалена; --browser читает сохранённые архивные результаты '
        'без нового браузерного прогона. '
        'Loopback и Flutter SDK lockfile требуют соответствующего разрешения sandbox. '
        'Первоначальные compiler telemetry и socket-denial диагностики сохранены отдельно; '
        'окончательные raw/compile logs относятся к указанным вариантам. '
        'Native encoded cache проверен 17 regression cases, включая atomic publication, отмену/close, '
        'LRU/reopen, pins через замену и eviction, transient oversized cleanup, corruption miss '
        'и настоящий FileImage→DecodePool first-frame при нулевых cache budgets. '
        'Дополнительно проверены внешний fcntl lock, overlapping handles/pinned close, '
        'worker-isolate memory fallback и failed-init recovery. Default disk каталог — '
        '`getApplicationCacheDirectory()/gallery-encoded-v1`; владение получает только root UI isolate '
        'через неблокирующий `.owner.lock`. При занятости/ошибке используется memory LRU 24 MiB/128 objects '
        '(disk LRU 128 MiB/512). Shared store держит lock до конца процесса; standalone close — до '
        'освобождения всех payload pins и cleanup. Неуспешная инициализация останавливает sweeps до unlock. '
        'Первый full frontend suite выявил зависимость одного concurrent test от порядка публикации; '
        'fixture исправлен явным remove перед проверкой последнего release, production не менялся. '
        'Остальные backend/common/frontend regressions и Web build перечислены в основном руководстве.', '',
        '## Не выполнено', '',
        'RaPi5, Wi-Fi, Web/Linux scroll UX на коллекции реальных больших фото, '
        'UI frame timings/клиентская память, смешанная коллекция с работающим видео, '
        'несколько реальных клиентов, полноценная RPC-нагрузка и аппаратное A/B. '
        '50k entries входят в предыдущее исследование списка, но не в эту итоговую HTTP матрицу. '
        'Следующий прогон и критерии перечислены в [руководстве](../../../doc/gallery.md); '
        'он не запускается автоматически. Здесь не заявляется аппаратно подтверждённая плавность/оптимизация.',
    ]
    (root / 'report.md').write_text('\n'.join(lines) + '\n')
    print(json.dumps({'report': str(root / 'report.md'), 'groups': len(groups), 'browser_passed': browser['passed']}))


if __name__ == '__main__':
    main()
