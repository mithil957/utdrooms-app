import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:utdrooms_mobile_app/colors.dart';

class RoomScheduleScreen extends StatefulWidget {
  const RoomScheduleScreen({Key? key}) : super(key: key);

  @override
  _RoomScheduleScreenState createState() => _RoomScheduleScreenState();
}

class _RoomScheduleScreenState extends State<RoomScheduleScreen> {
  final _daysOfTheWeek = <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  final _rooms = [for (var i = 1; i <= 1000; i++) i.toString()];

  var _selectedRooms = [];

  late String _daySelected =
      DateFormat('EEEE').format(DateTime.now()).toString();

  Widget _dayDropDown() {
    return DropdownButtonFormField(
      value: _daySelected,
      decoration: const InputDecoration(
        filled: true,
        fillColor: utdGreen50,
        // labelText: 'Select a day',
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(7.0))
      ),
      onChanged: (String? dayPicked) {
        setState(() {
          _daySelected = dayPicked!;
        });
      },
      items: _daysOfTheWeek.map<DropdownMenuItem<String>>((String day) {
        return DropdownMenuItem<String>(
          value: day,
          child: Text(day),
        );
      }).toList(),
    );
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
                    const Text('Select a day', style: TextStyle(fontSize: 21),),
                    const SizedBox(height: 6),
                    _dayDropDown(),
                    const SizedBox(height: 35),
                    const Text('Select a room', style: TextStyle(fontSize: 21),),
                    const SizedBox(height: 6),
                    MultiSelectDialogField(
                      decoration: const BoxDecoration(
                        color: utdGreen50,
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: .5
                          )
                        )
                      ),
                      backgroundColor: utdGreen50,
                      selectedColor: utdGreen150,
                      // checkColor: Colors.black,
                      height: 400,
                      buttonIcon: const Icon(Icons.arrow_drop_down, color: Color.fromRGBO(0, 0, 0, .6),),
                      chipDisplay: MultiSelectChipDisplay(
                        chipColor: utdGreen150,
                        textStyle: TextStyle(color: Colors.white),
                        items: _selectedRooms.map((e) => MultiSelectItem(e, e)).toList(),
                        onTap: (value) {},
                      ),
                      items: _rooms.map((e) => MultiSelectItem(e, e)).toList(),
                      searchable: true,
                      listType: MultiSelectListType.LIST,
                      onConfirm: (values) {
                        _selectedRooms = values;
                      },
                    )
                  ],
                )),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                //TODO how to not hardcode these? controls the size of the button
                padding: const EdgeInsets.fromLTRB(100.0, 5.0, 100.0, 5.0),
                primary: utdGreen150,
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ));
  }
}
