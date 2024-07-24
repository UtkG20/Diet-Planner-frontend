import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InfoScreenState();
  }
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About Me')),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [],
        ),
      )),
    );
  }
}
