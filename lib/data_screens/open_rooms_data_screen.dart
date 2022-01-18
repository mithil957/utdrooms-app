import 'package:flutter/material.dart';
import 'package:utdrooms_mobile_app/globals.dart';
import 'package:utdrooms_mobile_app/model/request/room_time_ranges_request.dart';
import 'package:utdrooms_mobile_app/model/response/room_time_ranges.dart';
import 'package:utdrooms_mobile_app/service/get_room_time_ranges.dart';
import 'package:utdrooms_mobile_app/service/room_check_service.dart';

class OpenRoomsDataScreen extends StatefulWidget {
  final RoomTimeRangesRequest roomTimeRangesRequest;

  const OpenRoomsDataScreen({Key? key, required this.roomTimeRangesRequest})
      : super(key: key);

  @override
  _OpenRoomsDataScreenState createState() => _OpenRoomsDataScreenState();
}

class _OpenRoomsDataScreenState extends State<OpenRoomsDataScreen> {
  TextEditingController editingController = TextEditingController();

  late Future<List<RoomTimeRanges>> roomTimeRangesFuture;

  late List<RoomTimeRanges> _roomTimeRanges;
  List<RoomTimeRanges> _searchResults = [];
  bool _hasSearched = false;

  Color markedButtonColor = Colors.red;

  @override
  void initState() {
    super.initState();
    roomTimeRangesFuture = getRoomTimeRanges(widget.roomTimeRangesRequest);
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = _roomTimeRanges;
      });
    } else {
      setState(() {
        _hasSearched = true;
        _searchResults = _roomTimeRanges
            .where((roomTimeRange) =>
            roomTimeRange.roomLocation.toLowerCase().contains(query))
            .toList();
      });
    }
  }

  Widget _buildSearchBar() {
    return TextField(
      onChanged: (value) {
        filterSearchResults(value.toLowerCase());
      },
      controller: editingController,
      decoration: const InputDecoration(
          // labelText: "Search",
          hintText: "Search",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)))),
    );
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
            alignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (markedRoomGlobal != null) {
                      checkOutOfRoom(markedRoomGlobal!);
                    }
                    if (markedRoomGlobal == roomTimeRanges.roomLocation) {
                      markedRoomGlobal = null;
                    } else {
                      markedRoomGlobal = roomTimeRanges.roomLocation;
                      checkIntoRoom(markedRoomGlobal!);
                    }
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: () {
                        if (markedRoomGlobal == null) {
                          return const Text("Room unmarked");
                        }
                        return Text("$markedRoomGlobal is marked");
                      }(),
                      duration: const Duration(milliseconds: 700),
                    ),
                  );
                },
                child: () {
                  if (markedRoomGlobal == roomTimeRanges.roomLocation) {
                    return const Text("UNMARK");
                  }
                  return const Text("MARK OPEN");
                }(),
                style: ElevatedButton.styleFrom(
                    primary: (roomTimeRanges.roomLocation == markedRoomGlobal)
                        ? markedButtonColor
                        : Colors.green),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCardList() {
    return FutureBuilder<List<RoomTimeRanges>>(
      future: roomTimeRangesFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _roomTimeRanges = snapshot.data!;
          if (!_hasSearched) {
            _searchResults = snapshot.data!;
          }
          return Column(
            children: [
              _buildSearchBar(),
              Expanded(
                  child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  return _buildCard(_searchResults[index]);
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
      appBar: AppBar(
        title: const Text("Open Rooms"),
        actions: const [],
      ),
      body: _buildCardList(),
    );
  }
}