import 'package:flutter/material.dart';
import 'package:restaurant_mobile_app/AllMenus.dart';
import 'package:restaurant_mobile_app/CreateMenu.dart';
import 'package:restaurant_mobile_app/Deletemenu.dart';
import 'package:restaurant_mobile_app/UpdateMenu.dart';
import 'package:restaurant_mobile_app/Utils/util.dart';

void main() async {
  runApp(const MainApp());
}

bool switchIsApiMode = false; // Switch Mode

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Util util = new Util();

  @override
  void initState() {
    super.initState();
    util.setApiAddress("192.168.0.11");
    util.setIsActiveIndex(0);
    initMode();
  }

  // Declare default index for state
  int _selectedIndex = 0;

  // Buat List dengan semua nilai false, kecuali indeks pertama
  List<bool> _isSelected = List.generate(4, (i) => i == 0);

  // List that use for declare Title
  List<String> _titleApp = ["All Menu", "Create Menu", "Update Menu", "Delete Menu"];

  // Declare state
  List<Widget> _bodies = [
    AllMenus(),
    CreateMenu(),
    UpdateMenu(),
    DeleteMenu(),
  ];

  void onTaped(int index) {
    setState(() {
      // _selectedIndex = index;
      util.setIsActiveIndex(index);
      util.getIsActiveIndex().then((result) => _selectedIndex = result);
      _isSelected = List.generate(4, (i) => i == index);
    });
  }

  // Init untuk mengubah IsApiMode
  void initMode(){
    // Init Is API Mode
    util.getIsApiMode().then((value) {
      setState(() {
        switchIsApiMode = value;
        // debugPrint(value.toString());
      });
    });
    // Init SelectedIndex
    util.getIsActiveIndex().then((value) {
      setState(() {
        _selectedIndex = value;
      });
    });
    // Init Selected Active Tile
    util.getIsActiveIndex().then((value) {
      setState(() {
        _isSelected = List.generate(4, (i) => i == value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    initMode(); // Init switch condition is API Mode and isSelectedIndex Page Mode
    // Thumb Icon for Switch Check/Close
    final MaterialStateProperty<Icon?> thumbIcon =
        MaterialStateProperty.resolveWith<Icon?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const Icon(Icons.check);
        }
        return const Icon(Icons.close);
      },
    );

    return MaterialApp(
      initialRoute: "/",
      theme: ThemeData(
        useMaterial3: true,
        // cardTheme: CardTheme(color: Colors.white),
        // colorScheme: ,
        colorSchemeSeed: Color.fromARGB(255, 255, 244, 240),
        // primarySwatch: Colors.brown,
        fontFamily: "Quicksand",
        scaffoldBackgroundColor: Color.fromARGB(255, 245, 245, 245),
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            _titleApp[_selectedIndex],
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.brown[600],
        ),
        body: _bodies[_selectedIndex],
        drawer: Drawer(
          backgroundColor: Colors.brown,
          child: Container(
            // Remove padding from list view
            padding: EdgeInsets.all(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const DrawerHeader(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
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
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        children: [
                          ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                            ),
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            tileColor: _isSelected[1]
                                ? Color.fromARGB(255, 175, 145, 140)
                                : null,
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                            ),
                            tileColor: _isSelected[2]
                                ? Color.fromARGB(255, 175, 145, 140)
                                : null,
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                            ),
                            tileColor: _isSelected[3]
                                ? Color.fromARGB(255, 175, 145, 140)
                                : null,
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
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Column(
                    children: [
                      Switch(
                        thumbIcon: thumbIcon,
                        value: switchIsApiMode,
                        onChanged: (value) {
                          setState(() {
                            switchIsApiMode = value;
                            util.setIsApiMode(value);
                          });
                        },
                      ),
                      Text(
                        "Change to API Mode",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
