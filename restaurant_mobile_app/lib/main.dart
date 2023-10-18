import 'package:flutter/material.dart';
import 'package:restaurant_mobile_app/AllMenus.dart';
import 'package:restaurant_mobile_app/CreateMenu.dart';
import 'package:restaurant_mobile_app/Deletemenu.dart';
import 'package:restaurant_mobile_app/UpdateMenu.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // Declare default index for state
  int _selectedIndex = 0;

  // Buat List dengan semua nilai false, kecuali indeks pertama
  List<bool> _isSelected = List.generate(4, (i) => i == 0);

  // List that use for declare Title
  String titleApp = "All Menus";

  // Declare state
  List<Widget> _bodies = [
    AllMenus(),
    CreateMenu(),
    UpdateMenu(),
    DeleteMenu(),
  ];

  void onTaped(int index) {
    setState(() {
      _selectedIndex = index;
      _isSelected = List.generate(4, (i) => i == index);
      switch (index) {
        case 0:
          titleApp = "All Menu";
          break;
        case 1:
          titleApp = "Create Menu";
          break;
        case 2:
          titleApp = "Update Menu";
          break;
        case 3:
          titleApp = "Delete Menu";
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.brown,
        fontFamily: "Quicksand",
        scaffoldBackgroundColor: Color.fromARGB(255, 245, 245, 245),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            titleApp,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.brown[600],
        ),
        body: _bodies[_selectedIndex],
        drawer: Drawer(
          backgroundColor: Color.fromARGB(255, 198, 178, 169),
          child: ListView(
            // Remove padding from list view
            padding: EdgeInsets.all(0),
            children: [
              const DrawerHeader(
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Colors.brown,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Khip01 Restaurant",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                selected: _isSelected[0],
                selectedTileColor: Color.fromARGB(255, 175, 145, 140),
                leading: Image(image: AssetImage("assets/Index24.png")),
                title: const Text(
                  "All Menus",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Update the state of the app
                  onTaped(0);
                  // Then Close The Drawer
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                tileColor:
                    _isSelected[1] ? Color.fromARGB(255, 175, 145, 140) : null,
                leading: Image(image: AssetImage("assets/Create24.png")),
                title: const Text(
                  "Create Menu",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Update the state of the app
                  onTaped(1);
                  // Then Close The Drawer
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                tileColor:
                    _isSelected[2] ? Color.fromARGB(255, 175, 145, 140) : null,
                leading: Image(image: AssetImage("assets/Edit24.png")),
                title: const Text(
                  "Update Menu",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Update the state of the app
                  onTaped(2);
                  // Then Close The Drawer
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                tileColor:
                    _isSelected[3] ? Color.fromARGB(255, 175, 145, 140) : null,
                leading: Image(image: AssetImage("assets/remove24.png")),
                title: const Text(
                  "Delete Menu",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  // Update the state of the app
                  onTaped(3);
                  // Then Close The Drawer
                  // Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
