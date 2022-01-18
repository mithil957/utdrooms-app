import 'package:flutter/material.dart';
import 'package:utdrooms_mobile_app/service/room_check_service.dart';

class CheckedRoomsScreen extends StatefulWidget {
  const CheckedRoomsScreen({Key? key}) : super(key: key);

  @override
  _CheckedRoomsScreenState createState() => _CheckedRoomsScreenState();
}

class _CheckedRoomsScreenState extends State<CheckedRoomsScreen> {
  late Future<Map<String, int>> _markedRoomsFuture;
  late List<MapEntry<String, int>> _markedRooms;

  @override
  void initState() {
    super.initState();
    _markedRoomsFuture = getCheckedRooms();
  }

  Widget _buildMarkedRoomListTile(MapEntry<String, int> markedRoom) {
    return ListTile(
      title: Text(markedRoom.key),
      trailing: Text(markedRoom.value.toString()),
    );
  }

  Widget _buildMarkedRoomList() {
    return FutureBuilder<Map<String, int>>(
      future: _markedRoomsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _markedRooms = snapshot.data!.entries.toList();

          return Column(
            children: [
              const ListTile(
                title: Text("Room"),
                trailing: Text("# of times marked open"),
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: _markedRooms.length,
                itemBuilder: (context, index) {
                  return _buildMarkedRoomListTile(_markedRooms[index]);
                },
              ))
            ],
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text("Server gave bad response :("));
        }
        return const Center(child: CircularProgressIndicator.adaptive());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildMarkedRoomList(),
    );
  }
}
