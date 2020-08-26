import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medico_app/src/cubit/generic_state/generic_state.dart';
import 'package:medico_app/src/cubit/registrationCubit/registration_cubit.dart';
import 'package:medico_app/src/data/service/shared_preferences_service.dart';
import 'package:medico_app/src/di/AppInjector.dart';
import 'package:medico_app/src/presentation/utils/common_toast.dart';
import 'package:medico_app/src/presentation/utils/validator.dart';
import 'package:medico_app/src/presentation/widget/common_button.dart';
import 'package:medico_app/src/res/app_color.dart';
import 'package:medico_app/src/res/style.dart';
import 'package:medico_app/src/route/router.gr.dart';

class RagistrationPage extends StatefulWidget {
  @override
  _RagistrationPageState createState() => _RagistrationPageState();
}

class _RagistrationPageState extends State<RagistrationPage> {
  var focusEmail = FocusNode();

  var focusMobileNumber = FocusNode();
  var focusPassword = FocusNode();
  var confirmPassword = FocusNode();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = true;
  bool confirmpas = true;
  var email;
  var phoneNumber;
  var password;
  var age;
  RegistrationCubit authCubit = AppInjector.get<RegistrationCubit>();
  var focusAge = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SharedPreferencesService prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColors.primaryColor,
        ),
        body: BlocConsumer<RegistrationCubit, GenericState>(
          cubit: authCubit,
          listener: (BuildContext context, GenericState state) {
            if (state is SuccessWithData) {
              // Fluttertoast.showToast(textColor: Colors.red, msg: state.success);
            }
          },
          builder: (BuildContext contex, GenericState state) {
            if (state is SuccessWithData) {
              showMessage(state.success);

              _saveUserDetails();
              _navigateToRegistration(context);
            }

            return Form(
              key: formKey,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.all(20.0),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        <Widget>[
                          TextFormField(
                              autofocus: true,
                              maxLength: 10,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                              onSaved: (mobileNo) {
                                phoneNumber = mobileNo;
                              },
                              onChanged: (val) {},
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.phone,
                              focusNode: focusMobileNumber,
                              validator: (val) =>
                                  Validator().validateMobile(val),
                              onFieldSubmitted: (val) {
                                focusMobileNumber.unfocus();
                                FocusScope.of(context).requestFocus(focusEmail);
                              },
                              decoration:
                                  inputDecoration(hint: "Mobile Number")),
                          SizedBox(height: 20),
                          TextFormField(
                              autofocus: true,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                              onSaved: (emailId) {
                                email = emailId;
                              },
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              focusNode: focusEmail,
                              validator: (val) =>
                                  Validator().validateEmail(val),
                              onFieldSubmitted: (val) {
                                focusEmail.unfocus();
                                FocusScope.of(context).requestFocus(focusAge);
                              },
                              decoration: inputDecoration(hint: "Email")),
                          SizedBox(height: 20),
                          TextFormField(
                              autofocus: true,
                              maxLength: 2,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                              onSaved: (ages) {
                                age = ages;
                              },
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              focusNode: focusAge,
                              validator: (val) {
                                if (val == "") {
                                  return "This is required";
                                }
                              },
                              onFieldSubmitted: (val) {
                                focusAge.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(focusPassword);
                              },
                              decoration: inputDecoration(hint: "Age")),
                          SizedBox(height: 20),
                          TextFormField(
                            cursorColor: Colors.white,

                            obscureText: passwordVisible,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                            onSaved: (pass) {
                              password = pass;
                            },

                            controller: passwordController,
                            autofocus: true,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            focusNode: focusPassword,
                            validator: (val) =>
                                Validator().validatePassword(val),
                            onFieldSubmitted: (val) {
                              focusPassword.unfocus();
                              FocusScope.of(context)
                                  .requestFocus(confirmPassword);
                            },
                            //  decoration: inputDecoration(hint: "Password")
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
                            ),
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            obscureText: confirmpas,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                            autofocus: true,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            focusNode: confirmPassword,
                            onSaved: (confirmPass) {},
                            validator: (val) => Validator().passwordDoNotMatch(
                                val, passwordController.text),
                            onFieldSubmitted: (val) {
                              confirmPassword.unfocus();
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    confirmpas
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    size: 16,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      confirmpas = !confirmpas;
                                    });
                                  }),
                              hintText: 'Confirm Password',
                            ),
                          ),
                          SizedBox(height: 20),
                          Column(
                            children: [
                              CommonButton(
                                title: 'Submit',
                                width: 150,
                                titleColor: AppColors.primaryColor,
                                onTap: () async {
                                  //await SmsAutoFill().listenForCode;
                                  if (formKey.currentState.validate()) {
                                    formKey.currentState.save();

                                    Map data = {
                                      "email": email,
                                      "password": password,
                                      "age": age,
                                      "phone_number": phoneNumber
                                    };
                                    authCubit.onUserRegistration(data);
                                  }
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          BlocBuilder<RegistrationCubit, GenericState>(
                              cubit: authCubit,
                              builder:
                                  (BuildContext contex, GenericState state) {
                                if (state is Failure) {
                                  showMessage(state.message);
                                }
                                if (state is InProgress) {
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
                              })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }

  _navigateToRegistration(BuildContext context) async {
    await Navigator.pushReplacementNamed(context, Router.otpPage);
  }

  _saveUserDetails() async {
    try {
      prefs = await SharedPreferencesService.instance;
      prefs.setUserPhoneNo(phoneNumber);
    } catch (e) {}
  }
}
