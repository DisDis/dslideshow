import 'package:bloc/bloc.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:dslideshow_backend/command.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final RealtimeService realtimeService;
  HomeCubit({
    required this.realtimeService,
  }) : super(const HomeState());

  void setTab(HomeTab tab) => emit(HomeState(tab: tab));

  Future<WebSocketResult> echo() async {
    return realtimeService.send(WSEchoCommand(id: WebSocketCommand.generateId(), msg: 'Message - ${DateTime.now().toString()}'));
  }

  Future<WebSocketResult> echoError() async {
    return realtimeService.send(WSEchoCommand(id: WebSocketCommand.generateId(), msg: 'ERROR'));
  }
}
