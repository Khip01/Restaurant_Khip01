import 'dart:ui';

import 'package:flutter/material.dart';

import 'ShowCreateMenu.dart';

class CreateMenu extends StatelessWidget {

  Widget build(BuildContext context) {
    return Scaffold(
      // Avoid widget Resize when keyboard showing up
      resizeToAvoidBottomInset: false,
      body: Container(
        // color: Colors.red,
        child: Stack(
          children: [
            Container(
              // color: Colors.grey.shade300,
              height: MediaQuery.of(context).size.height - 200,
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     fit: BoxFit.fitHeight,
              //     image: AssetImage("assets/CMenuImg1.jpg"),
              //   ),
              // ),
              // child: new BackdropFilter(
              //   filter: new ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              //   child: new Container(
              //     decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
              //   ),
              // ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/CMenuImg1.jpg', fit: BoxFit.cover),
                  ClipRRect(
                    // Clip it cleanly.
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: Container(
                        color: Colors.black.withOpacity(0.4),
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
                          child: Container(
                              child: Text(
                            'Crafting Culinary Delights',
                            style: TextStyle(
                              fontSize: 40,
                              color: Color.fromARGB(255, 245, 245, 245),
                            ),
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment(0, 1.50),
              child: Card(
                color: Color.fromARGB(255, 245, 245, 245),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 100,
                margin: EdgeInsets.all(0),
                child: Container(
                  width: double.maxFinite,
                  height: 370,
                  padding: EdgeInsets.fromLTRB(50, 40, 50, 10),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Center(
                          child: Text("Create New Menu",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                              textAlign: TextAlign.center),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Center(
                          child: Text(
                              "Add delicious and enticing menu items to your restaurant's list. With this feature, you can easily set the name, price, and description for each dish with minimal effort. Click 'Create' to get started",
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 4.0,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return ShowCreateMenu();
                              }),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text("Create!"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
