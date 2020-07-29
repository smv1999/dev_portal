import 'dart:io';

import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  File _image;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  // Launch Edit Profile
                  Navigator.of(context).pushNamed('/editprofile');
                },
                child: Icon(Icons.edit),
              )),
        ],
        actionsIconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            InkWell(
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 40.0,
                  child: CircleAvatar(
                    radius: 38.0,
                    child: ClipOval(
                      child: (_image != null)
                          ? Image.file(_image)
                          : Image.asset('images/newimage.png'),
                    ),
                    backgroundColor: Colors.white,
                  ),
                )
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    )
    );
  }
}

