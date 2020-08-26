import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medico_app/src/cubit/generic_state/generic_state.dart';
import 'package:medico_app/src/data/http_exception.dart';
import 'package:medico_app/src/data/repositories/auth_repo/auth_repo.dart';
import 'package:medico_app/src/di/AppInjector.dart';
import 'package:medico_app/src/presentation/utils/conection_check.dart';

class RegistrationCubit extends Cubit<GenericState> with ConnectivityChecker {
  RegistrationCubit() : super(Initial());
  AuthRepository _authRepo = AppInjector.get<AuthRepository>();

  onUserRegistration(Map<dynamic, dynamic> data) async {
    try {
      if (!await isConnected()) {
        emit(Failure(message: "Check Your Internet"));
        return;
      }
      emit(InProgress());
      final result = await _authRepo.onRegistration(data);
      emit(SuccessWithData(result));
    } on DioError catch (e) {
      if (e.response.statusCode == 400) {
        if(e.response.data["user"]["phone_number"] !=null){
          emit(Failure(message: e.response.data["user"]["phone_number"][0]));
        } else if(e.response.data["user"]["password"] !=null){
 emit(Failure(message: e.response.data["user"]["phone_number"][0]));
        } else if(e.response.data["user"]["email"] !=null){
           emit(Failure(message: e.response.data["user"]["phone_number"][0]));
        }
       
      } else {
         emit(Failure(message: "Try Again"));
      }
    } on HttpException catch (e) {
      emit(Failure(message: e.message));
    } catch (e) {
      emit(Failure(message: e.toString()));
    }
  }
}
