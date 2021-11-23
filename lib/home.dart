import 'package:aniket/helper.dart';
import 'package:aniket/show.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl_browser.dart'

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime _selectedDate = DateTime.now();
  String day = "";
  void asyncFunctions() async {
    await Future.delayed(Duration(seconds: 1));
    print('asyncFunctions');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String date = "";
    getDateSharedPreferences().then((value) {
      if (value != null) {
        date = value;
      } else {
        date = DateTime(2000, 1, 1).toString();
      }
      _selectedDate = DateTime.parse(date);
      setState(() {
        day = DateFormat('EEEE').format(_selectedDate);
      });
    });
    // _selectedDate = DateTime.parse(
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorMap[day],
      body: SafeArea(
        child: Container(
            child: Column(children: <Widget>[
          Text(
            "Selected Date: ${_selectedDate.toString()}",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            child: Text('Select Date', style: TextStyle(fontSize: 20, color: day=='Tuesday'?Colors.white:Colors.black)),
            onTap: () {
              BottomPicker.date(
                title: "Select Date",
                bottomPickerTheme: BOTTOM_PICKER_THEME.PLUM_PLATE,
                onChange: (date) {
                  // print((date as DateTime).toString());
                  setState(() {
                    day = DateFormat('EEEE').format(date);
                  });
                },
                onSubmit: (date) {
                  _selectedDate = date;
                  setState(() {
                    day = DateFormat('EEEE').format(_selectedDate);
                  });
                  setDateSharedPreferences(_selectedDate.toString());
                },
              ).show(context);
            },
          ),
          InkWell(
            child: Text('Show',style: TextStyle(fontSize: 20, color: day=='Tuesday'?Colors.white:Colors.black)),
            onTap: () {
              if (_selectedDate.isAfter(DateTime.now())) {
                showDialog(
                    context: context,
                    builder: (context) {
                      day = "Error";
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Date cannot be in future'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Ok'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    });
              } else if (_selectedDate.isBefore(DateTime(1995, 06, 16))) {
                showDialog(
                    context: context,
                    builder: (context) {
                      day = "Error";
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Date cannot be in past'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Ok'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    });
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Show(
                              selectedDate: _selectedDate,
                            )));
              }
            },
          )
        ])),
      ),
    );
  }
}
