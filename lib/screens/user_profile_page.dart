import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Profile',
        style: TextStyle(
            color: Colors.black,
        ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 33.0,
                    child: CircleAvatar(
                      radius: 30.0,
                      child: ClipOval(
                        child: Image.asset('images/newimage.png'),
                      ),
                      backgroundColor: Colors.white,
                    ),
                  )



                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
