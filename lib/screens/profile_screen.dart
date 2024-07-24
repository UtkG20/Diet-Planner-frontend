import 'dart:convert';

import 'package:diet_planner_frontend/screens/home_screen.dart';
import 'package:diet_planner_frontend/screens/info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = "";
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  Future<void> getUserDetails() async {
    String? token = await _auth.read('AuthToken');
    final response = await http.get(
      Uri.parse("http://10.0.2.2:8080/client/currentUser"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      print('My method is called!');
      var data = response.body;
      setState(() {
        _name = data;
      });

      print(_name);
    } else {
      setState(() {
        this._name = "User...";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Color.fromARGB(155, 220, 227, 207),
        ),
        body: Center(
            child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color.fromARGB(255, 245, 241, 241)),
                // color: Color.fromARGB(255, 245, 241, 241),
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              child: Icon(
                                Icons.person,
                                size: 45,
                                color: Color.fromARGB(179, 13, 53, 60),
                              ),
                              radius: 40,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              child: Column(children: [
                                Text(
                                  _name,
                                  style: TextStyle(
                                      fontSize: 35,
                                      color: Color.fromARGB(179, 46, 10, 10)),
                                )
                              ]),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Color.fromARGB(255, 222, 225, 225),
                          indent: 40,
                          endIndent: 40,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                          Color.fromARGB(255, 218, 182, 227),
                                      radius: 30,
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.format_quote,
                                            size: 30,
                                          )),
                                    ),
                                    Text('Bio')
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                          Color.fromARGB(255, 218, 182, 227),
                                      radius: 30,
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.notifications,
                                            size: 30,
                                          )),
                                    ),
                                    Text('Notifications')
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            Color.fromARGB(255, 218, 182, 227),
                                        radius: 30,
                                        child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.settings,
                                              size: 30,
                                            )),
                                      ),
                                      Text('Settings')
                                    ],
                                  ))
                            ],
                          ),
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color.fromARGB(181, 220, 191, 224),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(children: [
                              Text(
                                'Measurements',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Color.fromRGBO(227, 150, 102, 1)),
                              ),
                              Spacer(),
                              Expanded(
                                  child: Icon(
                                Icons.arrow_right,
                                size: 40,
                              ))
                            ]),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color.fromARGB(181, 220, 191, 224),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(children: [
                              Text(
                                'Medical History',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Color.fromRGBO(227, 150, 102, 1)),
                              ),
                              Spacer(),
                              Expanded(
                                  child: Icon(
                                Icons.arrow_right,
                                size: 40,
                              ))
                            ]),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InfoScreen()));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color.fromARGB(181, 220, 191, 224),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(children: [
                              Text(
                                'Basic Information',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Color.fromRGBO(227, 150, 102, 1)),
                              ),
                              Spacer(),
                              Expanded(
                                  child: Icon(
                                Icons.arrow_right,
                                size: 40,
                              ))
                            ]),
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        )));
  }
}
