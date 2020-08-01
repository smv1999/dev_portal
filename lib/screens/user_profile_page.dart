import 'dart:collection';
import 'dart:io';

import 'package:dev_portal/services/ProgressBar.dart';
import 'package:dev_portal/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  ProgressBar _sendingMsgProgressBar;
  FirebaseStorage _storage = FirebaseStorage.instance;
  DatabaseReference myRef;
  Auth auth = new Auth();
  String _profile_image,
      firstName,
      lastName,
      dob,
      phoneNumber,
      summary,
      email,
      username,
      website,
      employmentTitle,
      stackoverflow,
      youtube,
      skills,
      linkedin,
      medium,
      github;
  @override
  void initState() {
    super.initState();
    _sendingMsgProgressBar = ProgressBar();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add Your Code here.
      showSendingProgressBar();
      setState(() {
        _setData();
      });
    });
  }

  @override
  void dispose() {
    _sendingMsgProgressBar.hide();
    super.dispose();
  }

  @override
  void showSendingProgressBar() {
    _sendingMsgProgressBar.show(context);
  }

  @override
  void hideSendingProgressBar() {
    _sendingMsgProgressBar.hide();
  }

  @override
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
                _profile_image != null
                    ? InkWell(
                        child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 50.0,
                        child: CircleAvatar(
                          radius: 48.0,
                          backgroundImage: new NetworkImage(_profile_image),
                          backgroundColor: Colors.white,
                        ),
                      ))
                    : InkWell(
                        child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 50.0,
                        child: CircleAvatar(
                          radius: 48.0,
                          backgroundImage: AssetImage('images/newimage.png'),
                          backgroundColor: Colors.white,
                        ),
                      )),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'First Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(firstName ?? 'First Name'),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Last Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(lastName ?? 'Last Name'),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Date of birth',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(dob ?? 'DOB'),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Summary',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(summary ?? 'Summary'),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(email ?? 'Email'),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Username',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(username ?? 'Username'),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Website',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,),
                ),
                SizedBox(
                  height: 6.0,
                ),
                GestureDetector(
                  onTap: () => _launchURL(website),
                child:Text(website ?? 'Website',
                    style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: Colors.lightBlueAccent)),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Phone Number',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(phoneNumber ?? 'Phone Number'),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Employment Title',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(employmentTitle ?? 'Employment Title'),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Skills/Languages',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 6.0,
                ),
                Text(skills ?? 'Skills'),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'YouTube Channel URL',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,),
                ),
                SizedBox(
                  height: 6.0,
                ),
                GestureDetector(
                onTap: () => _launchURL(youtube),
                child:Text(youtube ?? 'YouTube',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        color: Colors.lightBlueAccent)
                ),),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Stack Overflow Profile URL',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,),
                ),
                SizedBox(
                  height: 6.0,
                ),
                GestureDetector(
                  onTap: () => _launchURL(stackoverflow),
                child:Text(stackoverflow ?? 'Stack Overflow',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        color: Colors.lightBlueAccent)
                ),),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'LinkedIn profile URL',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,),
                ),
                SizedBox(
                  height: 6.0,
                ),
                GestureDetector(
                  onTap: () => _launchURL(linkedin),
                child:Text(linkedin ?? 'LinkedIn',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        color: Colors.lightBlueAccent)
                ),),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Medium profile URL',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,),
                ),
                SizedBox(
                  height: 6.0,
                ),
                GestureDetector(
                  onTap: () => _launchURL(medium),
                child:Text(medium ?? 'Medium',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        color: Colors.lightBlueAccent)
                ),),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'GitHub profile URL',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,),
                ),
                SizedBox(
                  height: 6.0,
                ),
                GestureDetector(
                  onTap: () => _launchURL(github),
                child:Text(github ?? 'GitHub',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        color: Colors.lightBlueAccent)
                ),),
                SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> _setData() async {
    // retrieve from Firebase DB and display
    final FirebaseUser user = await auth.getCurrentUser();
    final userId = user.uid;
    StorageReference reference = _storage.ref().child(userId).child("Images/");
    myRef = FirebaseDatabase.instance.reference().child('Users').child(userId);
    myRef.once().then((DataSnapshot dataSnapshot) {
      setState(() {
        _profile_image = dataSnapshot.value["imagepath"];
        firstName = dataSnapshot.value["firstname"];
        lastName = dataSnapshot.value["lastname"];
        dob = dataSnapshot.value["dob"];
        summary = dataSnapshot.value["summary"];
        email = dataSnapshot.value["email"];
        username = dataSnapshot.value["username"];
        website = dataSnapshot.value["website"];
        phoneNumber = dataSnapshot.value["phonenumber"];
        employmentTitle = dataSnapshot.value["employmenttitle"];
        skills = dataSnapshot.value["skills"];
        youtube = dataSnapshot.value["youtube"];
        stackoverflow = dataSnapshot.value["stackoverflow"];
        linkedin = dataSnapshot.value["linkedin"];
        medium = dataSnapshot.value["medium"];
        github = dataSnapshot.value["github"];

        hideSendingProgressBar();
      });
    });
  }
  void _launchURL(website) async{
    var url = 'https://'+website;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
