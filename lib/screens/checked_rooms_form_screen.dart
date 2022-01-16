import 'package:flutter/material.dart';

class CheckedRoomsScreen extends StatefulWidget {
  const CheckedRoomsScreen({Key? key}) : super(key: key);

  @override
  _CheckedRoomsScreenState createState() => _CheckedRoomsScreenState();
}

class _CheckedRoomsScreenState extends State<CheckedRoomsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Checked Rooms"),
      ),
    );
  }
}

