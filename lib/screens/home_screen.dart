import 'dart:math';

import 'package:diet_planner_frontend/screens/profile_screen.dart';
import 'package:diet_planner_frontend/services/local_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  // int _selectedNavigationIndex = 1;
  // static final List<Widget> items = [
  //   LoginScreen(),
  //   HomeScreen(),
  //   DietscheduleScreen()
  // ];
  Color _inkWellcolor = Colors.orange;
  double? _currentWeight = 74.50;
  double? _targetWeight = 72.00;

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedNavigationIndex = index;
  //   });
  // }

  void _onPressed() {
    print('Button pressed');
    setState(() {
      _inkWellcolor =
          _inkWellcolor == Colors.orange ? Colors.blue : Colors.orange;
    });
  }

  Widget _circularWidget(Widget icon, double angle) {
    return CircleAvatar(
      radius: 33,
      child: Transform.rotate(
        angle: angle,
        child: icon,
      ),
    );
  }

  void _showReminderPermissionDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              height: MediaQuery.of(context).size.width * 0.4,
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text('Set Hourly Reminder',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    'Dring a glass of water on every reminder to stay hydrated',
                    style: TextStyle(textBaseline: TextBaseline.ideographic),
                  ),
                  Expanded(
                      child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              LocalNotification.showPeriodicNotification(
                                  title: 'Drink water',
                                  body:
                                      'Have one glass of water to keep your body hydrated',
                                  payload: 'Water reminder notification');
                              Navigator.of(context).pop();
                            },
                            child: Text('Set')),
                      ),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Not Now')),
                      )
                    ],
                  ))
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 250, 223, 186),
        title: Text('Home'),
        actions: [
          CircleAvatar(
            backgroundColor: Color.fromARGB(255, 220, 231, 121),
            child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
                icon: Icon(Icons.person)),
          ),
          SizedBox(
            width: 15.0,
          )
        ],
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Health Tracker',
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
          ),
          Container(
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                  width: 0.5, color: const Color.fromARGB(255, 118, 148, 119)),
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
              child: Row(
                children: [
                  Container(
                    child: Column(
                      children: [
                        _circularWidget(
                            Icon(
                              FontAwesomeIcons.shoePrints,
                              color: Color.fromARGB(255, 162, 167, 7),
                            ),
                            3 * 3.14 / 2),
                        Text('Steps')
                      ],
                    ),
                  ),
                  SizedBox(width: 25),
                  GestureDetector(
                      child: Container(
                        child: Column(
                          children: [
                            _circularWidget(
                                Icon(
                                  FontAwesomeIcons.cloudMoon,
                                  color: Color.fromARGB(255, 73, 8, 86),
                                ),
                                0),
                            Text('Sleep')
                          ],
                        ),
                      ),
                      onTap: () {
                        LocalNotification.showSimpleNotification(
                            title: 'Simple title',
                            body: 'Simple body',
                            payload: 'Simple payload');
                      }),
                  SizedBox(width: 25),
                  GestureDetector(
                    child: Container(
                      child: Column(
                        children: [
                          _circularWidget(
                              Icon(
                                FontAwesomeIcons.glassWater,
                                color: Colors.blue,
                              ),
                              0),
                          Text('Water')
                        ],
                      ),
                    ),
                    onTap: () {
                      _showReminderPermissionDialog(context);
                      //   LocalNotification.showPeriodicNotification(
                      //       title: 'Drink water',
                      //       body: 'Have one glass of water and remain hydrated',
                      //       payload: 'Water reminder notification');
                    },
                  ),
                  SizedBox(width: 25),
                  Container(
                    child: Column(
                      children: [
                        _circularWidget(
                            Icon(
                              FontAwesomeIcons.dumbbell,
                              color: Color.fromARGB(255, 211, 78, 78),
                            ),
                            0),
                        Text('Workout')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Weight Tracker',
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
          ),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(width: 2, color: Colors.brown),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(5, 5), // changes position of shadow
                  ),
                ],
              ),
              // color: Color.fromARGB(255, 197, 246, 245),
              height: 130,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        child: Column(children: [
                          Text('Current'),
                          Row(
                            children: [
                              Text(
                                _currentWeight.toString(),
                                style: TextStyle(fontSize: 30),
                              ),
                              Text('  KGs')
                            ],
                          )
                        ]),
                      ),
                      // Text('Current wt'),
                      SizedBox(width: 15),
                      Icon(
                        Icons.arrow_forward,
                        size: 35,
                      ),
                      SizedBox(width: 15),
                      Container(
                        child: Column(children: [
                          Text('Target'),
                          Row(
                            children: [
                              Text(
                                _targetWeight.toString(),
                                style: TextStyle(fontSize: 30),
                              ),
                              Text('  KGs')
                            ],
                          )
                        ]),
                      ),
                      // Text('Target wt')
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                        onTapDown: (_) => _onPressed(),
                        onTapUp: (_) => _onPressed(),
                        child: Text(
                          'Update current weight',
                          style: TextStyle(color: _inkWellcolor),
                        )),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
              ))
        ]),
      )),
    );
  }
}
