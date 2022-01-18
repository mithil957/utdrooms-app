import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:utdrooms_mobile_app/exceptions.dart';

Future<bool> checkIntoRoom(String room) async {
  final uri = Uri.https('utdrooms.com', '/check_in_room');
  final headers = {'room': room};

  final response = await http.patch(uri, headers: headers);

  if (response.statusCode == 200) {
    return true;
  } else {
    throw CheckIntoRoomFailed(response.statusCode, response.body);
  }
}

Future<bool> checkOutOfRoom(String room) async {
  final uri = Uri.https('utdrooms.com', '/check_out_room');
  final headers = {'room': room};

  final response = await http.patch(uri, headers: headers);

  if (response.statusCode == 200) {
    return true;
  } else {
    throw CheckOutOfRoomFailed(response.statusCode, response.body);
  }
}

Future<Map<String, int>> getCheckedRooms() async {
  final uri = Uri.https('utdrooms.com', '/checked_rooms');
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.map((key, value) => MapEntry(key, value as int));
  } else {
    throw GetCheckedRoomsFailed(response.statusCode, response.body);
  }
}
