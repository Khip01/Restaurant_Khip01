import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_mobile_app/Utils/util.dart';
import 'package:restaurant_mobile_app/controllers/menu_controller.dart';
import 'package:restaurant_mobile_app/data_dummy/menu_dummy.dart';

class ShowUpdateMenu extends StatefulWidget {
  final int indexMenu;
  final Map? menu;

  const ShowUpdateMenu({Key? key, required this.indexMenu, required this.menu})
      : super(key: key);

  @override
  State<ShowUpdateMenu> createState() => _ShowUpdateMenuState();
}

bool isApiMode = true;

class _ShowUpdateMenuState extends State<ShowUpdateMenu> {
  Util util = new Util();
  MenuDummy menuDummy = new MenuDummy();

  // Controller untuk masing masing textFormField
  var nameField = TextEditingController();
  var descField = TextEditingController();
  var priceField = TextEditingController();

  // Key Untuk TextFormField
  var _formKey = GlobalKey<FormState>();

  bool nameIsWarning = false, descIsWarning = false, priceIsWarning = false;

  @override
  void initState() {
    nameField.text = isApiMode ? (this.widget.menu?["menu_name"]) : menuDummy.menu[this.widget.indexMenu]["menu_name"];
    descField.text = isApiMode ? (this.widget.menu?["description"]) : menuDummy.menu[this.widget.indexMenu]["description"];
    priceField.text = isApiMode ? (this.widget.menu?["price"].toString()) : menuDummy.menu[this.widget.indexMenu]["price"];
    super.initState();
  }

