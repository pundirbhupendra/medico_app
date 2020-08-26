import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medico_app/src/cubit/otp/otp_state.dart';
import 'package:medico_app/src/data/repositories/auth_repo/auth_repo.dart';
import 'package:medico_app/src/di/AppInjector.dart';
import 'package:medico_app/src/presentation/utils/conection_check.dart';

class OtpCubit extends Cubit<OTpState> with ConnectivityChecker {
  OtpCubit() : super(OTpStateInitial());
  AuthRepository _authRepo = AppInjector.get<AuthRepository>();

  verifyOtP(String otp) async {
    try {
      if (!await isConnected()) {
        emit(OtpStateFailure(message: "Check Your Internet"));
        return;
      }

      emit(OtpStateInProgress());
     final result = await _authRepo.verifyOtp(otp);
      emit(OtpSuccess(result));
    } on DioError catch (e) {
      if (e.response.statusCode == 202 || e.response.statusCode==  404) {
        emit(OtpStateFailure(message: e.response.data["message"]));
      } else if(e.response.statusCode ==401){
         emit(OtpStateFailure(message: e.response.data["detail"]));
      }else{
        emit(OtpStateFailure(message: "Try Again"));
      }
    } catch (e) {
      emit(OtpStateFailure(message: e.toString()));
    }
  }

  otpResendToUser() async {
    try {
      if (!await isConnected()) {
        emit(OtpStateFailure(message: "Check Your Internet"));
        return;
      }

      emit(OtpStateInProgress());
      final result = await _authRepo.otpsResend();
      emit(OtpSuccess(result));
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        emit(OtpStateFailure(message:e.response.data["detail"] ));
      }else if(e.response.statusCode ==400){
        emit(OtpStateFailure(message:e.response.data["message"]));
      }
    } catch (e) {
      emit(OtpStateFailure(message: e.toString()));
    }
  }
  
  
}
