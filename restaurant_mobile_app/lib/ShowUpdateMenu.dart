import 'package:flutter/material.dart';
import 'package:restaurant_mobile_app/Utils/util.dart';
import 'package:restaurant_mobile_app/data_dummy/menu_dummy.dart';

class ShowUpdateMenu extends StatefulWidget {
  final int indexMenu;

  const ShowUpdateMenu({Key? key, required this.indexMenu}) : super(key: key);

  @override
  State<ShowUpdateMenu> createState() => _ShowUpdateMenuState();
}

class _ShowUpdateMenuState extends State<ShowUpdateMenu>{
  Util util = new Util();
  MenuDummy menuDummy = new MenuDummy();

  var nameField = TextEditingController();
  var descField = TextEditingController();
  var priceField = TextEditingController();

  @override
  void initState() {
    nameField.text = menuDummy.menu[this.widget.indexMenu]["menu_name"];
    descField.text = menuDummy.menu[this.widget.indexMenu]["description"];
    priceField.text = menuDummy.menu[this.widget.indexMenu]["price"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Container(
                  color: Colors.brown,
                  height: 300,
                  width: double.maxFinite,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                    child: Text(
                      "UPDATE THE MENU!",
                      style: TextStyle(
                        fontSize: 30,
                        color: Color.fromARGB(255, 245, 245, 245),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0, 2),
                  child: Container(
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black,
                          blurRadius: 20,
                          offset: Offset(0, 7),
                        ),
                      ],
                    ),
                    child: Card(
                      elevation: 5,
                      color: Color.fromARGB(255, 245, 245, 245),
                      margin: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Container(
                        alignment: Alignment.topLeft,
                        width: double.maxFinite,
                        height: MediaQuery.of(context).size.height - 100,
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                              alignment: Alignment.centerLeft,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.popUntil(
                                    context,
                                    ModalRoute.withName("/"),
                                  );
                                },
                                child: SizedBox(
                                  width: 80,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.arrow_back,
                                          color: Colors.white),
                                      Text("Back",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 245, 245, 245),
                                              fontSize: 14))
                                    ],
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  // shape: CircleBorder(),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100))),
                                  padding: EdgeInsets.all(10),
                                  backgroundColor: Colors.brown,
                                  // <-- Button color
                                  foregroundColor:
                                  Colors.red, // <-- Splash color
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Edit Menu Details",
                                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Edit this menu for more interesting details!",
                                          style: TextStyle(fontSize: 14),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "Name",
                                        // errorText: "Error",
                                        border: OutlineInputBorder(),
                                      ),
                                      controller: nameField,
                                      onTap: () async {
                                        // //workaround to make text selection working
                                        // await Future.delayed(const Duration(milliseconds: 500));
                                        //
                                        // nameField.selection = TextSelection(
                                        //     baseOffset: 0, extentOffset: nameField.text.length);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: TextField(
                                      maxLines: 4,
                                      decoration: InputDecoration(
                                        labelText: "Description",
                                        // errorText: "Error",
                                        border: OutlineInputBorder(),
                                      ),
                                      controller: descField,
                                      // onTap: () async {
                                      //   //workaround to make text selection working
                                      //   await Future.delayed(const Duration(milliseconds: 500));
                                      //
                                      //   descField.selection = TextSelection(
                                      //       baseOffset: 0, extentOffset: descField.text.length);
                                      // },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "Price",
                                        // errorText: "Error",
                                        border: OutlineInputBorder(),
                                      ),
                                      controller: priceField,
                                      // onTap: () async {
                                      //   //workaround to make text selection working
                                      //   await Future.delayed(const Duration(milliseconds: 500));
                                      //
                                      //   priceField.selection = TextSelection(
                                      //       baseOffset: 0, extentOffset: priceField.text.length);
                                      // },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 135,
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(25),
                                        ),
                                        elevation: 4.0,
                                      ),
                                      onPressed: () {
                                        // Mengubah Index yang aktif
                                        setState(() {
                                          util.setIsActiveIndex(2);
                                        });
                                        // Berpindah ke halaman AllMenus()
                                        Navigator.popUntil(
                                          context,
                                          // MaterialPageRoute(
                                          //     builder: (value) => MainApp()),
                                          // (route) => route.isFirst,
                                          ModalRoute.withName("/"),

                                        );
                                        // Show SnackBar
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                                "Data Updated Successfully! (Again, Later hehe :p)"),
                                            behavior: SnackBarBehavior.floating,
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          "Update the Menu!",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150,
                                    height: 50,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.redAccent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(25),
                                        ),
                                        elevation: 4.0,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          nameField.text = menuDummy.menu[this.widget.indexMenu]["menu_name"];
                                          descField.text = menuDummy.menu[this.widget.indexMenu]["description"];
                                          priceField.text = menuDummy.menu[this.widget.indexMenu]["price"];
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          "Reset All Field",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