  void _doUpdateData (bool isDataChanged) {
    if (isApiMode && isDataChanged) {
      updateMenuRequest(this.widget.menu?["id"], nameField.text, descField.text, int.parse(priceField.text));
    }
    // Mengubah Index yang aktif
    setState(() {
      util.setIsActiveIndex(2);
    });
    // Berpindah ke Halaman List Update Menu
    Navigator.pop(context);
    // Show SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isDataChanged ? "Data Updated Successfully!" : "No changes made"),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  bool isFieldChanged () {
    if (nameField.text != ((isApiMode) ? (this.widget.menu?["menu_name"]) : (menuDummy.menu[this.widget.indexMenu]["menu_name"])) ||
        descField.text != ((isApiMode) ? (this.widget.menu?["description"]) : (menuDummy.menu[this.widget.indexMenu]["description"])) ||
        priceField.text != ((isApiMode) ? (this.widget.menu?["price"]).toString() : (menuDummy.menu[this.widget.indexMenu]["price"]))
    ) {
      return true;
    }
    return false;
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
                            Flexible(
                              flex: 1,
                              child: BackButtonSection(),
                            ),
                            Flexible(
                              flex: 4,
                              child: FormSection(),
                            ),
                            Flexible(
                              flex: 3,
                              child: BottomButtonSection(),
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

  Widget BackButtonSection() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
      alignment: Alignment.centerLeft,
      child: ElevatedButton(
        onPressed: () {
          if (nameIsWarning || descIsWarning || priceIsWarning) {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text("Are you sure?"),
                content: const Text(
                    "Are you sure to cancel all unsaved data?\nAll data that you have changed will be lost."),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                    ),
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Navigator.popUntil(
                        context,
                        ModalRoute.withName("/"),
                      );
                    },
                    child: Text(
                      "Yes",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          } else {
            Navigator.popUntil(
              context,
              ModalRoute.withName("/"),
            );
          }
        },
        child: SizedBox(
          width: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.arrow_back, color: Colors.white),
              Text("Back",
                  style: TextStyle(
                      color: Color.fromARGB(255, 245, 245, 245), fontSize: 14))
            ],
          ),
        ),
        style: ElevatedButton.styleFrom(
          // shape: CircleBorder(),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(100))),
          padding: EdgeInsets.all(10),
          backgroundColor: Colors.brown,
          // <-- Button color
          foregroundColor: Colors.red, // <-- Splash color
        ),
      ),
    );
  }

  Widget FormSection() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
        alignment: Alignment.centerLeft,
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Form Title
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Edit Menu Details",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Edit this menu for more interesting details!",
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
              ),
              // Form Body
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "This field is required! "
                          "";
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(
                        color: nameIsWarning
                            ? Color.fromARGB(255, 222, 174, 31)
                            : nameField.text == ""
                                ? Colors.red
                                : Colors.brown),
                    // errorText: "Error",
                    helperText: nameIsWarning
                        ? "Careful, you have unsaved changes"
                        : null,
                    helperStyle:
                        TextStyle(color: Color.fromARGB(255, 222, 174, 31)),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: nameIsWarning
                                ? Color.fromARGB(255, 222, 174, 31)
                                : Colors.brown)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: nameIsWarning
                                ? Color.fromARGB(255, 222, 174, 31)
                                : Colors.brown,
                            width: 2)),
                  ),
                  controller: nameField,
                  // onTap: () async {
                  // //workaround to make text selection working
                  // await Future.delayed(const Duration(milliseconds: 500));
                  //
                  // nameField.selection = TextSelection(
                  //     baseOffset: 0, extentOffset: nameField.text.length);
                  // },
                  onChanged: (value) {
                    if (isApiMode) {
                      if ((this.widget.menu?["menu_name"] == nameField.text) ||
                          value.isEmpty)
                        setState(() {
                          nameIsWarning = false;
                        });
                      else
                        setState(() {
                          nameIsWarning = true;
                        });
                      _formKey.currentState!.validate();
                    } else {
                      if ((menuDummy.menu[this.widget.indexMenu]["menu_name"] ==
                              nameField.text) ||
                          value.isEmpty)
                        setState(() {
                          nameIsWarning = false;
                        });
                      else
                        setState(() {
                          nameIsWarning = true;
                        });
                      _formKey.currentState!.validate();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "This field is required!";
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: TextStyle(
                        color: descIsWarning
                            ? Color.fromARGB(255, 222, 174, 31)
                            : descField.text == ""
                                ? Colors.red
                                : Colors.brown),
                    // errorText: "Error",
                    helperText: descIsWarning
                        ? "Careful, you have unsaved changes"
                        : null,
                    helperStyle:
                        TextStyle(color: Color.fromARGB(255, 222, 174, 31)),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: descIsWarning
                                ? Color.fromARGB(255, 222, 174, 31)
                                : Colors.brown)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: descIsWarning
                                ? Color.fromARGB(255, 222, 174, 31)
                                : Colors.brown,
                            width: 2)),
                  ),
                  controller: descField,
                  // onTap: () async {
                  //   //workaround to make text selection working
                  //   await Future.delayed(const Duration(milliseconds: 500));
                  //
                  //   descField.selection = TextSelection(
                  //       baseOffset: 0, extentOffset: descField.text.length);
                  // },
                  onChanged: (value) {
                    if (isApiMode) {
                      if ((this.widget.menu?["description"] ==
                              descField.text) ||
                          value.isEmpty)
                        setState(() {
                          descIsWarning = false;
                        });
                      else
                        setState(() {
                          descIsWarning = true;
                        });
                      _formKey.currentState!.validate();
                    } else {
                      if ((menuDummy.menu[this.widget.indexMenu]
                                  ["description"] ==
                              descField.text) ||
                          value.isEmpty)
                        setState(() {
                          descIsWarning = false;
                        });
                      else
                        setState(() {
                          descIsWarning = true;
                        });
                      _formKey.currentState!.validate();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "This field is required!";
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Price",
                    labelStyle: TextStyle(
                        color: priceIsWarning
                            ? Color.fromARGB(255, 222, 174, 31)
                            : priceField.text == ""
                                ? Colors.red
                                : Colors.brown),
                    // errorText: "Error",
                    helperText: priceIsWarning
                        ? "Careful, you have unsaved changes"
                        : null,
                    helperStyle:
                        TextStyle(color: Color.fromARGB(255, 222, 174, 31)),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: priceIsWarning
                                ? Color.fromARGB(255, 222, 174, 31)
                                : Colors.brown)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: priceIsWarning
                                ? Color.fromARGB(255, 222, 174, 31)
                                : Colors.brown,
                            width: 2)),
                  ),
                  controller: priceField,
                  // onTap: () async {
                  //   //workaround to make text selection working
                  //   await Future.delayed(const Duration(milliseconds: 500));
                  //
                  //   priceField.selection = TextSelection(
                  //       baseOffset: 0, extentOffset: priceField.text.length);
                  // },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) {
                    if (isApiMode) {
                      if ((this.widget.menu?["price"].toString() == priceField.text) ||
                          value.isEmpty)
                        setState(() {
                          priceIsWarning = false;
                        });
                      else
                        setState(() {
                          priceIsWarning = true;
                        });
                      _formKey.currentState!.validate();
                    } else {
                      if ((menuDummy.menu[this.widget.indexMenu]["price"] ==
                              priceField.text) ||
                          value.isEmpty)
                        setState(() {
                          priceIsWarning = false;
                        });
                      else
                        setState(() {
                          priceIsWarning = true;
                        });
                      _formKey.currentState!.validate();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget BottomButtonSection() {
    return SingleChildScrollView(
      child: Container(
        height: 135,
        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 4.0,
                ),
                onPressed: () {
                    _doUpdateData(isFieldChanged());
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
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 4.0,
                ),
                onPressed: () {
                  setState(() {
                    nameField.text =
                        isApiMode ? (this.widget.menu?["menu_name"]) : menuDummy.menu[this.widget.indexMenu]["menu_name"];
                    nameIsWarning = false;
                    descField.text =
                    isApiMode ? (this.widget.menu?["description"]) : menuDummy.menu[this.widget.indexMenu]["description"];
                    descIsWarning = false;
                    priceField.text =
                    isApiMode ? (this.widget.menu?["price"].toString()) : menuDummy.menu[this.widget.indexMenu]["price"];
                    priceIsWarning = false;
                  });
                  _formKey.currentState!.validate();
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
    );
  }
}
