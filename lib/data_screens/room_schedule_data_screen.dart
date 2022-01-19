import 'package:flutter/material.dart';
import 'package:utdrooms_mobile_app/colors.dart';
import 'package:utdrooms_mobile_app/model/request/room_schedule_request.dart';
import 'package:utdrooms_mobile_app/model/response/class_info.dart';
import 'package:utdrooms_mobile_app/service/get_room_schedule.dart';

class RoomScheduleDataScreen extends StatefulWidget {
  final RoomScheduleRequest roomScheduleRequest;

  const RoomScheduleDataScreen({Key? key, required this.roomScheduleRequest})
      : super(key: key);

  @override
  _RoomScheduleDataScreenState createState() => _RoomScheduleDataScreenState();
}

class _RoomScheduleDataScreenState extends State<RoomScheduleDataScreen> {
  late Future<Map<String, List<ClassInfo>>> _roomScheduleFuture;
  late List<MapEntry<String, List<ClassInfo>>> _roomSchedule;

  @override
  void initState() {
    super.initState();
    _roomScheduleFuture = getRoomSchedule(widget.roomScheduleRequest);
  }

  List<Widget> _buildClassInformation(ClassInfo classInfo) {
    return [
      const Divider(
        indent: 16,
        endIndent: 16,
        thickness: 1.0,
        color: utdOrange,
      ),
      Center(
        child: Text(
          classInfo.title,
          style: const TextStyle(fontSize: 17),
          textAlign: TextAlign.center,
        ),
      ),
      Text('From ${classInfo.startTime} to ${classInfo.endTime}'),
    ];
  }

  Widget _buildRoomScheduleTile(String room, List<ClassInfo> classes) {
    return ExpansionTile(
        title: Text(
          room,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        iconColor: utdGreen,
        collapsedIconColor: utdGreen,
        textColor: Colors.black,
        children: () {
          List<Widget> tempList = [];
          if (classes.isNotEmpty) {
            for (var i = 0; i < classes.length; i++) {
              tempList.addAll(_buildClassInformation(classes[i]));
            }
          } else {
            tempList.add(const Text(
              "No classes found for this room",
              style: TextStyle(fontSize: 16),
            ));
          }

          tempList
              .add(const Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 9.0)));
          return tempList;
        }());
  }

  Widget _buildRoomScheduleList() {
    return FutureBuilder<Map<String, List<ClassInfo>>>(
        future: _roomScheduleFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _roomSchedule = snapshot.data!.entries.toList();

            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: _roomSchedule.length,
                  itemBuilder: (context, index) {
                    var currentRoom = _roomSchedule[index];
                    return _buildRoomScheduleTile(
                        currentRoom.key, currentRoom.value);
                  },
                ))
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Server gave bad response :("));
          }
          return const Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(utdOrange),
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Room Schedule"),
        actions: const [],
        backgroundColor: utdOrange,
      ),
      body: _buildRoomScheduleList(),
    );
  }
}
