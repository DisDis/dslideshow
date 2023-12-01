import 'package:bloc/bloc.dart';
import 'package:config_app/src/repository/user_repository.dart';
import 'package:dslideshow_backend/command.dart';
import 'package:equatable/equatable.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final UserRepository userRepository;
  HomeCubit({
    required this.userRepository,
  }) : super(const HomeState());

  void setTab(HomeTab tab) => emit(HomeState(tab: tab));

  Future<WebSocketResult> echo() async {
    return userRepository.client!.send(WSEchoCommand(id: WebSocketCommand.generateId(), msg: 'Message - ${DateTime.now().toString()}'));
  }

  Future<WebSocketResult> echoError() async {
    return userRepository.client!.send(WSEchoCommand(id: WebSocketCommand.generateId(), msg: 'ERROR'));
  }
}
