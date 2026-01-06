import 'package:dslideshow_backend/config.dart';
import 'package:dslideshow_backend/storage.dart';
import 'package:dslideshow_flutter/environment.dart';
import 'package:dslideshow_flutter/features/header/presentation/widgets/common_header.dart';
import 'package:dslideshow_flutter/features/menu/presentation/widgets/mainmenu.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_event.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/slideshow_state.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/bloc/status/slideshow_status_bloc.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/debug_widget.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/fade_widget.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/fixed_animation_controller.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/image_widget.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/slideshow_loader_widget.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/state_notify_widget.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/system_info_widget.dart';
import 'package:dslideshow_flutter/features/slideshow/presentation/widgets/video_widget.dart';
import 'package:dslideshow_flutter/src/effect/media_slider_item_effect.dart';
import 'package:dslideshow_flutter/src/injector.dart';
import 'package:dslideshow_flutter/src/service/frontend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

class SlideShowPage extends StatelessWidget {
  const SlideShowPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Инициализация Блока при входе на страницу
    context.read<SlideshowBloc>().add(const SlideshowInitEvent());

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          // Рендеринг слайдшоу (Stateful часть для анимаций)
          const _SlideshowRenderer(),

          // Оверлеи (Инфо, Меню, Дебаг, Fade)
          const _SlideshowOverlays(),

          // Хедер
          const CommonHeaderWidget(),
        ],
      ),
    );
  }
}

// Отдельный виджет для Оверлеев (для чистоты кода)
class _SlideshowOverlays extends StatelessWidget {
  const _SlideshowOverlays();

  @override
  Widget build(BuildContext context) {
    final FrontendService frontendService = injector();
    final AppConfig appConfig = injector();

    return BlocBuilder<SlideshowStatusBloc, SlideshowStatusState>(
      builder: (context, state) {
        return Stack(
          children: <Widget>[
            StateNotify(isPaused: state.isPaused),
            if (state.isInfo) const SystemInfoWidget(),
            if (state.isMenu) const MainMenuWidget(),
            if (!isLinuxEmbedded && state.isDebug)
              DebugWidget(frontendService, appConfig),
          ],
        );
      },
    );
  }
}

// Stateful виджет для управления контроллерами анимации и прекэшем
// Логика принятия решений вынесена в Bloc, здесь только исполнение.
class _SlideshowRenderer extends StatefulWidget {
  const _SlideshowRenderer();

  @override
  _SlideshowRendererState createState() => _SlideshowRendererState();
}

class _SlideshowRendererState extends State<_SlideshowRenderer>
    with TickerProviderStateMixin {
  static final Logger _log = Logger('_SlideshowRendererState');

  late FixedAnimationController _effectController;
  late AnimationController _fadeController; // Для Screen Lock

  Widget _currentWidget = slideShowLoaderWidget;
  Widget _nextWidget = slideShowLoaderWidget;
  Widget _transitionWidget = slideShowLoaderWidget;

  final AppConfig _appConfig = injector();

  @override
  void initState() {
    super.initState();

    _effectController = FixedAnimationController(
      duration: Duration(milliseconds: _appConfig.slideshow.transitionTimeMs),
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
    );

    _effectController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Меняем виджеты местами
        setState(() {
          _currentWidget = _nextWidget;
        });
        imageCache.clear();

        // Сообщаем блоку, что переход завершен
        context.read<SlideshowBloc>().add(
          const SlideshowTransitionCompleteEvent(),
        );
        _effectController.reset();
      }
    });

    _fadeController = AnimationController(
      duration: Duration(milliseconds: _appConfig.slideshow.fadeTimeMs),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _effectController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<SlideshowBloc, SlideshowState>(
      listener: (context, state) {
        // 1. Логика затемнения экрана (Screen Lock)
        if (state.fadeOut) {
          _fadeController.forward();
        } else {
          _fadeController.reverse();
        }

        // 2. Логика Precache (Загрузка изображения)
        if (state.phase == SlideshowPhase.precaching &&
            state.nextItem != null) {
          _handlePrecache(state.nextItem!, size);
        }

        // 3. Логика запуска Транзакции
        if (state.phase == SlideshowPhase.transition) {
          _startTransition(state, size);
        }
      },
      buildWhen: (prev, curr) {
        // Перерисовываем только если мы в фазе транзакции (чтобы показать transitionWidget)
        // Или если это первоначальная загрузка
        return prev.phase != curr.phase;
      },
      builder: (context, state) {
        return Stack(
          children: [
            // Основной контент
            SizedBox(
              width: size.width,
              height: size.height,
              // Если идет транзакция, показываем transitionWidget (где крутится анимация),
              // иначе просто текущий виджет.
              child: state.phase == SlideshowPhase.transition
                  ? _transitionWidget
                  : _currentWidget,
            ),

            // Fade Widget (Черный экран поверх)
            FadeWidget(animation: _fadeController),
          ],
        );
      },
    );
  }

  // Создание виджета и прекэш
  Future<void> _handlePrecache(MediaItem mediaItem, Size size) async {
    final itemWidget = mediaItem.isVideo
        ? VideoWidget(mediaItem)
        : ImageWidget(mediaItem, _appConfig.slideshow, size);

    try {
      if (itemWidget is ImageWidget) {
        await itemWidget.precache(context);
      }

      if (mounted) {
        setState(() {
          _nextWidget = SizedBox(
            width: size.width,
            height: size.height,
            child: itemWidget,
          );
        });
        // Сообщаем блоку, что картинка готова к показу
        context.read<SlideshowBloc>().add(const SlideshowImageReadyEvent());
      }
    } catch (e, st) {
      _log.warning(
        'Error loading file: "${mediaItem.uri?.toFilePath()}"',
        e,
        st,
      );
      // В случае ошибки загружаем лоадер как fallback
      setState(() {
        _nextWidget = slideShowLoaderWidget;
      });
      // Все равно сообщаем о готовности, чтобы не заблокировать очередь
      // ignore: use_build_context_synchronously
      context.read<SlideshowBloc>().add(const SlideshowImageReadyEvent());
    }
  }

  // Создание виджета перехода (старая логика AnimatedBuilder + createTransformWidget)
  void _startTransition(SlideshowState state, Size size) {
    // Получаем эффект из стейта
    MediaSliderItemEffect currentEffect = state.effect.createEffect();

    setState(() {
      _transitionWidget = AnimatedBuilder(
        key: UniqueKey(), // Важно для пересоздания анимации
        animation: _effectController,
        builder: (context, _) {
          return currentEffect.createTransformWidget(
            context,
            _currentWidget,
            _nextWidget,
            _effectController,
            size.width,
            size.height,
          );
        },
      );
    });

    // Запускаем анимацию
    try {
      _effectController.forward();
    } catch (e) {
      _log.info('Animation skip', e);
    }
  }
}
