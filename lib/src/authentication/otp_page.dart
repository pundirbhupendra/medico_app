import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medico_app/src/cubit/otp/otp_cubit.dart';
import 'package:medico_app/src/cubit/otp/otp_state.dart';
import 'package:medico_app/src/di/AppInjector.dart';
import 'package:medico_app/src/presentation/utils/common_toast.dart';
import 'package:medico_app/src/presentation/widget/common_button.dart';
import 'package:medico_app/src/res/app_color.dart';
import 'package:medico_app/src/route/router.gr.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  //with CodeAutoFill
  String appSignature;

  String otpCode;
  OtpCubit _otpCubit = AppInjector.get<OtpCubit>();
  bool isShowResendButton = false;

  @override
  void initState() {
    super.initState();
 
    // listenForCode();

    // SmsAutoFill().getAppSignature.then((signature) {
    //   setState(() {
    //     appSignature = signature;
    //   });
    // });
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //  // cancel();
  // }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: BlocConsumer<OtpCubit, OTpState>(
          cubit: _otpCubit,
          listener: (BuildContext context, OTpState state) {},

          builder: (BuildContext context, OTpState state) {

           
            if (state is OtpStateFailure) {
              showMessage(state.message);
            }
            if (state is OtpSuccess) {
              showMessage(state.success);

             _navigateToLogin(context);
            }

            return Form(
              key: _formKey,
              child: Column(
                children: [
                  PinFieldAutoFill(
                    
                    controller: otpController,
                    decoration: UnderlineDecoration(
                        textStyle:
                            TextStyle(fontSize: 15, color: Colors.white)),
                    currentCode: otpCode,
                    onCodeSubmitted: (code) {
                      print(code);
                    },
                    onCodeChanged: (code) {
                      if (code.length == 6) {
                        // FocusScope.of(context).requestFocus(FocusNode());
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  CommonButton(
                    title: 'Verify',
                    titleColor: AppColors.primaryColor,
                    onTap: () {
                      if (_formKey.currentState.validate() ||otpController.text.length == 6 ) {
                        _otpCubit.verifyOtP(otpController.text);
                      }
                      //
                    },
                  ),
                  SizedBox(height: 20),
                 Visibility(
                   visible: isShowResendButton,
                   child:  CommonButton(
                    width: 50,
                    title: 'ReSend',
                    titleColor: AppColors.primaryColor,
                    onTap: () {
                      _otpCubit.otpResendToUser();
                      // if (_formKey.currentState.validate() ||otpController.text.length == 6 ) {
                        _otpCubit.otpResendToUser();
                      // }
                      //
                    },
                  ),),
                  SizedBox(height: 20),
                  BlocBuilder<OtpCubit, OTpState>(
                      cubit: _otpCubit,
                     
                      builder: (BuildContext context, OTpState state) {
                         if(state is OTpStateInitial){
                          if(!isShowResendButton){
                             return _startCounter(context);
                          }
            }
                        if (state is OtpStateInProgress) {
                          return Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              value: null,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          );
                        } 

                        return SizedBox();
                      })
                ],
              ),
            );
          }),
    );
  }

  // @override
  // void codeUpdated() {
  //   setState(() {
  //     otpCode = code;
  //   });
  // }
  _navigateToLogin(BuildContext context) async {
    await Navigator.pushReplacementNamed(context, Router.loginPage);
  }
  _startCounter(BuildContext context) {
  return Center(
      child: CircularCountDownTimer(
    duration: 60,
  
    width: MediaQuery.of(context).size.width * 0.3,
    height: MediaQuery.of(context).size.height * 0.3,
    color: Colors.white38,
    fillColor: Colors.black12,
    strokeWidth: 4.0,
    textStyle:GoogleFonts.satisfy(
      color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold
    ),
    isReverse: true,
    isTimerTextShown: true,
    onComplete: () {
      setState(() {
        isShowResendButton = true;
      });
    },
  ));
}
}