import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:utdrooms_mobile_app/colors.dart';
import 'package:utdrooms_mobile_app/data_screens/room_schedule_data_screen.dart';
import 'package:utdrooms_mobile_app/globals.dart';
import 'package:utdrooms_mobile_app/model/request/room_schedule_request.dart';
import 'package:utdrooms_mobile_app/service/get_all_rooms.dart';

class RoomScheduleScreen extends StatefulWidget {
  const RoomScheduleScreen({Key? key}) : super(key: key);

  @override
  _RoomScheduleScreenState createState() => _RoomScheduleScreenState();
}

class _RoomScheduleScreenState extends State<RoomScheduleScreen> {

  late String _daySelected = DateFormat('EEEE').format(DateTime.now()).toString();
  var _selectedRooms = [];

  late Future<List<String>> _allRoomsFuture;

  @override
  void initState() {
    super.initState();
    _allRoomsFuture = getAllRooms();
  }

  Widget _dayDropDown() {
    return DropdownButtonFormField(
      value: _daySelected,
      decoration: const InputDecoration(
        filled: true,
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

  Widget _buildRoomDropDown(List<String> rooms) {
    return MultiSelectDialogField(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Colors.black,
                  width: .5
              )
          )
      ),
      // checkColor: Colors.black,
      height: 400,
      buttonIcon: const Icon(Icons.arrow_drop_down, color: Color.fromRGBO(0, 0, 0, .6),),
      chipDisplay: MultiSelectChipDisplay(
        textStyle: const TextStyle(color: Colors.white),
        items: _selectedRooms.map((e) => MultiSelectItem(e, e)).toList(),
        onTap: (value) {
          setState(() {
            _selectedRooms.remove(value);
          });
        },
      ),
      items: rooms.map((e) => MultiSelectItem(e, e)).toList(),
      searchable: true,
      listType: MultiSelectListType.LIST,
      onConfirm: (values) {
        _selectedRooms = values;
      },
    );
  }

  Widget _resolveAllRoomsFuture() {
    return FutureBuilder<List<String>>(
      future: _allRoomsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          allRoomsGlobal = snapshot.data;

          return _buildRoomDropDown(allRoomsGlobal!);

        } else if (snapshot.hasError) {
          return const Center(child: Text("Server gave bad response :("));
        }
        return const Center(child: CircularProgressIndicator.adaptive());
      }
    );
  }

  void _openRoomScheduleDataScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return RoomScheduleDataScreen(roomScheduleRequest: RoomScheduleRequest(
        day: _daySelected,
        rooms: _selectedRooms.map((e) => e as String).toList()
      ));
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
                    const Text('Select a day', style: TextStyle(fontSize: 21),),
                    const SizedBox(height: 6),
                    _dayDropDown(),
                    const SizedBox(height: 35),
                    const Text('Select a room', style: TextStyle(fontSize: 21),),
                    const SizedBox(height: 6),
                    () {
                      if (allRoomsGlobal == null) {
                        return _resolveAllRoomsFuture();
                      }
                      return _buildRoomDropDown(allRoomsGlobal!);
                    }()
                  ],
                )),
            ElevatedButton(
              onPressed: _openRoomScheduleDataScreen,
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                //TODO how to not hardcode these? controls the size of the button
                padding: const EdgeInsets.fromLTRB(100.0, 5.0, 100.0, 5.0),
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ));
  }
}
