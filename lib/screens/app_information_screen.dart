import 'package:flutter/material.dart';

import '../colors.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  final List<String> _contactInfo = const [" • Email: utdrooms@gmail.com"];

  final List<String> _beforeUseInfo = const [
    " • Please follow Covid-19 guidelines",
    " • This app uses a heuristic and therefore it is not 100% accurate",
    " • It does not take into account when labs and exams are held in a classroom",
    " • Please report anything I should be aware of or any bugs/errors found on the app",
    " • If this app violates any UTD guidelines/policies, please let me know",
  ];

  final List<String> _openRoomsInfo = const [
    " • Will determine what rooms are open given the day, time, and minimum amount of time the room should be open for",
    " • The values default to the current day and time",
    " • The result will be a list of cards showing when a room is open",
    " • Each card has a “MARK OPEN” button on it, that button is used to indicate that you have found this room to be open :)"
  ];

  final List<String> _roomScheduleInfo = const [
    " • Will determine what the schedule of a room given a list of rooms and a day",
    " • You can tap on green chips under the “Select a room” dropdown to remove unwanted rooms",
    " • The results will be a list of expandable items, which upon expansion will show the schedule",
  ];

  final List<String> _markedRoomsInfo = const [
    " • Shows a list of rooms with the number of times it has been marked open",
    " • This list will reset at the end of the day",
    " • The list will remove a room from the list if the room is no longer open (if it has a class going on in it)"
  ];

  Widget _buildInfoTile(String title, List<String> textList) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
      ),
      iconColor: utdGreen,
      collapsedIconColor: utdGreen,
      textColor: Colors.black,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      children: textList
          .map((e) => Padding(
                padding: const EdgeInsets.fromLTRB(13, 3, 5, 3),
                child: Text(e, style: const TextStyle(fontSize: 16)),
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
          const SizedBox(
            height: 10,
          ),
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
