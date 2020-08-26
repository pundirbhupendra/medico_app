import 'package:get_it/get_it.dart';
import 'package:medico_app/src/cubit/login/login_cubit.dart';
import 'package:medico_app/src/cubit/otp/otp_cubit.dart';
import 'package:medico_app/src/cubit/registrationCubit/registration_cubit.dart';
import 'package:medico_app/src/data/repositories/auth_repo/auth_repo.dart';
import 'package:medico_app/src/data/service/api_service.dart';

GetIt _injector = GetIt.I;

class AppInjector {
  static final AppInjector _singleton = AppInjector._internal();

  factory AppInjector() => _singleton;

  AppInjector._internal();

  static T get<T>({String instanceName, dynamic param1, dynamic param2}) =>
      _injector<T>(instanceName: instanceName, param1: param1, param2: param2);


  static void create() {
    _initCubits();
    _initRepository();
   // _initNotifiers();
  }

  static void _initCubits() {
    _injector.registerFactory(() => RegistrationCubit());
     _injector.registerFactory(() => LoginCubit());
      _injector.registerFactory(() => OtpCubit());
  }

  static void _initRepository() {
    _injector.registerFactory(() => AuthRepository(ApiService()));
  }

  static void _initNotifiers() {}
}
