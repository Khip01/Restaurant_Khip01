import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_mobile_app/data_dummy/menu_dummy.dart';

class ShowMenu extends StatelessWidget {
  // Product from All Menus Dart
  final Map menu;

  ShowMenu({required this.menu});

  @override
  Widget build(BuildContext context) {
    MenuDummy menuDummy = new MenuDummy();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 245, 245, 245),
        body: ListView(
          children: [
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              margin: EdgeInsets.fromLTRB(20, 0, 30, 50),
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(menu["menu_name"],
                          style: TextStyle(fontSize: 30)),
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
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
              height: 50,
              child: Text(
                "Other Menu",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                height: 130.0,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: menuDummy.menu.length,
                    itemBuilder: (BuildContext context, int i) {
                      if (menuDummy.menu[i]["menu_name"] != menu["menu_name"]) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (value) =>
                                          ShowMenu(menu: menuDummy.menu[i])));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 5,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                                width: 250.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      menuDummy.menu[i]["menu_name"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      menuDummy.menu[i]["description"],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    Text("Rp. "+
                                      menuDummy.menu[i]["price"],
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.lightGreen,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
