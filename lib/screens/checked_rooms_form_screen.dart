import 'package:flutter/material.dart';
import 'package:utdrooms_mobile_app/colors.dart';
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
              const SizedBox(height: 20),
              const ListTile(
                title: Text(
                  "Room",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                trailing: Text(
                  "# of times marked open",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
              ),
              const Divider(
                indent: 16,
                endIndent: 16,
                thickness: 1.0,
                color: utdOrange,
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: _markedRooms.length,
                itemBuilder: (context, index) {
                  return _buildMarkedRoomListTile(_markedRooms[index]);
                },
              )),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _markedRoomsFuture = getCheckedRooms();
                  });
                },
                child: const Text(
                  'Refresh',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  //TODO how to not hardcode these? controls the size of the button
                  padding: const EdgeInsets.fromLTRB(100.0, 5.0, 100.0, 5.0),
                  primary: utdGreen,
                  shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text("Server gave bad response :("));
        }
        return const Center(
            child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(utdOrange),
        ));
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
