import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Utils/util.dart';

class ApiEndpoint extends StatefulWidget {
  ApiEndpoint({Key? key}) : super(key: key);

  @override
  State<ApiEndpoint> createState() => _ApiEndpointState();
}

class _ApiEndpointState extends State<ApiEndpoint> {
  Util util = Util();

  String currentEndpoint = "loading..";

  final endpointTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Function that use check Connection
  Future<bool> checkConnection(String endpoint) async {
    try {
      final uri = Uri.parse("${endpoint}Menus");
      final response = await http.get(uri);
      return response.statusCode == 200 ? true : false;
    } catch (e) {
      return false;
    }
  }

  void _saveApiAddress (bool isValid, String endpoint) {
    isValid ? util.setApiAddress(endpoint) : null;
    _showSnackbar(context, isValid, true);
  }

  @override
  Widget build(BuildContext context) {
    util.getApiAddress().then((value) => currentEndpoint = value);

    return Scaffold(
      appBar: AppBar(
        title: Text("API Endpoint"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // shape: Border(
        //   bottom: BorderSide(color: Colors.black, width: 0.2),
        // ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Is your RESTful API endpoint different? \nOr do you have your own endpoint? \nYou can set it here",
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if(value == null || value.isEmpty)
                          return "This field is required";
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        labelText: "current endpoint: ${currentEndpoint}",
                        floatingLabelStyle: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      controller: endpointTextController,
                    ),
                  ],
                ),
              ),
              Container(
                width: double.maxFinite,
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate())
                            return await checkConnection(
                                        endpointTextController.text) ==
                                    true
                                ? _showSnackbar(context, true, false)
                                : _showSnackbar(context, false, false);
                        },
                        child: Text("Check Connection"),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()){
                            bool result = await checkConnection(endpointTextController.text);
                            setState(() {
                                _saveApiAddress(result, endpointTextController.text);
                            });
                          }
                        },
                        child: Text("Save"),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
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
    );
  }

  void _showSnackbar(BuildContext context, bool isValid, bool saveMode) {
    // Show SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isValid
            ? saveMode ? "Connection Saved Successfully!" : "Connection Success! Don't forget to save the endpoint"
            : "Connection failed! Try Correcting the endpoint address"),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isValid ? Colors.lightGreen : Colors.redAccent,
      ),
    );
  }
}
