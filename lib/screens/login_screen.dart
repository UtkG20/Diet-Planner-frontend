import 'package:diet_planner_frontend/screens/main_screen.dart';
import 'package:diet_planner_frontend/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _response = "";

  var userType = ['Doctor', 'Client'];
  String? userTypeSelected = 'Client';

  Future<void> login() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/client/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "username": usernameController.text,
        "password": passwordController.text
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String token = data['token'];
      await _auth.write('AuthToken', token);
      setState(() {
        _response = data['username'];
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainScreen()));
    } else {
      _response = "Failed to login";
    }
  }

  void _onPressed() {
    login();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Welcome to DigiDoc"),
        // ),
        body: SingleChildScrollView(
      child: Center(
        child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: usernameController,
                  decoration: InputDecoration(
                      labelText: "Username",
                      hintText: "Enter your name or Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(width: 2))),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Enter your login password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButton<String>(
                    items: userType.map((item) {
                      return (DropdownMenuItem(child: Text(item), value: item));
                    }).toList(),
                    value: userTypeSelected,
                    onChanged: (String? user) {
                      setState(() {
                        userTypeSelected = user;
                      });
                    }),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: _onPressed,
                  // style: ButtonStyle(backgroundColor: Colors.black)
                ),
                Text(_response + "logged in successfully")
              ],
            )),
      ),
    ));
  }
}
