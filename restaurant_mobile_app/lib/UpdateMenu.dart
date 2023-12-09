import 'package:flutter/material.dart';
import 'package:restaurant_mobile_app/ShowUpdateMenu.dart';
import 'package:restaurant_mobile_app/data_dummy/menu_dummy.dart';
import 'package:restaurant_mobile_app/data_dummy/type_menu_dummy.dart';

class UpdateMenu extends StatefulWidget {
  @override
  State<UpdateMenu> createState() => _UpdateMenuState();
}

class _UpdateMenuState extends State<UpdateMenu> {
  MenuDummy menuDummy = new MenuDummy();
  TypeMenuDummy typeMenuDummy = new TypeMenuDummy();

  @override
  void initState() {
    // Mengurutkan berdasarkan abjad
    typeMenuDummy.typeMenu.sort((a, b) => a["Type"].compareTo(b["Type"]));
    // Menyortir kembali daftar setelah mengubah nilai
    typeMenuDummy.typeMenu.sort((a, b) => (a["isSelected"] == b["isSelected"])
        ? 0
        : a["isSelected"]
            ? -1
            : 1);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
                            typeMenuDummy.typeMenu.sort(
                                (a, b) => (a["isSelected"] == b["isSelected"])
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
                flex: 8,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Container(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 20, 20, 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          menuDummy.menu[index]["menu_name"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Container(
                                          height: 55,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Desc: ",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                menuDummy.menu[index]
                                                    ["description"],
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
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
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    height: double.maxFinite,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Color.fromARGB(
                                              255, 198, 178, 169),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0))),
                                      child: Icon(
                                        Icons.edit_square,
                                        color: Colors.brown,
                                      ),
                                      onPressed: () =>
                                          _showModalBottomSheet(context, index),
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
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showModalBottomSheet(BuildContext context, int index) {
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
                            "Are You sure to Edit Menu " +
                                menuDummy.menu[index]["menu_name"] +
                                "?",
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return ShowUpdateMenu(indexMenu: index);
                                    }),
                                  );
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
