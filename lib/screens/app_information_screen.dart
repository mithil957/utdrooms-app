import 'package:flutter/material.dart';

import '../colors.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(
              color: Colors.black
          ),
          title: const Text('Information'),
          titleTextStyle: const TextStyle(
              color: Colors.black, fontSize: 23, fontWeight: FontWeight.w500),
          centerTitle: true,
          backgroundColor: utdGreen50),
    );
  }
}
