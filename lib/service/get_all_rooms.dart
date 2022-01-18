import 'dart:convert';
import 'package:http/http.dart' as http;

import '../exceptions.dart';

Future<List<String>> getAllRooms() async {
  final uri = Uri.https('utdrooms.com', '/rooms');
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.map((e) => e as String).toList();
  } else {
    throw UnableToGetAllRooms(response.statusCode, response.body);
  }
}
