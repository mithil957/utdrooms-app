import 'package:flutter/material.dart';
import 'package:utdrooms_mobile_app/colors.dart';
import 'package:utdrooms_mobile_app/globals.dart';
import 'package:utdrooms_mobile_app/model/request/room_time_ranges_request.dart';
import 'package:utdrooms_mobile_app/model/response/room_time_ranges.dart';
import 'package:utdrooms_mobile_app/model/user_data.dart';
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
  String? markedRoom;

  Color markedButtonColor = const Color.fromRGBO(213, 0, 0, 1.0);

  @override
  void initState() {
    super.initState();
    roomTimeRangesFuture = getRoomTimeRanges(widget.roomTimeRangesRequest);
    markedRoom = UserData.getMarkedRoom();
    print(markedRoom);
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
        style: const TextStyle(fontSize: 15, color: Colors.black),
        cursorColor: utdOrange,
        onChanged: (value) {
          filterSearchResults(value.toLowerCase());
        },
        controller: editingController,
        decoration: const InputDecoration(
          filled: true,
          fillColor: utdOrange50,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: utdOrange, width: 1.7),
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: utdOrange, width: 1.7)),
          hintText: "Search for room, try typing JSOM",
          hintStyle: TextStyle(color: Colors.black),
        ));
  }

  List<Widget> _buildTimeRangeInfo(List<String> timeRanges) {
    return timeRanges.map((timeRange) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          timeRange,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      );
    }).toList();
  }

  Widget _buildCard(RoomTimeRanges roomTimeRanges) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(1, 3, 1, 3),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              title: Text(
                roomTimeRanges.roomLocation,
                style: const TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            ..._buildTimeRangeInfo(roomTimeRanges.timeRanges),
            ButtonBar(
              alignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (markedRoom != null && markedRoom!.isNotEmpty) {
                        checkOutOfRoom(markedRoom!);
                      }
                      if (markedRoom == roomTimeRanges.roomLocation) {
                        markedRoom = null;
                        UserData.setMarkedRoom('');
                      } else {
                        UserData.setMarkedRoom(roomTimeRanges.roomLocation);
                        markedRoom = roomTimeRanges.roomLocation;
                        checkIntoRoom(markedRoom!);
                      }
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: () {
                          if (markedRoom == null) {
                            return const Text(
                              "Room unmarked",
                              style: TextStyle(fontSize: 18),
                            );
                          }
                          return Text(
                            "$markedRoom is marked open",
                            style: TextStyle(fontSize: 18),
                          );
                        }(),
                        duration: const Duration(milliseconds: 1000),
                        backgroundColor: utdOrange,
                      ),
                    );
                  },
                  child: () {
                    if (markedRoom == roomTimeRanges.roomLocation) {
                      return const Text("UNMARK");
                    }
                    return const Text("MARK OPEN");
                  }(),
                  style: ElevatedButton.styleFrom(
                      primary: (roomTimeRanges.roomLocation == markedRoom)
                          ? markedButtonColor
                          : utdGreen),
                ),
              ],
            )
          ],
        ),
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
              Padding(
                padding: const EdgeInsets.fromLTRB(7, 12, 7, 10),
                child: _buildSearchBar(),
              ),
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
        return const Center(
            child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation(utdOrange),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Open Rooms"),
        actions: const [],
        backgroundColor: utdOrange,
      ),
      body: _buildCardList(),
    );
  }
}
