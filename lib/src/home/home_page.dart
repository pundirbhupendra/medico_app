import 'package:flutter/material.dart';
import 'package:medico_app/src/data/repositories/auth_repo/auth_repo.dart';
import 'package:medico_app/src/presentation/utils/common_toast.dart';
import 'package:medico_app/src/presentation/widget/common_button.dart';
import 'package:medico_app/src/res/app_color.dart';
import 'package:medico_app/src/route/router.gr.dart';
import 'package:medico_app/src/ui/profile/booking/booking_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isRadioSelected = false;
  static const List<String> selections = <String>[
    'Follow Up',
    'Consultation',
  ];
  int groupValue;
  static const List<String> daySlot = <String>["1", "2", "3"];
   static const List<String> timeSlot = <String>["5:30", "6:00", "7:00"];
  int selecteDayIndex;
  int selecteTimeIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //  backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: ListView(shrinkWrap: true, children: [
          ListTile(
            leading: CircleAvatar(),
            title: Text('Dr.Alvin'),
            subtitle: Text('The...'),
          ),
          Divider(),
          Text('Purpose of Visit'),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(selections.length, (index) {
              return RadioListTile(
                  dense: true,
                  controlAffinity: ListTileControlAffinity.trailing,
                  value: index,
                  title: Text(
                    selections[index],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  groupValue: groupValue,
                  onChanged: (v) {
                    setState(() {
                      groupValue = v;
                    });
                  });
            }).toList(),
          ),
          Text('Day of Slot'),
          Wrap(
            direction: Axis.horizontal,
            spacing: 30,
            children: List.generate(daySlot.length, (index) {
              return ChoiceChip(
                  selectedColor: Colors.blue,
                  onSelected: (v) {
                    setState(() {
                      selecteDayIndex = v ? index : 0;
                    });
                    print(v);
                  },
                  label: Text(daySlot[index]),
                  selected: selecteDayIndex == index);
            }).toList(),
          ),
           Text('Time of Slot'),
               Text('Evening'),

               Wrap(
            direction: Axis.horizontal,
            spacing: 30,
            children: List.generate(timeSlot.length, (index) {
              return ChoiceChip(
                  selectedColor: Colors.blue,
                  onSelected: (v) {
                    setState(() {
                      selecteTimeIndex = v ? index : 0;
                    });
                    print(v);
                  },
                  label: Text(timeSlot[index]),
                  selected: selecteTimeIndex == index);
            }).toList(),
          ),

          CommonButton(
            buttonColor: AppColors.primaryColor,
            title: "Proceed")
        ]
            // Column(
            //   children: [
            //     Center(
            //       child: Text('Welcome to Medico Home'),
            //     ),
            //     RaisedButton(
            //         child: Text('Logout'),
            //         onPressed: () async {

            //          _singout();
            //         }),
            //         RaisedButton(
            //         child: Text('Profile'),
            //         onPressed: () async {

            //         Navigator.pushNamed(context, Router.myProfile);
            //         })
            //   ],
            // ),
            ));
  }

  _singout() async {
    final response = await AuthRepository.signOut();
    if (response.statusCode == 204) {
      showMessage("loggedout!");

      await Navigator.pushReplacementNamed(context, Router.onboardingScreen);
    }
  }
}
