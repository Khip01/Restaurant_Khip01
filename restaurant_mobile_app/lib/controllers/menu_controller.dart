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

String ip = "";
// If You have IP address for IP,
// then set the default at the SharedPregerence in main.dart file
// in initState

// String getIP(){
//   Util util = new Util();
//   String ip;
//   util.getApiAddress().then((ipValue) =>  ip = ipValue);
//   return ip;
// }

_loadRequirements() async {
  Util util = new Util();
  util.getApiAddress().then((apiIp){
    ip = apiIp;
  });
}

// GET API Req
Future getMenusRequest() async {
  await _loadRequirements();
  final uri = Uri.parse("http://$ip:8081/api/Menus");
  final response = await http.get(uri);

  // Check status Request
  if (response.statusCode == 200) {
    return json.decode(response.body);
  }

  throw Exception("Failed to Load Menu");
}

// POST API Req
Future<Menu> postMenuRequest(String menuName, String description, int price) async {
  _loadRequirements();
  // Declare Map for store the data value
  Map<String, dynamic> request = {
    "menu_name": menuName,
    "description": description,
    "price": price,
  };

  final uri = Uri.parse("http://$ip:8081/api/Menu");
  final response = await http.post(uri, body: json.encode(request));

  // Check status Request
  if (response.statusCode == 201) {
    return Menu.fromJson(json.decode(response.body));
  }

  throw Exception("Failed to Create the Data");
}

// UPDATE API Req
Future<Menu> updateMenuRequest(
    String id, String menuName, String description, int price) async {
  await _loadRequirements();
  // Declare Map for store the data value
  Map<String, dynamic> request = {
    "menu_name": menuName,
    "description": description,
    "price": price,
  };

  final uri = Uri.parse("http://$ip:8081/api/Menu/" + id);
  final response = await http.put(uri, body: request);

// Check status Request
  if (response.statusCode == 200) {
    return Menu.fromJson(json.decode(response.body));
  }

  throw Exception("Failed to Update the Data!");
}

// DELETE API Req
Future<Menu?>? deleteMenuRequest(String id) async {
  await _loadRequirements();
  final uri = Uri.parse("http://$ip:8081/api/Menu/" + id);
  final response = await http.delete(uri);

  // Check status Request
  if (response.statusCode == 200) {
    return null;
  }

  throw Exception("Error Failed to Delete the Data");
}
