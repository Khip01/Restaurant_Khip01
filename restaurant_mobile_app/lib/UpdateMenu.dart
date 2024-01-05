import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurant_mobile_app/ShowUpdateMenu.dart';
import 'package:restaurant_mobile_app/controllers/menu_controller.dart';
import 'package:restaurant_mobile_app/data_dummy/menu_dummy.dart';
import 'package:restaurant_mobile_app/data_dummy/type_menu_dummy.dart';
import 'package:shimmer/shimmer.dart';

class UpdateMenu extends StatefulWidget {
  @override
  State<UpdateMenu> createState() => _UpdateMenuState();
}

bool isApiMode = true;

class _UpdateMenuState extends State<UpdateMenu> {
  MenuDummy menuDummy = new MenuDummy();
  TypeMenuDummy typeMenuDummy = new TypeMenuDummy();

  @override
  void initState() {
    // Mengurutkan berdasarkan abjad
    typeMenuDummy.typeMenu.sort((a, b) => a["Type"].compareTo(b["Type"]));
    // Menyortir kembali daftar setelah mengubah nilai
    typeMenuDummy.typeMenu.sort((a, b) => (a["isSelected"] == b["isSelected"]) ? 0 : a["isSelected"] ? -1 : 1);
    super.initState();
  }

  // Stream Controller
  // final Stream<Map> _menus = (() {
  //   while (true) {
  //     late final StreamController<Map> controller;
  //     controller = StreamController<Map>(
  //       onListen: () async {
  //         Map menu = await getMenusRequest();
  //         controller.add(menu);
  //         controller.close();
  //       }
  //     );
  //     return controller.stream;
  //   }
  // })();

  Stream<Map> getMenuStream() async* {
    while (true) {
      // METHOD 1
      // late final StreamController<Map> controller;
      // controller = StreamController<Map>(
      //     onListen: () async {
      //       Map menu = await getMenusRequest();
      //       controller.add(menu);
      //       controller.close();
      //     }
      // );
      // yield* controller.stream;

      // METHOD 2
      await Future.delayed(Duration(milliseconds: 500));

      try {
        Map menu = await getMenusRequest();
        yield menu;
      } catch (e) {
        // Handle error jika terjadi
        throw("Error fetching menus: $e");
      }
    }
  }

  Widget build(BuildContext context) {
    if (isApiMode) {
      return StreamBuilder(
        stream: getMenuStream(),
        // builder: (context, snapshot) {
        //   if (snapshot.hasError)
        //     return ErrorUpdatePage();
        //   else if (snapshot.hasData)
        //     return UpdatePage(snapshot);
        //   else
        //     return ShimmerUpdatePage();
        // },
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorUpdatePage();
          } else {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return UpdatePage();
              case ConnectionState.waiting:
                return ShimmerUpdatePage();
              case ConnectionState.active:
                return UpdatePage(snapshot);
              case ConnectionState.done:
                return UpdatePage(snapshot);
            }
          }
        },
      );
    } else
      return UpdatePage();
  }

  Widget ErrorUpdatePage() {
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
                      style:
                      TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
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

  Widget ShimmerUpdatePage() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Flexible(
          flex: 8,
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, snapshot) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                    height: 185,
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 3,
                            child: Container(
                              // padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                              // child: Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                // children: [
                                  // Text(
                                  //   isApiMode
                                  //       ? snapshot?.data["All Menu"][index]
                                  //   ["menu_name"]
                                  //       : menuDummy.menu[index]["menu_name"],
                                  //   style: TextStyle(
                                  //       fontWeight: FontWeight.bold, fontSize: 20),
                                  // ),
                                  // Container(
                                  //   height: 65,
                                  //   child: Column(
                                  //     crossAxisAlignment: CrossAxisAlignment.start,
                                  //     children: [
                                  //       Text(
                                  //         "Desc: ",
                                  //         style: TextStyle(
                                  //             fontWeight: FontWeight.bold),
                                  //       ),
                                  //       Text(
                                  //         isApiMode
                                  //             ? snapshot?.data["All Menu"][index]
                                  //         ["description"]
                                  //             : menuDummy.menu[index]
                                  //         ["description"],
                                  //         maxLines: 2,
                                  //         overflow: TextOverflow.ellipsis,
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // Text(
                                  //   "Rp. ${isApiMode ? snapshot?.data["All Menu"][index]["price"] : menuDummy.menu[index]["price"]}",
                                  //   style: TextStyle(
                                  //       fontSize: 14,
                                  //       color: Colors.lightGreen,
                                  //       fontWeight: FontWeight.bold),
                                  // )
                                // ],
                              // ),
                            ),
                          ),
                          // Flexible(
                          //   flex: 1,
                          //   child: Container(
                              // height: double.maxFinite,
                              // child: ElevatedButton(
                              //   style: ElevatedButton.styleFrom(
                              //       backgroundColor:
                              //       Color.fromARGB(255, 198, 178, 169),
                              //       shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(0))),
                              //   child: Icon(
                              //     Icons.edit_square,
                              //     color: Colors.brown,
                              //   ),
                              //   onPressed: () => _showModalBottomSheet(context,
                              //       index, snapshot?.data["All Menu"][index]),
                              // ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget UpdatePage([AsyncSnapshot? snapshot]) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
              // SortSection(),
              ListViewBodySection(snapshot),
            ],
          ),
        ),
      ],
    );
  }

  Widget ListViewBodySection(AsyncSnapshot? snapshot) {
    return Flexible(
      flex: 8,
      child: ListView.builder(
        itemCount: isApiMode
            ? snapshot?.data["All Menu"].length
            : menuDummy.menu.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                height: 185,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                isApiMode
                                    ? snapshot?.data["All Menu"][index]
                                        ["menu_name"]
                                    : menuDummy.menu[index]["menu_name"],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Container(
                                height: 65,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Desc: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      isApiMode
                                          ? snapshot?.data["All Menu"][index]
                                              ["description"]
                                          : menuDummy.menu[index]
                                              ["description"],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                "Rp. ${isApiMode ? snapshot?.data["All Menu"][index]["price"] : menuDummy.menu[index]["price"]}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.lightGreen,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          height: double.maxFinite,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 198, 178, 169),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0))),
                            child: Icon(
                              Icons.edit_square,
                              color: Colors.brown,
                            ),
                            onPressed: () => _showModalBottomSheet(context,
                                index, snapshot?.data["All Menu"][index]),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget SortSection() {
    return Flexible(
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
                backgroundColor: typeMenuDummy.typeMenu[index]["isSelected"]
                    ? Color.fromARGB(255, 175, 145, 140)
                    : Colors.brown,
              ),
              onPressed: () {
                // setState(() {
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
                // });
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
    );
  }

  void _showModalBottomSheet(BuildContext context, int index, Map? menu) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.27,
          maxChildSize: 0.27,
          minChildSize: 0.23,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 15,
                    child: Container(
                      width: 50,
                      height: 7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Text(
                            "Are You sure to Edit Menu ${(isApiMode) ? (menu?["menu_name"]) : (menuDummy.menu[index]["menu_name"])}?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orangeAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  elevation: 4.0,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,

                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return ShowUpdateMenu(
                                            indexMenu: index,
                                            menu: menu,
                                          );
                                        }),
                                  ).then((val){
                                    setState((){});
                                  });
                                },
                                child: Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(30, 15, 30, 15),
                                  child: Text(
                                    "Update",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  elevation: 4.0,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(30, 15, 30, 15),
                                  child: Text(
                                    "Cancle",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }


}
