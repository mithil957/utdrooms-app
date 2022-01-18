import 'package:flutter/material.dart';
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
      ),
      Text(
        classInfo.title,
        style: const TextStyle(fontSize: 16),
      ),
      Text('From ${classInfo.startTime} to ${classInfo.endTime}'),
    ];
  }

  Widget _buildRoomScheduleTile(String room, List<ClassInfo> classes) {
    return ExpansionTile(
      title: Text(room),
      children: [
        ...[
          for (var i = 0; i < classes.length; i++)
            ..._buildClassInformation(classes[i])
        ],
        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 9.0))
      ],
    );
  }

  Widget _buildRoomScheduleList() {
    return FutureBuilder<Map<String, List<ClassInfo>>>(
        future: _roomScheduleFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _roomSchedule = snapshot.data!.entries.toList();

            return Column(
              children: [
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
          return const Center(child: CircularProgressIndicator.adaptive());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Room Schedule"),
        actions: const [],
      ),
      body: _buildRoomScheduleList(),
    );
  }
}
