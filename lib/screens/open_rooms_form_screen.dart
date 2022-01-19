import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:utdrooms_mobile_app/colors.dart';
import 'package:intl/intl.dart';
import 'package:utdrooms_mobile_app/data_screens/open_rooms_data_screen.dart';
import 'package:utdrooms_mobile_app/globals.dart';
import 'package:utdrooms_mobile_app/model/request/room_time_ranges_request.dart';

class OpenRoomsScreen extends StatefulWidget {
  const OpenRoomsScreen({Key? key}) : super(key: key);

  @override
  _OpenRoomsScreenState createState() => _OpenRoomsScreenState();
}

class _OpenRoomsScreenState extends State<OpenRoomsScreen> {

  late String _daySelected =
      DateFormat('EEEE').format(DateTime.now()).toString();
  late DateTime _timeSelected = DateTime.now();
  double _minimumTimeSelected = 30.0;

  String _formatDateTime(DateTime dateTime) {
    return DateFormat().add_jm().format(dateTime);
  }

  Widget _dayDropDown() {
    return DropdownButtonFormField(
      value: _daySelected,
      decoration: const InputDecoration(
        filled: true,
        fillColor: utdOrange50,
      ),
      onChanged: (String? dayPicked) {
        setState(() {
          _daySelected = dayPicked!;
        });
      },
      items: daysOfTheWeek.map<DropdownMenuItem<String>>((String day) {
        return DropdownMenuItem<String>(
          value: day,
          child: Text(day),
        );
      }).toList(),
    );
  }

  void _selectTime() async {
    DateTime currentTime = DateTime.now();

    final newTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay(hour: currentTime.hour, minute: currentTime.minute),
        initialEntryMode: TimePickerEntryMode.input,
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(
                    primary: utdGreen,
                    surface: utdGreen50,
                    onSurface: Colors.black)),
            child: child!,
          );
        });

    if (newTime != null) {
      setState(() {
        _timeSelected = DateTime(currentTime.year, currentTime.month,
            currentTime.day, newTime.hour, newTime.minute);
      });
    }
  }

  Widget _minimumTimeSelector() {
    return SliderTheme(
      data: const SliderThemeData(valueIndicatorColor: utdGreen),
      child: Slider.adaptive(
        value: _minimumTimeSelected,
        min: 0,
        max: 120.0,
        divisions: 4,
        activeColor: utdOrange,
        inactiveColor: utdOrange100,
        label: _minimumTimeSelected.round().toString() + ' minutes',
        onChanged: (value) {
          setState(() {
            _minimumTimeSelected = value;
          });
        },
      ),
    );
  }

  void _openRoomsDataScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return OpenRoomsDataScreen(
          roomTimeRangesRequest: RoomTimeRangesRequest(
              day: _daySelected,
              startTime: _timeSelected,
              minimumAmountOfTime: _minimumTimeSelected.toInt()));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const SizedBox(height: 60),
        Expanded(
            child: ListView(
          padding: const EdgeInsets.all(32),
          children: [
            const Text(
              'Select a day',
              style: TextStyle(fontSize: 21),
            ),
            const SizedBox(height: 6),
            _dayDropDown(),
            const SizedBox(height: 24),
            const Text(
              'Select a time',
              style: TextStyle(fontSize: 21),
            ),
            OutlinedButton(
                onPressed: _selectTime,
                child: Text(
                  _formatDateTime(_timeSelected),
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.normal),
                ),
                style: OutlinedButton.styleFrom(
                    // primary: utdGreen100,
                    backgroundColor: utdOrange50,
                    side: const BorderSide(color: Colors.black)
                    )),
            const SizedBox(height: 24),
            const Text(
              'Select a minimum amount of time',
              style: TextStyle(fontSize: 21),
            ),
            _minimumTimeSelector(),
            const SizedBox(height: 24),
          ],
        )),
        ElevatedButton(
          onPressed: _openRoomsDataScreen,
          child: const Text(
            'Submit',
            style: TextStyle(
                color: Colors.white,
            fontSize: 18),

          ),
          style: ElevatedButton.styleFrom(
            //TODO how to not hardcode these? controls the size of the button
            padding: const EdgeInsets.fromLTRB(100.0, 6.0, 100.0, 6.0),
            primary: utdGreen,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          ),
        ),
        const SizedBox(height: 20),
      ],
    ));
  }
}
