import 'dart:io';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medico_app/src/presentation/utils/validator.dart';
import 'package:medico_app/src/presentation/widget/comman_alertbox.dart';
import 'package:medico_app/src/presentation/widget/common_button.dart';
import 'package:medico_app/src/res/app_color.dart';
import 'package:medico_app/src/res/style.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _getBodyTab,
    );
  }

  get _getBodyTab {
    return ListView(
      shrinkWrap: true,
      children: [
        Card(
          child: TabBar(
              indicator: BubbleTabIndicator(
                indicatorColor: Colors.blue,
                indicatorHeight: 30,
                indicatorRadius: 2.0,
                tabBarIndicatorSize: TabBarIndicatorSize.tab,
              ),
              onTap: (v) {},
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              indicatorColor: AppColors.primaryColor,
              controller: tabController,
              tabs: [
                Tab(
                  child: Text('Personal'),
                ),
                Tab(child: Text('Medical')),
                Tab(child: Text('LifeStyle')),
              ]),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: TabBarView(
              physics: AlwaysScrollableScrollPhysics(),
              controller: tabController,
              children: [
                Personal(),
                Medical(),
                Personal(),
              ]),
        )
      ],
    );
  }
}

class Personal extends StatefulWidget {
  @override
  _PersonalState createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
DateTime selectedDate = DateTime.now();
  Future<File> selectFile;
TextEditingController _date = new TextEditingController();
  bool _isLoading = true;
  //final dateFormat = DateFormat("dd-M-yyyy");

  FocusNode name = FocusNode();

  FocusNode contNumber = FocusNode();

  FocusNode emailId = FocusNode();

  FocusNode gender = FocusNode();

  FocusNode maritalStatus = FocusNode();

  FocusNode height = FocusNode();

  FocusNode weight = FocusNode();

  FocusNode dateofBirth = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        shrinkWrap: true,
        children: [
          Stack(
            fit: StackFit.loose,
            alignment: Alignment.center,
            children: [
              InkWell(
                onTap: () {
                  _takeImageFromCamera(context);
                },
                child: Align(
                  alignment: Alignment.center,
                  child: AnimatedPadding(
                    duration: Duration(microseconds: 200),
                    padding: EdgeInsets.all(1),
                    child: CircleAvatar(
                      minRadius: 20,
                      maxRadius: 35,
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 50,
                  right: 130,
                  child: Icon(
                    Icons.camera_alt,
                    color: AppColors.primaryColor,
                    size: 20,
                  )),
            ],
          ),
          SizedBox(height: 10),
          Text("Name"),
          TextFormField(
              onSaved: (mobileNo) {},
              onChanged: (val) {},
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              focusNode: name,
              validator: (val) => Validator().validateName(val),
              onFieldSubmitted: (val) {
                name.unfocus();
                //FocusScope.of(context).requestFocus(focusEmail);
              },
              decoration: normalInputDecoration(hint: "Name")),
          TextFormField(
              readOnly: true,
              onSaved: (mobileNo) {},
              onChanged: (val) {},
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              focusNode: contNumber,
              //validator: (val) =>
              // Validator().validateMobile(val),
              onFieldSubmitted: (val) {
                contNumber.unfocus();
                FocusScope.of(context).requestFocus(emailId);
              },
              decoration: normalInputDecoration(hint: "Contact Number")),
          TextFormField(
              style: TextStyle(color: Colors.white, fontSize: 15),
              onSaved: (mobileNo) {},
              onChanged: (val) {},
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              focusNode: emailId,
              //validator: (val) =>
              // Validator().validateMobile(val),
              onFieldSubmitted: (val) {
                emailId.unfocus();
                FocusScope.of(context).requestFocus(emailId);
              },
              decoration: normalInputDecoration(hint: "Email Id")),
          TextFormField(
              onSaved: (mobileNo) {},
              onChanged: (val) {},
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              focusNode: gender,
              //validator: (val) =>
              // Validator().validateMobile(val),
              onFieldSubmitted: (val) {
                gender.unfocus();
                FocusScope.of(context).requestFocus(dateofBirth);
              },
              decoration: normalInputDecoration(hint: "Gender")),
          TextFormField(
              onSaved: (mobileNo) {},
              onChanged: (val) {},
              
              readOnly: true,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
             // focusNode: dateofBirth,
              controller: _date,
              onTap: (){
                  FocusScope.of(context).requestFocus(FocusNode());
                 buildMaterialDatePicker(context);
              },
             
              //validator: (val) =>
              // Validator().validateMobile(val),
              onFieldSubmitted: (val) {
               
              
              },
              decoration: normalInputDecoration(hint: "Date of Birth")),
          TextFormField(
              onSaved: (mobileNo) {},
              onChanged: (val) {},
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              focusNode: maritalStatus,
              //validator: (val) =>
              // Validator().validateMobile(val),
              onFieldSubmitted: (val) {
                maritalStatus.unfocus();
                FocusScope.of(context).requestFocus(height);
              },
              decoration: normalInputDecoration(hint: "Marital Status")),
          TextFormField(
              onSaved: (mobileNo) {},
              onChanged: (val) {},
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: height,
              //validator: (val) =>
              // Validator().validateMobile(val),
              onFieldSubmitted: (val) {
                height.unfocus();
                FocusScope.of(context).requestFocus(height);
              },
              decoration: normalInputDecoration(hint: "Height")),
          TextFormField(
              onSaved: (mobileNo) {},
              onChanged: (val) {},
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: weight,
              //validator: (val) =>
              // Validator().validateMobile(val),
              onFieldSubmitted: (val) {
                weight.unfocus();
                //FocusScope.of(context).requestFocus(weight);
              },
              decoration: normalInputDecoration(hint: "Weight")),
          SizedBox(height: 10),
          Column(
            children: [
              CommonButton(
                  width: 150,
                  buttonColor: AppColors.primaryColor,
                  onTap: () {},
                  title: "Save"),
            ],
          )
        ],
      ),
    );
  }

