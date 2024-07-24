import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../services/auth_service.dart';

class ValueWrapper<T> {
  T value;
  ValueWrapper(this.value);
}

enum MealType { BREAKFAST, LUNCH, SNACKS, DINNER }

class DietscheduleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DietscheduleScreenState();
  }
}

class _DietscheduleScreenState extends State<DietscheduleScreen> {
  final AuthService _auth = AuthService();

  DateTime _selectedDate = DateTime.now();

  String _breakfastContent = "";
  String _lunchContent = "";
  String _snacksContent = "";
  String _dinnerContent = "";

  ValueWrapper<IconData?> _plusMinusIconBr = ValueWrapper(Icons.add);
  ValueWrapper<double> _heightBr = ValueWrapper(0);
  ValueWrapper<double> _widthBr = ValueWrapper(0);
  ValueWrapper<String> _contentBr = ValueWrapper("");

  ValueWrapper<IconData?> _plusMinusIconLu = ValueWrapper(Icons.add);
  ValueWrapper<double> _heightLu = ValueWrapper(0);
  ValueWrapper<double> _widthLu = ValueWrapper(0);
  ValueWrapper<String> _contentLu = ValueWrapper("");

  ValueWrapper<IconData?> _plusMinusIconSn = ValueWrapper(Icons.add);
  ValueWrapper<double> _heightSn = ValueWrapper(0);
  ValueWrapper<double> _widthSn = ValueWrapper(0);
  ValueWrapper<String> _contentSn = ValueWrapper("");

  ValueWrapper<IconData?> _plusMinusIconDi = ValueWrapper(Icons.add);
  ValueWrapper<double> _heightDi = ValueWrapper(0);
  ValueWrapper<double> _widthDi = ValueWrapper(0);
  ValueWrapper<String> _contentDi = ValueWrapper("");

  Future<String> getMealbyDateAndType(DateTime date, String mealType) async {
    String formattedDate = date.toIso8601String().split('T')[0];
    String? token = await _auth.read('AuthToken');
    final response = await http.get(
      Uri.parse(
          'http://10.0.2.2:8080/client/getSchedule/date/$formattedDate/$mealType'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['mealDesc'];
    } else {
      return "Not scheduled by your Doctor";
    }
  }

  Widget _mealTypeWidget(
      ValueWrapper<IconData?> plusMinusIcon,
      ValueWrapper<double> height,
      ValueWrapper<double> width,
      ValueWrapper<String> content,
      String mealType,
      String mealContent) {
    return Padding(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Column(children: [
          GestureDetector(
            onTap: () async {
              mealContent = await getMealbyDateAndType(_selectedDate, mealType);
              setState(() {
                plusMinusIcon.value =
                    plusMinusIcon.value == Icons.add ? Icons.remove : Icons.add;
                height.value = plusMinusIcon.value == Icons.remove ? 100 : 0;
                width.value = plusMinusIcon.value == Icons.remove
                    ? MediaQuery.of(context).size.width * 0.5
                    : 0;
                // content.value = plusMinusIcon.value == Icons.remove
                //     ? "2 glass of water along with an apple or banana and an egg -----------------------------------------------------------------------------------------------------------------------------------------------------------------"
                //     : "";
                content.value =
                    plusMinusIcon.value == Icons.remove ? mealContent : "";
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueAccent),
              width: MediaQuery.of(context).size.width * 0.5,
              height: 40,
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    mealType,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  Expanded(child: SizedBox()),
                  Icon(
                    plusMinusIcon.value,
                    color: Colors.white,
                    weight: 20,
                    size: 25,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 70,
              maxWidth: MediaQuery.of(context).size.width * 0.5,
              minWidth: 0,
            ),
            child: AnimatedContainer(
              color: Color.fromARGB(255, 216, 226, 232),
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              child: SingleChildScrollView(
                child: Text(
                  textAlign: TextAlign.center,
                  content.value,
                  style: TextStyle(color: Colors.black),
                ),
                // ),
              ),
            ),
          )
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diet'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
                decoration:
                    BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
                height: 180,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    Expanded(
                      child: CupertinoDatePicker(
                        initialDateTime: _selectedDate,
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (DateTime newDate) {
                          setState(() {
                            _selectedDate = newDate;
                          });
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _plusMinusIconBr = ValueWrapper(Icons.add);
                          _plusMinusIconLu = ValueWrapper(Icons.add);
                          _plusMinusIconSn = ValueWrapper(Icons.add);
                          _plusMinusIconDi = ValueWrapper(Icons.add);
                          _contentBr = ValueWrapper("");
                          _contentLu = ValueWrapper("");
                          _contentSn = ValueWrapper("");
                          _contentDi = ValueWrapper("");
                          // getMealbyDateAndType(_selectedDate, "BREAKFAST");
                        });
                      },
                      child: Text('Set Date'),
                    ),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _mealTypeWidget(_plusMinusIconBr, _heightBr, _widthBr,
                        _contentBr, "BREAKFAST", _breakfastContent),
                    _mealTypeWidget(_plusMinusIconLu, _heightLu, _widthLu,
                        _contentLu, "LUNCH", _lunchContent),
                    _mealTypeWidget(_plusMinusIconSn, _heightSn, _widthSn,
                        _contentSn, "SNACKS", _snacksContent),
                    _mealTypeWidget(_plusMinusIconDi, _heightDi, _widthDi,
                        _contentDi, "DINNER", _dinnerContent),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
