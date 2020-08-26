
import 'package:flutter/material.dart';

class BookingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   ListView(
      shrinkWrap: true,
     children: [
     Row(
       children: [
         ListTile(
           leading: CircleAvatar(

         ),
         title: Text('Dr.Alvin'),
         subtitle: Text('The...'),

         ),
         Divider(),
       ],
     )

     ],
    );
  }
}