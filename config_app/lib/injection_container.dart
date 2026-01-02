// import 'package:dio/dio.dart';
import 'package:config_app/features/auth/domain/repository/authentication_repository.dart';
import 'package:config_app/features/auth/presentation/bloc/authentication_bloc.dart';
import 'package:config_app/features/config/data/repository/photoframe_repository.dart';
import 'package:config_app/features/permission/domain/services/permission_service.dart';
import 'package:config_app/features/realtime/data/services/client_service.dart';
import 'package:config_app/features/realtime/domain/services/realtime_service.dart';
import 'package:config_app/features/upload/presentation/bloc/upload_queue_bloc.dart';
import 'package:config_app/features/user/domain/repository/user_repository.dart';
import 'package:config_app/features/auth/data/repository/authentication_repository.dart';
import 'package:config_app/features/user/data/repository/user_repository.dart';
import 'package:get_it/get_it.dart';
// import 'package:wa_api_gen/wa_api_gen.dart';
// import 'package:wa_common/environment.dart';
// import 'package:wa_common/injection_container.dart' as common;
// import 'package:wa_admin_rights/injection_container.dart' as admin_rights;
// import 'package:workagree_app/src/providers/scaffold_provider_impl.dart';

final sl = GetIt.instance;
Future<void> initializeAllDependencies(
    {String? apiUrl,
    String webSocketHost = "localhost",
    int webSocketPort = 8000}) async {
  sl.registerSingleton<RealtimeService>(ClientServiceImpl());
  sl.registerSingleton<UserRepository>(UserRepositoryImpl());
  sl.registerSingleton<AuthenticationRepository>(
      AuthenticationRepositoryImpl(client: sl()));
  sl.registerSingleton<PhotoframeRepository>(PhotoframeRepository(sl()));

  sl.registerSingleton<UploadQueueBloc>(UploadQueueBloc(client: sl()));
  
  sl.registerSingleton<PermissionService>(PermissionService());

  sl.registerSingleton(AuthenticationBloc(
    authenticationRepository: sl(),
    permissionService: sl(),
    // ignore: no-equal-arguments
    userRepository: sl(),
  ));

  /*final api = WaApiGen(interceptors: [], basePathOverride: apiUrl);
  sl.registerSingleton<Dio>(api.dio);
  configHttpAdapter(api.dio);
  
  await chat.initializeDependencies();
  */
}
