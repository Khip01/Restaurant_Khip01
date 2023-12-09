import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_mobile_app/data_dummy/carousel_dummy.dart';
import 'package:restaurant_mobile_app/data_dummy/menu_dummy.dart';
import 'package:restaurant_mobile_app/data_dummy/type_menu_dummy.dart';

class DeleteMenu extends StatefulWidget {
  @override
  State<DeleteMenu> createState() => _DeleteMenuState();
}

class _DeleteMenuState extends State<DeleteMenu> {
  TypeMenuDummy typeMenuDummy = new TypeMenuDummy();

  MenuDummy menuDummy = new MenuDummy();

  CarouselDummy carouselDummy = new CarouselDummy();

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: ListView.builder(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              scrollDirection: Axis.horizontal,
              itemCount: typeMenuDummy.typeMenu.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: typeMenuDummy.typeMenu[index]
                              ["isSelected"]
                          ? Color.fromARGB(255, 175, 145, 140)
                          : Colors.brown,
                    ),
                    onPressed: () {
                      setState(() {
                        // Set isSelected untuk item yang ditekan
                        typeMenuDummy.typeMenu[index]["isSelected"] =
                            !typeMenuDummy.typeMenu[index]["isSelected"];
                        // Mengurutkan berdasarkan abjad
                        typeMenuDummy.typeMenu
                            .sort((a, b) => a["Type"].compareTo(b["Type"]));
                        // Menyortir kembali daftar setelah mengubah nilai
                        typeMenuDummy.typeMenu
                            .sort((a, b) => (a["isSelected"] == b["isSelected"])
                                ? 0
                                : a["isSelected"]
                                    ? -1
                                    : 1);
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Text(
                            typeMenuDummy.typeMenu[index]["Type"],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        if (typeMenuDummy.typeMenu[index]["isSelected"])
                          Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Flexible(
              flex: 3,
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                width: double.maxFinite,
                height: double.maxFinite,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 5,
                  child: Stack(
                    children: [
                      carouselShow(context),
                      ClipRRect(
                        // Clip it cleanly.
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                          child: Container(
                            color: Colors.black.withOpacity(0.1),
                            alignment: Alignment.center,
                            child: Container(
                              height: 25,
                              child: carouselTextShow(context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          Flexible(
            flex: 5,
            child: ListView.builder(
              itemCount: menuDummy.menu.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                      height: 180,
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 5,
                        // child: Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        // Flexible(
                        //   flex: 3,
                        child: Dismissible(
                          key: Key(menuDummy.menu[index]["menu_name"]),
                          onDismissed: (DismissDirection direction) {
                            setState(() {
                              Map deletedMenu = menuDummy.menu.removeAt(index);
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                        "${deletedMenu["menu_name"]} Deleted"),
                                    action: SnackBarAction(
                                        label: "UNDO",
                                        onPressed: () => setState(() {
                                              menuDummy.menu
                                                  .insert(index, deletedMenu);
                                            })),
                                  ),
                                );
                            });
                          },
                          direction: DismissDirection.endToStart,
                          background: Container(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            alignment: Alignment.centerRight,
                            color: Colors.red,
                            child: Icon(
                              Icons.delete_outline,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          dismissThresholds: {DismissDirection.endToStart: 0.4},
                          confirmDismiss: (DismissDirection direction) async {
                            return await showDialog(context: context, builder: (BuildContext context){
                                return AlertDialog(
                                  title: const Text("Confirm"),
                                  content: const Text("Are you sure you wish to delete this item?"),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () => Navigator.of(context).pop(true),
                                        child: const Text("DELETE", style: TextStyle(color: Colors.red),)
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(false),
                                      child: const Text("CANCEL"),
                                    ),
                                  ],
                                );
                            },);
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  menuDummy.menu[index]["menu_name"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Container(
                                  height:65,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Desc: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        menuDummy.menu[index]["description"],
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "Rp. " +
                                      menuDummy.menu[index]["price"].toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.lightGreen,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        // ),
                        // Flexible(
                        //   flex: 1,
                        //   child: Container(
                        //     height: double.maxFinite,
                        //     child: ElevatedButton(
                        //       style: ElevatedButton.styleFrom(
                        //           primary: Color.fromARGB(
                        //               255, 198, 178, 169),
                        //           shape: RoundedRectangleBorder(
                        //               borderRadius:
                        //               BorderRadius.circular(0))),
                        //       child: Icon(
                        //         Icons.edit_square,
                        //         color: Colors.brown,
                        //       ),
                        //       onPressed: () =>
                        //           _showModalBottomSheet(context, index),
                        //     ),
                        //   ),
                        // )
                        //   ],
                        // ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
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
      items: [0, 1].map(
            (index) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                height: 35,
                child: Text(
                  carouselDummy.subTitleDelete[index],
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

  Widget carouselShow(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          height: double.maxFinite, autoPlay: true, viewportFraction: 1),
      items: [0, 1].map((index) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              child: Image(
                image: AssetImage(
                  carouselDummy.imageDelete[index],
                ),
                fit: BoxFit.cover,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
