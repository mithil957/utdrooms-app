import 'package:flutter/material.dart';
import 'package:utdrooms_mobile_app/model/request/room_time_ranges_request.dart';
import 'package:utdrooms_mobile_app/model/response/room_time_ranges.dart';
import 'package:utdrooms_mobile_app/service/get_room_time_ranges.dart';

class OpenRoomsDataScreen extends StatefulWidget {

  final RoomTimeRangesRequest roomTimeRangesRequest;

  const OpenRoomsDataScreen({Key? key, required this.roomTimeRangesRequest})
      : super(key: key);

  @override
  _OpenRoomsDataScreenState createState() => _OpenRoomsDataScreenState();
}

class _OpenRoomsDataScreenState extends State<OpenRoomsDataScreen> {

  late Future<List<RoomTimeRanges>> roomTimeRanges;

  @override
  void initState() {
    super.initState();
    roomTimeRanges = getRoomTimeRanges(widget.roomTimeRangesRequest);
  }

  List<Widget> _buildTimeRangeInfo(List<String> timeRanges) {
    return timeRanges.map((timeRange) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(timeRange),  
      );
    }).toList();
  }

  Widget _buildCard(RoomTimeRanges roomTimeRanges) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            title: Text(roomTimeRanges.roomLocation),
          ),
          ..._buildTimeRangeInfo(roomTimeRanges.timeRanges),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: () {}, child: const Text('MARK UNAVAILABLE')),
              TextButton(onPressed: () {}, child: const Text('MARK OPEN')),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Open Rooms"),
        actions: const [],
      ),
      body: Center(
        child: FutureBuilder<List<RoomTimeRanges>>(
          future: roomTimeRanges,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var response = snapshot.data!;
              return ListView.builder(
                itemCount: response.length,
                itemBuilder: (context, index) {
                  return _buildCard(response[index]);
                },
              );
            } else if (snapshot.hasError) {

              return Text("${snapshot.error}");
            }

            return const CircularProgressIndicator.adaptive();
          },
        ),
      ),
    );
  }
}
