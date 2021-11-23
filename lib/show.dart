import 'package:aniket/helper.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';

class Show extends StatefulWidget {
  DateTime selectedDate;
  Show({Key? key, required this.selectedDate}) : super(key: key);

  @override
  _ShowState createState() => _ShowState();
}

class _ShowState extends State<Show> {
  late DateTime selectedDate;
  String ImageUrl = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedDate = widget.selectedDate;
    getImageUrl(
            '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}')
        .then((value) => setState(() => ImageUrl = value));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        selectedDate = DateTime(2000, 1, 1);
        // Navigator.pop(context, selectedDate);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Show'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              InkWell(
                onLongPress: () {
                  BottomPicker.date(
                      title: "Select Date",
                      onSubmit: (date) {
                        setState(() {
                          selectedDate = date;
                          getImageUrl((selectedDate as DateTime).toString())
                              .then(
                                  (value) => setState(() => ImageUrl = value));
                          setDateSharedPreferences(selectedDate.toString());
                        });
                      }).show(context);
                },
                child: Image.network(
                  ImageUrl,
                  height: 200,
                  width: 200,
                  errorBuilder: (context, url, error) {
                    return Icon(Icons.error);
                  },
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Image.asset('assets/placeholder.jpg');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
