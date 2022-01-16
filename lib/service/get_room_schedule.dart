import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:utdrooms_mobile_app/exceptions.dart';

import 'package:utdrooms_mobile_app/model/request/room_schedule_request.dart';
import 'package:utdrooms_mobile_app/model/response/class_info.dart';

Future<Map<String, List<ClassInfo>>> getRoomSchedule(
    RoomScheduleRequest roomScheduleRequest) async {
  final payload = {
    'day': roomScheduleRequest.day,
    'rooms': roomScheduleRequest.rooms
  };

  final jsonString = json.encode(payload);
  final uri = Uri.https('utdrooms.com', '/room_schedule');
  final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

  final response = await http.post(uri, headers: headers, body: jsonString);

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.map<String, List<ClassInfo>>((key, value) {
      List<ClassInfo> classInfoList = value.map<ClassInfo>((data) => ClassInfo.fromJson(data)).toList();
      return MapEntry(key, classInfoList);
    });
  } else {
    throw RoomScheduleRequestFailed(response.statusCode, response.body);
  }
}
