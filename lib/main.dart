import 'package:flutter/material.dart';
import 'package:utdrooms_mobile_app/colors.dart';
import 'package:utdrooms_mobile_app/screens/room_schedule_form_screen.dart';
import 'package:utdrooms_mobile_app/screens/checked_rooms_form_screen.dart';
import 'package:utdrooms_mobile_app/screens/app_information_screen.dart';
import 'package:utdrooms_mobile_app/screens/open_rooms_form_screen.dart';
import 'package:utdrooms_mobile_app/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTD Rooms',
      home: MainPageState(),
      theme: CustomTheme.shrineTheme
    );
  }
}

class MainPageState extends StatefulWidget {
  const MainPageState({Key? key}) : super(key: key);

  @override
  _MainPageStateState createState() => _MainPageStateState();
}

class _MainPageStateState extends State<MainPageState> {
  int index = 0;
  final screens = const [
    OpenRoomsScreen(),
    RoomScheduleScreen(),
    CheckedRoomsScreen(),
  ];

  void _InformationScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const InformationScreen();
    }));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: screens[index],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            labelTextStyle: MaterialStateProperty.all(
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
          child: NavigationBar(
            selectedIndex: index,
            animationDuration: const Duration(seconds: 1),
            onDestinationSelected: (index) {
              setState(() => this.index = index);
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.meeting_room_outlined),
                selectedIcon: Icon(Icons.meeting_room_rounded),
                label: 'Open Rooms',
              ),
              NavigationDestination(
                icon: Icon(Icons.article_outlined),
                selectedIcon: Icon(Icons.article_rounded),
                label: 'Room Schedule',
              ),
              NavigationDestination(
                icon: Icon(Icons.group_outlined),
                selectedIcon: Icon(Icons.group),
                label: 'Marked Rooms',
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text("UTD Rooms"),
          titleTextStyle: const TextStyle(
              color: Colors.white, fontSize: 23, fontWeight: FontWeight.w500),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                icon: const Icon(Icons.info_outline),
                color: Colors.white,
                onPressed: _InformationScreen,
              ),
            )
          ],
        ),
      );
}
