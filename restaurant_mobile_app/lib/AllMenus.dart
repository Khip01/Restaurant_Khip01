import 'package:flutter/material.dart';
import 'package:restaurant_mobile_app/controllers/menu_controller.dart';
import 'package:restaurant_mobile_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_mobile_app/models/menu.dart';

class AllMenus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getMenuRequest();
    return FutureBuilder(
      future: getMenuRequest(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data["All Menu"].length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(10, 5, 5, 10),
                  height: 180,
                  child: Card(
                    elevation: 5,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            snapshot.data["All Menu"][index]["menu_name"],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Row(
                            children: [
                              Text(
                                "Desc: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(snapshot.data["All Menu"][index]
                                  ["description"]),
                            ],
                          ),
                          Text(
                            "Rp. " +
                                snapshot.data["All Menu"][index]["price"]
                                    .toString(),
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.lightGreen,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        } else {
          return Container(
            child: Stack(children: [
              Positioned.fill(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Container(
                          padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: Text("Failed to load the data,\ncheck the API connection!", textAlign: TextAlign.center,)),
                    ],
                  ),
                ),
              ),
            ]),
          );
        }
      },
    );
  }
}
