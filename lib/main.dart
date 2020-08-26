import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medico_app/src/app.dart';

import 'src/cubit/generic_state/app_cubit_observer.dart';
import 'src/di/AppInjector.dart';

void main() {
 
 WidgetsFlutterBinding.ensureInitialized();
    AppInjector.create();
   
    Bloc.observer = MyBlocObserver();
  runApp(App());
}

