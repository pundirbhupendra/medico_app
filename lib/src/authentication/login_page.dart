import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medico_app/src/cubit/login/login_cubit.dart';
import 'package:medico_app/src/cubit/login/login_sate.dart';
import 'package:medico_app/src/data/service/shared_preferences_service.dart';
import 'package:medico_app/src/di/AppInjector.dart';
import 'package:medico_app/src/presentation/utils/common_toast.dart';
import 'package:medico_app/src/presentation/utils/validator.dart';
import 'package:medico_app/src/presentation/widget/common_button.dart';
import 'package:medico_app/src/res/app_color.dart';
import 'package:medico_app/src/res/style.dart';
import 'package:medico_app/src/route/router.gr.dart';

class LoginPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<LoginPage> {
  String _code;
  String signature = "{{ app signature }}";

  final _focusMobileNo = FocusNode();
  final _focusPassword = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _authCubit = AppInjector.get<LoginCubit>();
  var phoneNo;
  var password;
  bool passwordVisible = true;
  TextEditingController controller = TextEditingController();
  SharedPreferencesService prefs;
  @override
  _getUserCredential() async {
    prefs = await SharedPreferencesService.instance;

    if (prefs.getUserPhoneNo() != null) {
      // setState(() {
      controller.text = prefs.getUserPhoneNo();
      //});
    }
  }

  @override
  void dispose() {
    //  SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocConsumer<LoginCubit, LoginState>(
                  cubit: _authCubit,
                  listener: (_, state) {
                    if (state is LoginStateFailure) {
                      showMessage(state.message);
                    }
                  },
                  builder: (BuildContext context, state) {
                    if (state is LoginStateInitial) {
                      _getUserCredential();
                    }
                    if (state is LoginSuccessWithData) {
                      if (state.loginResponse.user.otp) {
                        showMessage("You Are Login!");
                        _navigateToHomePage(context);
                      } else {
                        showMessage("Please Verify Otp first!");
                        _navigateToOtpPage(context);
                      }
                    }

                    return Column(
                      children: [
                        TextFormField(
                            autofocus: false,
                            maxLength: 10,
                            controller: controller,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                            onSaved: (phoneNum) {
                              phoneNo = phoneNum;
                            },
                            focusNode: _focusMobileNo,
                            validator: (val) => Validator().validateMobile(val),
                            onFieldSubmitted: (val) {
                              _focusMobileNo.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(_focusPassword);
                            },
                            decoration: inputDecoration(hint: "Mobile")),
                        SizedBox(height: 20),
                        TextFormField(
                            obscureText: passwordVisible,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                            autofocus: true,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            onSaved: (pass) {
                              password = pass;
                            },
                            focusNode: _focusPassword,
                            validator: (val) =>
                                Validator().validatePassword(val),
                            onFieldSubmitted: (val) {
                              _focusPassword.unfocus();
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            decoration: InputDecoration(
                              hoverColor: Colors.white,
                              focusColor: Colors.white,
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    size: 16,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  }),
                              hintText: 'Password',
                            )),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                controller.clear();
                              },
                              child: Text(
                                "CLEAR",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        CommonButton(
                          title: 'LOGIN',
                          titleColor: AppColors.primaryColor,
                          onTap: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              _authCubit.onUserLogin(controller.text, password);
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        BlocBuilder<LoginCubit, LoginState>(
                            cubit: _authCubit,
                            builder: (c, state) {
                              if (state is LoginStateInProgress) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    value: null,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            }),
                      ],
                    );
                  })),
        ),
      ),
    );
  }

  _navigateToHomePage(BuildContext context) async {
    await Navigator.pushReplacementNamed(context, Router.homePage);
  }

  _navigateToOtpPage(BuildContext context) async {
    try {
      await Navigator.pushReplacementNamed(context, Router.otpPage);
    } catch (e) {}
  }
}
