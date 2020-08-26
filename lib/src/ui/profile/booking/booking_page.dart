import 'package:flutter/material.dart';
import 'package:medico_app/src/presentation/widget/common_button.dart';
import 'package:medico_app/src/res/app_color.dart';

class BookingPage extends StatefulWidget {
  static const List<String> selections = <String>[
    'Follow Up',
    'Consultation',
  ];
  static const List<String> daySlot = <String>["1", "2", "3"];
  static const List<String> timeSlot = <String>["5:30", "6:00", "7:00"];

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int groupValue;

  int selecteDayIndex;

  int selecteTimeIndex;

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      ListTile(
        leading: CircleAvatar(),
        title: Text('Dr.Alvin'),
        subtitle: Text('The...'),
      ),
      Divider(),
      Text('Purpose of Visit'),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(BookingPage.selections.length, (index) {
          return RadioListTile(
              dense: true,
              controlAffinity: ListTileControlAffinity.trailing,
              value: index,
              title: Text(
                BookingPage.selections[index],
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
        children: List.generate(BookingPage.daySlot.length, (index) {
          return ChoiceChip(
              selectedColor: Colors.blue,
              onSelected: (v) {
                setState(() {
                  selecteDayIndex = v ? index : 0;
                });
                print(v);
              },
              label: Text(BookingPage.daySlot[index]),
              selected: selecteDayIndex == index);
        }).toList(),
      ),
      Text('Time of Slot'),
      Text('Evening'),
      Wrap(
        direction: Axis.horizontal,
        spacing: 30,
        children: List.generate(BookingPage.timeSlot.length, (index) {
          return ChoiceChip(
              selectedColor: Colors.blue,
              onSelected: (v) {
                setState(() {
                  selecteTimeIndex = v ? index : 0;
                });
                print(v);
              },
              label: Text(BookingPage.timeSlot[index]),
              selected: selecteTimeIndex == index);
        }).toList(),
      ),
      CommonButton(buttonColor: AppColors.primaryColor, title: "Proceed")
    ]);
  }
}
