import 'package:dev_portal/services/ProgressBar.dart';
import 'package:dev_portal/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewProfile extends StatefulWidget {
  final String text;
  ViewProfile({Key key, @required this.text}) : super(key: key);
  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  ProgressBar _sendingMsgProgressBar;
  FirebaseStorage _storage = FirebaseStorage.instance;
  DatabaseReference profileRef, userRef;
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
        retrieveProfileData(widget.text);
      });
    });
  }

  @override
  void dispose() {
    _sendingMsgProgressBar.hide();
    super.dispose();
  }

  void showSendingProgressBar() {
    _sendingMsgProgressBar.show(context);
  }

  void hideSendingProgressBar() {
    _sendingMsgProgressBar.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'MyFont',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(0.0),
          child: ListView(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(20.0),
                  color: Colors.blue,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      _profile_image != null
                          ? InkWell(
                              child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50.0,
                              child: CircleAvatar(
                                radius: 48.0,
                                backgroundImage:
                                    new NetworkImage(_profile_image),
                                backgroundColor: Colors.white,
                              ),
                            ))
                          : InkWell(
                              child: CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 50.0,
                              child: CircleAvatar(
                                radius: 48.0,
                                backgroundImage:
                                    NetworkImage('https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/newimage.png'),
                                backgroundColor: Colors.white,
                              ),
                            )),
                      SizedBox(
                        height: 15.0,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: new TextSpan(
                          children: <TextSpan>[
                            new TextSpan(
                                text: 'This is ',
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.white)),
                            new TextSpan(
                              text: firstName,
                              style: new TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 15.0,
              ),
              Card(
                margin: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Text(
                        'First Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'MyFont',
                            fontSize: 16.0),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      Text(firstName ?? 'First Name',
                          style: GoogleFonts.ptSansNarrow(
                              textStyle: TextStyle(fontSize: 16.0))),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Last Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'MyFont',
                            fontSize: 16.0),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      Text(
                        lastName ?? 'Last Name',
                        style: GoogleFonts.ptSansNarrow(
                            textStyle: TextStyle(fontSize: 16.0)),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Date of birth',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'MyFont',
                            fontSize: 16.0),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      Text(
                        dob ?? 'DOB',
                        style: GoogleFonts.ptSansNarrow(
                            textStyle: TextStyle(fontSize: 16.0)),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Summary',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'MyFont',
                            fontSize: 16.0),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      Text(
                        summary ?? 'Summary',
                        style: GoogleFonts.ptSansNarrow(
                            textStyle: TextStyle(fontSize: 16.0)),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Email',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'MyFont',
                            fontSize: 16.0),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      Text(
                        email ?? 'Email',
                        style: GoogleFonts.ptSansNarrow(
                            textStyle: TextStyle(fontSize: 16.0)),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Username',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'MyFont',
                            fontSize: 16.0),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      Text(
                        username ?? 'Username',
                        style: GoogleFonts.ptSansNarrow(
                            textStyle: TextStyle(fontSize: 16.0)),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Website',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'MyFont',
                            fontSize: 16.0),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      GestureDetector(
                        onTap: () => _launchURL(website),
                        child: Text(website ?? 'Website',
                            style: TextStyle(
                                fontFamily: 'MyFont',
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                decoration: TextDecoration.underline,
                                color: Colors.lightBlueAccent)),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Phone Number',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            fontFamily: 'MyFont'),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      Text(
                        phoneNumber ?? 'Phone Number',
                        style: GoogleFonts.ptSansNarrow(
                            textStyle: TextStyle(fontSize: 16.0)),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Employment Title',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'MyFont',
                            fontSize: 16.0),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      Text(
                        employmentTitle ?? 'Employment Title',
                        style: GoogleFonts.ptSansNarrow(
                            textStyle: TextStyle(fontSize: 16.0)),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Skills/Languages',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'MyFont',
                            fontSize: 16.0),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      Text(
                        skills ?? 'Skills',
                        style: GoogleFonts.ptSansNarrow(
                            textStyle: TextStyle(fontSize: 16.0)),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'YouTube Channel URL',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'MyFont',
                            fontSize: 16.0),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      GestureDetector(
                        onTap: () => _launchURL(youtube),
                        child: Text(youtube ?? 'YouTube',
                            style: TextStyle(
                                fontFamily: 'MyFont',
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                decoration: TextDecoration.underline,
                                color: Colors.lightBlueAccent)),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Stack Overflow Profile URL',
                        style: TextStyle(
                          fontFamily: 'MyFont',
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      GestureDetector(
                        onTap: () => _launchURL(stackoverflow),
                        child: Text(stackoverflow ?? 'Stack Overflow',
                            style: TextStyle(
                                fontFamily: 'MyFont',
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                fontSize: 16.0,
                                color: Colors.lightBlueAccent)),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'LinkedIn profile URL',
                        style: TextStyle(
                          fontFamily: 'MyFont',
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      GestureDetector(
                        onTap: () => _launchURL(linkedin),
                        child: Text(linkedin ?? 'LinkedIn',
                            style: TextStyle(
                                fontFamily: 'MyFont',
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                fontSize: 16.0,
                                color: Colors.lightBlueAccent)),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'Medium profile URL',
                        style: TextStyle(
                          fontFamily: 'MyFont',
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      GestureDetector(
                        onTap: () => _launchURL(medium),
                        child: Text(medium ?? 'Medium',
                            style: TextStyle(
                                fontFamily: 'MyFont',
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                decoration: TextDecoration.underline,
                                color: Colors.lightBlueAccent)),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        'GitHub profile URL',
                        style: TextStyle(
                          fontFamily: 'MyFont',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      GestureDetector(
                        onTap: () => _launchURL(github),
                        child: Text(github ?? 'GitHub',
                            style: TextStyle(
                                fontFamily: 'MyFont',
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: Colors.lightBlueAccent)),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void retrieveProfileData(var userName) {
    profileRef = FirebaseDatabase.instance.reference().child('Profile');
    profileRef.once().then((DataSnapshot dataSnapshot) {
      for (var snapshot in dataSnapshot.value.values) {
        if (snapshot["username"] == userName) {
          var userId = dataSnapshot.value.keys.firstWhere(
              (k) => dataSnapshot.value[k] == snapshot,
              orElse: () => null);
          userRef = FirebaseDatabase.instance
              .reference()
              .child('Profile')
              .child(userId);
          userRef.once().then((DataSnapshot dataSnapshot) {
            setState(() {
              if (dataSnapshot.value != null) {
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
              } else {
                setState(() {
                  hideSendingProgressBar();
                });
              }
            });
          });
        }
      }
    });
  }

  void _launchURL(website) async {
    var url = 'https://' + website;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
