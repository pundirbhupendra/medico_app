import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medico_app/src/cubit/generic_state/generic_state.dart';
import 'package:medico_app/src/data/http_exception.dart';
import 'package:medico_app/src/data/repositories/auth_repo/auth_repo.dart';
import 'package:medico_app/src/di/AppInjector.dart';
import 'package:medico_app/src/presentation/utils/conection_check.dart';

import 'login_sate.dart';

class LoginCubit extends Cubit<LoginState> with ConnectivityChecker {
  LoginCubit() : super(LoginStateInitial());
  var _authRepo = AppInjector.get<AuthRepository>();
  onUserLogin(String phoneNumber, String password) async {
    try {
      if (!await isConnected()) {
        emit(LoginStateFailure(message: "Check Your Internet"));
         return;
      }
      emit(LoginStateInProgress());
      final result = await _authRepo.onLogin(phoneNumber, password);
      emit(LoginSuccessWithData(result));
    } on DioError catch (e) {
      if (e.response.statusCode == 400) {
        emit(LoginStateFailure(
            message:
                 e.response.data["user"]["non_field_errors"][0]));
      }else if(e.response.statusCode == 401){
          emit(LoginStateFailure(
            message:
                 e.response.data["user"]["detail"] ));
      }else{
        emit(LoginStateFailure(
            message:"Try Again" ));
      }
    } on HttpException catch (e) {
      emit(LoginStateFailure(message: e.toString()));
    } catch (e) {
      emit(LoginStateFailure(message: e.toString()));
    }
  }

}