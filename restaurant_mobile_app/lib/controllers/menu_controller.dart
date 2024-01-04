import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_mobile_app/Utils/util.dart';

import '../models/menu.dart';

/*
  For Your Information:
  192.168.88.246 this is the IP where you allocate your API calls,
  in this case I use my local WiFi IP so that I can access the API
  via my mobile phone to demonstrate my Android Application.
*/

// If You have IP address for IP,
// then set the default at the SharedPregerence in main.dart file
// in initState

// String getIP(){
//   Util util = new Util();
//   String ip;
//   util.getApiAddress().then((ipValue) =>  ip = ipValue);
//   return ip;
// }

Util util = Util();

Future<String> getAPI () => util.getApiAddress().then((api) => api);

// GET API Req
Future getMenusRequest() async {
  String api = await getAPI();

  final uri = Uri.parse("${api}Menus");
  final response = await http.get(uri);

  // Check status Request
  if (response.statusCode == 200) {
    return json.decode(response.body);
  }

  throw Exception("Failed to Load Menu");
}

// POST API Req
Future<Menu> postMenuRequest(String menuName, String description, int price) async {
  String api = await getAPI();

  // Declare Map for store the data value
  Map<String, dynamic> request = {
    "menu_name": menuName,
    "description": description,
    "price": price,
  };

  final uri = Uri.parse("${api}Menu");
  final response = await http.post(uri, body: json.encode(request));

  // Check status Request
  if (response.statusCode == 200) {
    return Menu.fromJson(json.decode(response.body));
  }

  throw Exception("Failed to Create the Data");
}

// UPDATE API Req
Future<Menu> updateMenuRequest(
    int id, String menuName, String description, int price) async {
  String api = await getAPI();

  // Declare Map for store the data value
  Map<String, dynamic> request = {
    "menu_name": menuName,
    "description": description,
    "price": price,
  };

  final uri = Uri.parse("${api}Menu/${id}");
  final response = await http.put(uri, body: json.encode(request));

// Check status Request
  if (response.statusCode == 200) {
    return Menu.fromJson(json.decode(response.body));
  }

  throw Exception("Failed to Update the Data!");
}

// DELETE API Req
Future<Menu?>? deleteMenuRequest(int id) async {
  String api = await getAPI();

  final uri = Uri.parse("${api}Menu/${id}");
  final response = await http.delete(uri);

  // Check status Request
  if (response.statusCode == 200) {
    return null;
  }

  throw Exception("Error Failed to Delete the Data");
}
