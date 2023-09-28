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

  // Declare state
  List<Widget> _bodies = [
    AllMenus(),
    CreateMenu(),
    UpdateMenu(),
    DeleteMenu(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Khip01 Restaurant"),
          backgroundColor: Colors.brown[600],
        ),
        body: _bodies[_selectedIndex],
        drawer: Drawer(
          child: ListView(
            // Remove padding from list view
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                child: Text("Khip01 Restaurant"),
              ),
              ListTile(
                title: const Text("All Menus"),
                onTap: () {
                  // Update the state of the app
                  setState(() {
                    _selectedIndex = 0;
                  });
                  // Then Close The Drawer
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Create Menu"),
                onTap: () {
                  // Update the state of the app
                  setState(() {
                    _selectedIndex = 1;
                  });
                  // Then Close The Drawer
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Update Menu"),
                onTap: () {
                  // Update the state of the app
                  setState(() {
                    _selectedIndex = 2;
                  });
                  // Then Close The Drawer
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Delete Menu"),
                onTap: () {
                  // Update the state of the app
                  setState(() {
                    _selectedIndex = 3;
                  });
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
