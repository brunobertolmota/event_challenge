import 'package:dio/dio.dart';
import 'package:event_challenge/features/auth/client/user_client.dart';
import 'package:event_challenge/features/auth/controller/login_controller.dart';
import 'package:event_challenge/features/auth/service/auth_firebase_service.dart';
import 'package:event_challenge/features/events/controller/events_controller.dart';
import 'package:event_challenge/features/service/events_service.dart';
import 'package:event_challenge/features/service/shared_preference.dart';
import 'package:event_challenge/shared/core/client/cache_client.dart';
import 'package:event_challenge/shared/core/client/client.dart';
import 'package:event_challenge/shared/core/client/dio_implement.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static void initializeDependencies() {
    //firebase
    getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);

    getIt.registerFactory<Dio>(
      //pode ser adicionado varias opcoes ao dio
      () => Dio(),
    );
    getIt.registerFactory<ApiClient>(
      () => DioClientImpl(
        client: getIt<Dio>(),
      ),
    );

    getIt.registerFactory<LocalStorage>(
      () => SharedPreferenceTestImpl(),
    );
    // getIt.registerFactory<CacheStore>(
    //   () => SharedPreferenceTestImpl(prefs: getIt<SharedPreferences>()),
    // );

    getIt.registerFactory<GetDataRepoService>(
      () => GetDataRepoService(
        client: getIt<ApiClient>(),
      ),
    );

    //user
    getIt.registerFactory<UserLoginClient>(
      () => AuthFirebaseServiceImpl(
        auth: getIt<FirebaseAuth>(),
      ),
    );

    getIt.registerSingleton<LoginController>(
      LoginController(
        authService: getIt<UserLoginClient>(),
      ),
    );

    //pode ser feito um singleton
    getIt.registerSingleton<EventsController>(
      EventsController(
        remoteService: getIt<GetDataRepoService>(),
        localStorageService: getIt<LocalStorage>(),
      ),
    );
  }
}
