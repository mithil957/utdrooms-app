import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  final List<Widget> _contactInfo = const [
    Text(" • Email: utdrooms@gmail.com", textAlign: TextAlign.center)
  ];

  final List<Widget> _beforeUseInfo = const [
    Text(
      " • Please follow Covid-19 guidelines",
      textAlign: TextAlign.center,
    ),
    Text(" • This app uses a heuristic and therefore it is not 100% accurate"),
    Text(
        " • It does not take into account when labs and exams are held in a classroom"),
    Text(
        " • Please report anything I should be aware of or any bugs/errors found on the app"),
    Text(
        " • If this app violates any UTD guidelines/policies, please let me know"),
  ];

  final List<Widget> _openRoomsInfo = const [
    Text(
        " • Will determine what rooms are open given the day, time, and minimum amount of time the room should be open for"),
    Text(" • The values default to the current day and time"),
    Text(" • The result will be a list of cards showing when a room is open"),
    Text(
        " • Each card has a “MARK OPEN” button on it, that button is used to indicate that you have found this room to be open :)")
  ];

  final List<Widget> _roomScheduleInfo = const [
    Text(" • Will determine what the schedule of a room given a list of rooms and a day"),
    Text(" • You can tap on green chips under the “Select a room” dropdown to remove unwanted rooms"),
    Text(" • The results will be a list of expandable items, which upon expansion will show the schedule"),
  ];

  final List<Widget> _markedRoomsInfo = const [
    Text(" • Shows a list of rooms with the number of times it has been marked open"),
    Text(" • This list will reset at the end of the day"),
    Text(" • The list will remove a room from the list if the room is no longer open (if it has a class going on in it)")
  ];

  Widget _buildInfoTile(String title, List<Widget> textList) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      iconColor: utdGreen,
      collapsedIconColor: utdGreen,
      textColor: Colors.black,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: textList
          .map((e) => Padding(
                padding: EdgeInsets.fromLTRB(13,3,5,3),
                child: e,
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Information"),
        actions: const [],
        backgroundColor: utdGreen,
      ),
      body: ListView(

        children: [
          _buildInfoTile("Contact Info", _contactInfo),
          _buildInfoTile("Before Use", _beforeUseInfo),
          _buildInfoTile("Open Rooms", _openRoomsInfo),
          _buildInfoTile("Room Schedule", _roomScheduleInfo),
          _buildInfoTile("Marked Rooms", _markedRoomsInfo),
        ],
      ),
    );
  }
}
