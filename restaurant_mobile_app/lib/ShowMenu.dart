import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_mobile_app/controllers/menu_controller.dart';
import 'package:restaurant_mobile_app/data_dummy/menu_dummy.dart';
import 'package:shimmer/shimmer.dart';

class ShowMenu extends StatelessWidget {
  // Product from All Menus Dart
  final Map menu;
  final bool isApiMode;

  ShowMenu({required this.menu, required this.isApiMode});

  @override
  Widget build(BuildContext context) {
    debugPrint("Hai");
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 245, 245, 245),
        body: ListView(
          children: [
            BackButton(context),
            PreviewMenuCard(),
            OtherMenuSection(),
          ],
        ),
      ),
    );
  }

  Widget BackButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 15, 0, 20),
      alignment: Alignment.centerLeft,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back, color: Colors.white),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(10),
          backgroundColor: Colors.brown, // <-- Button color
          foregroundColor: Colors.red, // <-- Splash color
        ),
      ),
    );
  }

  Widget PreviewMenuCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      margin: EdgeInsets.fromLTRB(20, 0, 30, 50),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(menu["menu_name"], style: TextStyle(fontSize: 30)),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(menu["description"], style: TextStyle(fontSize: 15)),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                  "Rp. " + menu["price"].toString(),
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.lightGreen,
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }

  Widget OtherMenuSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OtherMenuSectionTitle(),
        OtherMenuSectionBody(),
      ],
    );
  }

  Widget OtherMenuSectionTitle() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
      height: 50,
      child: Text(
        "Other Menu",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget OtherMenuSectionBody() {
    if (isApiMode) {
      return FutureBuilder(
        future: getMenusRequest(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return LoadOtherMenuSectionBody(snapshot);
          } else {
            if (snapshot.hasError) {
              return OtherMenuSectionError();
            }
            return ShimmerOtherMenuSection();
          }
        },
      );
    } else {
      return LoadOtherMenuSectionBody();
    }
  }

  Widget LoadOtherMenuSectionBody([AsyncSnapshot<dynamic>? snapshot]) {
    MenuDummy menuDummy = MenuDummy();

    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      height: 130.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: isApiMode == false
            ? menuDummy.menu.length
            : snapshot?.data["All Menu"].length,
        itemBuilder: (BuildContext context, int i) {
          if ((isApiMode == false
                  ? menuDummy.menu[i]["menu_name"]
                  : snapshot?.data["All Menu"][i]["menu_name"]) !=
              menu["menu_name"]) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (value) => ShowMenu(
                          menu: isApiMode == false
                              ? menuDummy.menu[i]
                              : snapshot?.data["All Menu"][i],
                          isApiMode: isApiMode),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                    width: 250.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          isApiMode == false
                              ? menuDummy.menu[i]["menu_name"]
                              : snapshot?.data["All Menu"][i]["menu_name"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          isApiMode == false
                              ? menuDummy.menu[i]["description"]
                              : snapshot?.data["All Menu"][i]["description"],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text(
                          "Rp. " +
                              (isApiMode == false
                                      ? menuDummy.menu[i]["price"]
                                      : snapshot?.data["All Menu"][i]["price"])
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
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  Widget OtherMenuSectionError() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      height: 130.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 2,
        itemBuilder: (BuildContext context, int i) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
            child: Card(
              color: Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                width: 250.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning,
                      color: Colors.blueGrey,
                    ),
                    Text(
                      "Failed to load the data, check the API connection!",
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget ShimmerOtherMenuSection() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      height: 130.0,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 2,
          itemBuilder: (BuildContext context, int i) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                  width: 250.0,
                  child: SizedBox(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
