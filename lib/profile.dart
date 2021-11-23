import 'package:aniket/helper.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(children: <Widget>[
        Container(
          height: 200,
          width: 200,
          child: Image.asset('assets/images/profile.png'),
        ),
        Text('Name: Aniket Verma'),
        Text('Email:aniketverma98@gmail.com'),
        Text('Phone:9479754811'),
        Text('Github Link: https://github.com/VerMi20'),
        ElevatedButton(
          onPressed: () {
            setDateSharedPreferences(DateTime(2000, 1, 1).toString());
          },
          child: Text('Reset'),
        )
      ]
          // Text('LinkedIn Link: https://www.linkedin.com/in/aniket-verma-b9a8b917b/'),
          ),
    );
  }
}
