import 'package:flutter/material.dart';
import 'package:restaurant_mobile_app/settings_screens/about_screen.dart';
import 'package:restaurant_mobile_app/settings_screens/api_endpoint_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // shape: Border(
        //   bottom: BorderSide(color: Colors.black, width: 0.2),
        // ),
      ),
      body: MainScreen(context),
    );
  }

  Widget MainScreen(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.edit_location_alt),
            title: Text("Set API Endpoint"),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            // shape: Border(
            //   bottom: BorderSide(color: Colors.grey, width: 0.1),
            // ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ApiEndpoint()));
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("About this app"),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            // shape: Border(
            //   bottom: BorderSide(color: Colors.grey, width: 0.1)
            // ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => About()));
            },
          )
        ],
      ),
    );
  }

}
