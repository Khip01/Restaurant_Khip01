import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurant_mobile_app/controllers/menu_controller.dart';
import 'package:restaurant_mobile_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_mobile_app/models/menu.dart';
import 'package:shimmer/shimmer.dart';

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
          // return Container(
          //   child: Stack(children: [
          //     Positioned.fill(
          //       child: Container(
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             CircularProgressIndicator(),
          //             Container(
          //                 padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
          //                 child: Text("Failed to load the data,\ncheck the API connection!", textAlign: TextAlign.center,)),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ]),
          // );
          if (snapshot.hasError) {
            return Container(
              child: Stack(children: [
                Positioned.fill(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Text(
                              "404\nNOT FOUND",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
                            )),
                        SvgPicture.asset(
                          'assets/NotFound.svg',
                          semanticsLabel: 'Not Found 404',
                          width: 300,
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: Text(
                              "Failed to load the data, check the API connection!",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                ),
              ]),
            );
          }
          return Container(
            height: 720,
            width: double.infinity,
            child: Shimmer.fromColors(
              child: ListView.builder(
                itemCount: 5,
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
                          children: [],
                        ),
                      ),
                    ),
                  );
                },
              ),
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
            ),
          );
        }
      },
    );
  }
}
