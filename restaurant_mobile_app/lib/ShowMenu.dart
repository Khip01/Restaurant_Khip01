import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShowMenu extends StatelessWidget {
  // Product from All Menus Dart
  final Map menu;

  ShowMenu({required this.menu});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 245, 245, 245),
        body: ListView(children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 15, 0, 20),
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back, color: Colors.white),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(10),
                backgroundColor: Colors.brown, // <-- Button color
                foregroundColor: Colors.red, // <-- Splash color
              ),
            ),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 5,
            margin: EdgeInsets.fromLTRB(20, 0, 30, 50),
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child:
                        Text(menu["menu_name"], style: TextStyle(fontSize: 30)),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(menu["description"],
                        style: TextStyle(fontSize: 15)),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        "Rp. " + menu["price"].toString(),
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.lightGreen,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
