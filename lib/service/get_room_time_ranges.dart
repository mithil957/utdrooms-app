import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'package:utdrooms_mobile_app/model/request/room_time_ranges_request.dart';
import 'package:utdrooms_mobile_app/model/response/room_time_ranges.dart';

import '../exceptions.dart';

Future<List<RoomTimeRanges>> getRoomTimeRanges(
    RoomTimeRangesRequest roomTimeRangesRequest) async {
  final payload = <String, String>{
    'day': roomTimeRangesRequest.day,
    'start_time': DateFormat.jm().format(roomTimeRangesRequest.startTime),
    'minimum_time': roomTimeRangesRequest.minimumAmountOfTime.toString()
  };

  final jsonString = json.encode(payload);
  final uri = Uri.https('utdrooms.com', '/time_ranges');
  final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

  final response = await http.post(uri, headers: headers, body: jsonString);

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => RoomTimeRanges.fromJson(data)).toList();
  } else {
    throw RoomTimeRangesRequestFailed(response.statusCode, response.body);
  }
}
