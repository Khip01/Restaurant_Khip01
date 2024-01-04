import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_mobile_app/controllers/menu_controller.dart';

import 'Utils/util.dart';

class ShowCreateMenu extends StatefulWidget {
  ShowCreateMenu({Key? key}) : super(key: key);

  @override
  State<ShowCreateMenu> createState() => _ShowCreateMenuState();
}

class _ShowCreateMenuState extends State<ShowCreateMenu> {
  Util util = new Util();

  final nameField = TextEditingController();
  final descField = TextEditingController();
  final priceField = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _submit(){
    // Mengubah Index yang aktif
    setState(() {
      postMenuRequest(
          nameField.text,
          descField.text,
          int.parse(priceField.text));
      util.setIsActiveIndex(0);
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
            "Data added Successfully! (Later :p)"),
        behavior:
        SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            child: Stack(
              children: [
                Container(
                  color: Colors.brown,
                  height: 300,
                  width: double.maxFinite,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
                    child: Text(
                      "CREATE NEW MENU!",
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
                        height: MediaQuery
                            .of(context)
                            .size
                            .height - 100,
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                alignment: Alignment.centerLeft,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
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
                            ),
                            Flexible(
                              flex: 4,
                              child: SingleChildScrollView(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  alignment: Alignment.centerLeft,
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Menu Item Details",
                                                style: TextStyle(fontSize: 18),
                                              ),
                                              Text(
                                                "Let's create a delicious new food menu!",
                                                style: TextStyle(fontSize: 14),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 20),
                                          child: TextFormField(
                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                            validator: (value){
                                              if(value == null || value.isEmpty)
                                                return "This field is required";
                                              else
                                                return null;
                                            },
                                            decoration: InputDecoration(
                                              labelText: "Name",
                                              // errorText: "Error",
                                              border: OutlineInputBorder(),
                                            ),
                                            controller: nameField,
                                            // onChanged: (value){
                                            //   if (value.isNotEmpty)
                                            //     _formKey.currentState!.validate();
                                            // },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 20),
                                          child: TextFormField(
                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                            maxLines: 4,
                                            validator: (value){
                                              if(value == null || value.isEmpty)
                                                return "This field is required";
                                              else
                                                return null;
                                            },
                                            decoration: InputDecoration(
                                              labelText: "Description",
                                              border: OutlineInputBorder(),
                                            ),
                                            controller: descField,
                                            // onChanged: (value){
                                            //   if (value.isNotEmpty)
                                            //     _formKey.currentState!.validate();
                                            // },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 20),
                                          child: TextFormField(
                                            autovalidateMode: AutovalidateMode.onUserInteraction,
                                            validator: (value){
                                              if(value == null || value.isEmpty)
                                                return "This field is required";
                                              else
                                                return null;
                                            },
                                            decoration: InputDecoration(
                                              labelText: "Price",
                                              // errorText: "Error",
                                              border: OutlineInputBorder(),
                                            ),
                                            controller: priceField,
                                            // onChanged: (value){
                                            //   if (value.isNotEmpty)
                                            //     _formKey.currentState!.validate();
                                            // },
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter.digitsOnly
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: SingleChildScrollView(
                                child: Container(
                                  height: 135,
                                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width,
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
                                            if (_formKey.currentState!.validate()) {
                                              _submit();
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Text(
                                              "Create the Menu!",
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                            nameField.clear();
                                            descField.clear();
                                            priceField.clear();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Text(
                                              "Reset All Field",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
