import 'package:config_app/features/config/presentation/bloc/config_bloc.dart';
import 'package:config_app/features/config/presentation/bloc/config_bloc_models.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:dslideshow_backend/config.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/controlled_photoframe_repository.dart';

void main() {
  late ControlledPhotoframeRepository repository;
  late ConfigBloc bloc;
  late List<ConfigState> states;

  setUp(() {
    repository = ControlledPhotoframeRepository();
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

  test(
    'invalid effect settings are rejected before sending the draft',
    () async {
      final draft = _config(8081);
      draft.slideshow.effects = EffectsConfig(
        items: {
          EffectType.mosaic: const EffectConfig(
            enabled: true,
            options: MosaicEffectOptions(gridSize: 99),
          ),
        },
      );
      bloc.add(ConfigEvent.save(draft));
      await pumpEventQueue();
      expect(states, [isA<ConfigErrorState>()]);
      expect(repository.saved, isEmpty);
      expect(repository.saves, isEmpty);
      expect(
        (draft.slideshow.effects.get(EffectType.mosaic).options
                as MosaicEffectOptions)
            .gridSize,
        99,
      );
    },
  );

  test('acknowledges save before publishing its isolated snapshot', () async {
    final draft = _config(8081);
    draft.slideshow.effects = EffectsConfig(
      items: {
        EffectType.fade: EffectConfig.defaults(EffectType.fade)
            .copyWith(enabled: true),
      },
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
      EffectType.mosaic,
      EffectConfig.defaults(EffectType.mosaic).copyWith(enabled: true),
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
    expect(acknowledged.slideshow.effects.items.keys.single, EffectType.fade);
    expect(draft.webServer.port, 9090);
  });

  test(
    'save isolates nested camera settings while waiting for acknowledgement',
    () async {
      final draft = _config(8081);
      draft.slideshow.specialScreens.add(
        SpecialScreenConfig(
          id: 'cameras',
          type: SpecialScreenType.cameras,
          options: CamerasScreenOptions(
            cameras: [CameraConfig(id: 'front', url: 'https://cam/front')],
          ),
        ),
      );
      final cameras =
          (draft.slideshow.specialScreens.single.options
                  as CamerasScreenOptions)
              .cameras;
      bloc.add(ConfigEvent.save(draft));
      await pumpEventQueue();
      cameras.single.url = 'https://cam/edited';
      cameras.add(CameraConfig(id: 'back', url: 'https://cam/back'));
      repository.saves.single.complete(const WSResultOk(id: 1));
      await pumpEventQueue();
      final acknowledged = (bloc.state as ConfigLoadedState).config;
      final savedCameras =
          (acknowledged.slideshow.specialScreens.single.options
                  as CamerasScreenOptions)
              .cameras;
      expect(savedCameras.single.url, 'https://cam/front');
      expect(cameras, hasLength(2));
    },
  );

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
