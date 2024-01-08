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

bool isApiMode = true;
Util util = new Util();

// Dropdown Filter ----
const List<String> filterList = <String>[
  "latest",
  "a - z",
  "z - a",
  "cheapest",
  "highest price"
];

// NOTE: this is really important, it will make overscroll look the same on both platforms
// sc : https://stackoverflow.com/a/73986079/20483243
class _ClampingScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      ClampingScrollPhysics();
}

class _AllMenusState extends State<AllMenus> {
  // Init untuk mengubah IsApiMode
  void initMode() {
    util.getIsApiMode().then((value) {
      setState(() {
        isApiMode = value;
      });
    });
  }

  String filterValue = filterList.first;

  @override
  Widget build(BuildContext context) {
    Util util = Util();

    // initMode(); // Mengecek secara terus menerus kondisi dari isApiMode (Tetapi akan setState Terus ke Widget  dan mengakibatkan spam di permintaan request ke API getMenusRequest())
    util.getApiAddress().then((value) => debugPrint("Get Request at ${value}"));
    isApiMode = true; // development mode to test both isApiMode Swicth

    if (isApiMode) {
      return RefreshablePage();
    } else {
      //// IF IS API MODE FALSE
      return AllMenuPage(isApiMode);
    }
  }

  Widget RefreshablePage() {
    // Setting for page that can be refreshed on both device Android || IOS
    return LayoutBuilder(builder: (_, constraint) {
      return RefreshIndicator(
        onRefresh: () async {
          setState(() {});
          await Future.delayed(Duration(milliseconds: 500));
          // return getMenusRequest();
        },
        child: ScrollConfiguration(
          behavior: _ClampingScrollBehavior(),
          child: SingleChildScrollView(
            // Set Page can be scroll (coz Refreshable need Scroll behavior)
            physics: AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: constraint.maxHeight,
                  maxHeight: constraint.maxHeight),
              child: MainPage(),
            ),
          ),
        ),
      );
    });
  }

  Widget MainPage() {
    return FutureBuilder(
      future: getMenusRequest(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return AllMenuPageError();
        } else if (snapshot.hasData) {
          return AllMenuPage(isApiMode, snapshot);
        } else
          return ShimmerAllMenu(context);
      },
    );
  }

  Widget carouselShow(BuildContext context, bool isShimmer) {
    CarouselDummy carouselDummy = new CarouselDummy();

    return CarouselSlider(
      options: CarouselOptions(
          height: double.maxFinite, autoPlay: true, viewportFraction: 1),
      items: [0, 1, 2, 3].map(
        (index) {
          return Builder(
            builder: (BuildContext context) {
              return isShimmer == false
                  ? Container(
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
                    )
                  : SizedBox();
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
        height: 50,
        autoPlay: true,
        viewportFraction: 1,
        scrollDirection: Axis.vertical,
      ),
      items: [0, 1, 2, 3].map(
        (index) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                height: 50,
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

  Widget AllMenuPage(bool isAPIMode, [AsyncSnapshot<dynamic>? snapshot]) {
    MenuDummy menuDummy = new MenuDummy(); // Dummy for menu

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
              Flexible(
                flex: 2,
                child: Container(
                  height: double.maxFinite,
                  margin: EdgeInsets.fromLTRB(20, 50, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 60,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "All Menu's",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            SizedBox(
                                height: 25,
                                child: Center(
                                    child: Text("Let's look at some menus!"))),
                          ],
                        ),
                      ),
                      SizedBox(height: 60, child: FilterSection()),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: ListView.builder(
                  itemCount: isAPIMode == true
                      ? snapshot?.data["All Menu"].length
                      : menuDummy.menu.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ShowMenu(
                                menu: isAPIMode == true
                                    ? snapshot?.data["All Menu"][index]
                                    : menuDummy.menu[index],
                                isApiMode: isAPIMode,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  isAPIMode == true
                                      ? snapshot?.data["All Menu"][index]
                                          ["menu_name"]
                                      : menuDummy.menu[index]["menu_name"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  isAPIMode == true
                                      ? snapshot?.data["All Menu"][index]
                                          ["description"]
                                      : menuDummy.menu[index]["description"],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Rp. " +
                                      (isAPIMode == true
                                              ? snapshot?.data["All Menu"]
                                                  [index]["price"]
                                              : menuDummy.menu[index]["price"])
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
                  carouselShow(context, false),
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
                                  fontSize: 20,
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

  Widget ShimmerAllMenu(BuildContext context) {
    return Container(
      height: double.maxFinite,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Stack(
          children: [
            Column(
              children: [
                Spacer(),
                Spacer(),
                Spacer(),
                Flexible(
                  flex: 6,
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.fromLTRB(20, 5, 20, 10),
                        height: 150,
                        child: Card(
                          elevation: 5,
                          child: Container(
                            height: 200,
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                ),
              ],
            ),
            Container(
              width: double.maxFinite,
              height: 200,
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: carouselShow(context, true),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget AllMenuPageError() {
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

  Widget FilterSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          height: 25,
          child: Center(child: Text("Sort by")),
        ),
        SizedBox(
          height: 25,
          child: DropdownButton(
            underline: SizedBox(),
            icon: Icon(Icons.sort),
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            value: filterValue,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
            items: filterList.map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(3, 2, 5, 2),
                    child: Text(
                      value,
                      textAlign: TextAlign.right,
                    ),
                  ),
                );
              },
            ).toList(),
            onChanged: (String? value) {
              setState(() {
                filterValue = value!;
              });
            },
          ),
        ),
      ],
    );
  }
}
