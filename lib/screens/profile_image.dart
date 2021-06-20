import 'package:flutter/material.dart';

class ProfileImage extends StatefulWidget {
  final String image, name;
  ProfileImage({Key key, @required this.image, @required this.name})
      : super(key: key);
  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        title: Text(
          widget.name,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'MyFont',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 130.0,
        child: CircleAvatar(
          radius: 128.0,
          backgroundImage: new NetworkImage(widget.image),
          backgroundColor: Colors.white,
        ),
      )),
    );
  }
}