  void _takeImageFromCamera(BuildContext context) {
    return commonAlertBox(context, onPressed: (fromCamera) {
      if (fromCamera) {
        _fromCamera(context);
      }
      if (fromCamera == false) {
        _fromGallery(context);
      }
    });
  }

  _fromCamera(BuildContext context) async {
    try {
      selectFile =
          ImagePicker.pickImage(source: ImageSource.camera).whenComplete(() {
        // setState(() {
        //   Navigator.pop(context);
        // });
      });

      selectFile.then((value) {
        print(selectFile);
        //upload file here..
      }).catchError((e) {});
    } catch (e) {}
  }

  void _fromGallery(BuildContext context) {
    try {
      selectFile =
          ImagePicker.pickImage(source: ImageSource.gallery).whenComplete(() {
        // setState(() {
        //   Navigator.pop(context);
        // });
      });

      selectFile.then((value) {
        print(selectFile);
        //upload file here..
      }).catchError((e) {});
    } catch (e) {}
  }
  buildMaterialDatePicker(BuildContext context) async {
  final DateTime picked = await showDatePicker(

    context: context,
    helpText: 'Select booking date', // Can be used as title
  cancelText: 'Not now',
  confirmText: 'Book',
  
    initialDate: selectedDate,
    firstDate: DateTime(1900),
    lastDate: DateTime(2025),
    builder: (context, child) {
      return Theme(
        data: ThemeData.light(),
        child: child,
      );
    },
  );
  if (picked != null && picked != selectedDate)
    setState(() {
      selectedDate = picked;
       _date.value = TextEditingValue(text: picked.toString());
    });
}
}

class Medical extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TextFormField(
            onSaved: (mobileNo) {},
            onChanged: (val) {},
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            //focusNode: focusMobileNumber,
            //validator: (val) =>
            // Validator().validateMobile(val),
            onFieldSubmitted: (val) {
              // focusMobileNumber.unfocus();
              //FocusScope.of(context).requestFocus(focusEmail);
            },
            decoration: normalInputDecoration(hint: "Allergies")),
        TextFormField(
            onSaved: (mobileNo) {},
            onChanged: (val) {},
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            //focusNode: focusMobileNumber,
            //validator: (val) =>
            // Validator().validateMobile(val),
            onFieldSubmitted: (val) {
              // focusMobileNumber.unfocus();
              //FocusScope.of(context).requestFocus(focusEmail);
            },
            decoration: normalInputDecoration(hint: "Current Medications")),
        TextFormField(
            onSaved: (mobileNo) {},
            onChanged: (val) {},
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            //focusNode: focusMobileNumber,
            //validator: (val) =>
            // Validator().validateMobile(val),
            onFieldSubmitted: (val) {
              // focusMobileNumber.unfocus();
              //FocusScope.of(context).requestFocus(focusEmail);
            },
            decoration: normalInputDecoration(hint: "Past Medications")),
        TextFormField(
            onSaved: (mobileNo) {},
            onChanged: (val) {},
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            //focusNode: focusMobileNumber,
            //validator: (val) =>
            // Validator().validateMobile(val),
            onFieldSubmitted: (val) {
              // focusMobileNumber.unfocus();
              //FocusScope.of(context).requestFocus(focusEmail);
            },
            decoration: normalInputDecoration(hint: "Chronic Diseases")),
        TextFormField(
            onSaved: (mobileNo) {},
            onChanged: (val) {},
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            //focusNode: focusMobileNumber,
            //validator: (val) =>
            // Validator().validateMobile(val),
            onFieldSubmitted: (val) {
              // focusMobileNumber.unfocus();
              //FocusScope.of(context).requestFocus(focusEmail);
            },
            decoration: normalInputDecoration(hint: "Injuries")),
        TextFormField(
            onSaved: (mobileNo) {},
            onChanged: (val) {},
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            //focusNode: focusMobileNumber,
            //validator: (val) =>
            // Validator().validateMobile(val),
            onFieldSubmitted: (val) {
              // focusMobileNumber.unfocus();
              //FocusScope.of(context).requestFocus(focusEmail);
            },
            decoration: normalInputDecoration(hint: "Surgeries")),
      ],
    );
  }
  
}
