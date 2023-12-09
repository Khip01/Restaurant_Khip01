import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurant_mobile_app/ShowMenu.dart';
import 'package:restaurant_mobile_app/Utils/util.dart';
import 'package:restaurant_mobile_app/controllers/menu_controller.dart';
import 'package:restaurant_mobile_app/data_dummy/carousel_dummy.dart';
import 'package:restaurant_mobile_app/data_dummy/menu_dummy.dart';
import 'package:shimmer/shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AllMenus extends StatefulWidget {
  @override
  State<AllMenus> createState() => _AllMenusState();
}

bool isApiMode = false;
Util util = new Util();

class _AllMenusState extends State<AllMenus> {
  // Init untuk mengubah IsApiMode
  void initMode() {
    util.getIsApiMode().then((value) {
      setState(() {
        isApiMode = value;
        // debugPrint(value.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    initMode(); // Mengecek secara terus menerus kondisi dari isApiMode
    MenuDummy menuDummy = new MenuDummy(); // Dummy for menu

    // debugPrint(isApiMode.toString());
    if (isApiMode) {
      return FutureBuilder(
        future: getMenusRequest(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data["All Menu"].length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ShowMenu(
                              menu: snapshot.data["All Menu"][index],
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
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
                              Container(
                                height: 55,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Desc: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      snapshot.data["All Menu"][index]
                                          ["description"],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
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
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 30),
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
    } else {
      //// IF IS API MODE FALSE
      return Container(
        height: double.maxFinite,
        child: Stack(
          children: [
            Column(
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    color: Colors.brown,
                  ),
                ),
                Spacer(),
                Flexible(
                  flex: 6,
                  child: ListView.builder(
                    itemCount: menuDummy.menu.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ShowMenu(
                                  menu: menuDummy.menu[index],
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(20, 5, 20, 10),
                          height: 150,
                          child: Card(
                            elevation: 5,
                            // shape: RoundedRectangleBorder(
                            //   borderRadius: BorderRadius.circular(20),
                            // ),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    menuDummy.menu[index]["menu_name"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    menuDummy.menu[index]["description"],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "Rp. " +
                                        menuDummy.menu[index]["price"]
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
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Container(
              width: double.maxFinite,
              height: 200,
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    carouselShow(context),
                    ClipRRect(
                      // Clip it cleanly.
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                        child: Container(
                          color: Colors.black.withOpacity(0.4),
                          alignment: Alignment.topLeft,
                          // child: Padding(
                          // padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
                          child: Container(
                            height: 400,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Khip's Cafe",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                                carouselTextShow(context),
                              ],
                            ),
                          ),
                          // ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }
  }

  Widget carouselShow(BuildContext context) {
    CarouselDummy carouselDummy = new CarouselDummy();

    return CarouselSlider(
      options: CarouselOptions(
          height: double.maxFinite, autoPlay: true, viewportFraction: 1),
      items: [0, 1, 2, 3].map(
        (index) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: 900,
                padding: EdgeInsets.zero,
                // margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: Colors.amber),
                child: Image(
                  image: AssetImage(
                    carouselDummy.image[index],
                  ),
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        },
      ).toList(),
    );
  }

  Widget carouselTextShow(BuildContext context) {
    CarouselDummy carouselDummy = new CarouselDummy();

    return CarouselSlider(
      options: CarouselOptions(
        height: 30,
        autoPlay: true,
        viewportFraction: 1,
        scrollDirection: Axis.vertical,
      ),
      items: [0, 1, 2, 3].map(
        (index) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                height: 35,
                child: Text(
                  carouselDummy.subTitle[index],
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              );
            },
          );
        },
      ).toList(),
    );
  }
}
