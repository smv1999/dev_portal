import 'dart:io';

import 'package:dev_portal/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

class EditUserProfile extends StatefulWidget {
  @override
  _EditUserProfileState createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  final _formKey = GlobalKey<FormState>();
  String firstname, lastname;
  Auth auth = new Auth();
  File _image;
  final picker = ImagePicker();
  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> getImage() async {
    final FirebaseUser user = await auth.getCurrentUser();
    final userId = user.uid;
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    //Create a reference to the location you want to upload to in firebase
    StorageReference reference = _storage.ref().child(userId).child("Images/");
    setState(() {
      _image = File(pickedFile.path);
    });
    //Upload the file to firebase
    StorageUploadTask uploadTask = reference.putFile(_image);

    //Snapshot of the uploading task
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    Toast.show("Profile Photo Uploaded Successfully!", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    return taskSnapshot.ref.getDownloadURL().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap:
                  // Submit Profile Details
                  _computeResult,
                child: Icon(Icons.check_circle),
              )),
        ],
        actionsIconTheme: IconThemeData(color: Colors.black),
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
                    (_image!=null) ?
                    InkWell(
                        onTap: getImage,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 60.0,
                          child: CircleAvatar(
                            radius: 58.0,
//                            child: ClipOval(
//                              child:
                               backgroundImage: new FileImage(_image),

//                            ),
                            backgroundColor: Colors.white,
                          ),
                        )
                    ):
                    InkWell(
                        onTap: getImage,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 50.0,
                          child: CircleAvatar(
                            radius: 48.0,
//                            child: ClipOval(
//                                child:
                                backgroundImage:AssetImage('images/newimage.png'),
//                                Image.asset('images/newimage.png'),
//                            ),
                            backgroundColor: Colors.white,
                          ),
                        )
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextFormField(
                        maxLines: 1,
                        validator: (val) =>
                            val.isEmpty ? 'Enter your First Name' : null,
                        onChanged: (text) {
                          setState(() {
                            firstname = text;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'First Name',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: 16.0,
                            height: 1.4,
                            color: Colors.black,
                            fontFamily: 'Montserrat')),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                        maxLines: 1,
                        validator: (val) =>
                            val.isEmpty ? 'Enter your Last Name' : null,
                        onChanged: (text) {
                          setState(() {
                            firstname = text;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Last Name',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: 16.0,
                            height: 1.4,
                            color: Colors.black,
                            fontFamily: 'Montserrat')),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                        maxLines: 1,
                        validator: (val) =>
                            val.isEmpty ? 'Enter your DOB' : null,
                        onChanged: (text) {
                          setState(() {
                            firstname = text;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Date of birth',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.datetime,
                        style: TextStyle(
                            fontSize: 16.0,
                            height: 1.4,
                            color: Colors.black,
                            fontFamily: 'Montserrat')),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                        maxLines: 1,
                        validator: (val) =>
                            val.isEmpty ? 'Enter your Summary' : null,
                        onChanged: (text) {
                          setState(() {
                            firstname = text;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Summary',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: 16.0,
                            height: 1.4,
                            color: Colors.black,
                            fontFamily: 'Montserrat')),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                        maxLines: 1,
                        validator: (val) =>
                            val.isEmpty ? 'Enter your Email' : null,
                        onChanged: (text) {
                          setState(() {
                            firstname = text;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Email',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                            fontSize: 16.0,
                            height: 1.4,
                            color: Colors.black,
                            fontFamily: 'Montserrat')),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                        maxLines: 1,
                        validator: (val) =>
                            val.isEmpty ? 'Enter your Username' : null,
                        onChanged: (text) {
                          setState(() {
                            firstname = text;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Username',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: 16.0,
                            height: 1.4,
                            color: Colors.black,
                            fontFamily: 'Montserrat')),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                        maxLines: 1,
                        validator: (val) =>
                            val.isEmpty ? 'Enter your Website' : null,
                        onChanged: (text) {
                          setState(() {
                            firstname = text;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Website',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.url,
                        style: TextStyle(
                            fontSize: 16.0,
                            height: 1.4,
                            color: Colors.black,
                            fontFamily: 'Montserrat')),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                        maxLines: 1,
                        maxLength: 10,
                        validator: (val) =>
                            val.isEmpty ? 'Enter your Phone Number' : null,
                        onChanged: (text) {
                          setState(() {
                            firstname = text;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            fontSize: 16.0,
                            height: 1.4,
                            color: Colors.black,
                            fontFamily: 'Montserrat')),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                        maxLines: 1,
                        validator: (val) =>
                            val.isEmpty ? 'Enter your Employment Title' : null,
                        onChanged: (text) {
                          setState(() {
                            firstname = text;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Employment Title',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: 16.0,
                            height: 1.4,
                            color: Colors.black,
                            fontFamily: 'Montserrat')),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                        maxLines: 1,
                        validator: (val) =>
                            val.isEmpty ? 'Enter your Skills/Languages' : null,
                        onChanged: (text) {
                          setState(() {
                            firstname = text;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Skills/Languages',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: 16.0,
                            height: 1.4,
                            color: Colors.black,
                            fontFamily: 'Montserrat')),
                    SizedBox(
                      height: 15.0,
                    ),
                    Center(
                      child: Text(
                        'Social Links',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                        maxLines: 1,
                        validator: (val) => val.isEmpty
                            ? 'Enter your YouTube Channel URL'
                            : null,
                        onChanged: (text) {
                          setState(() {
                            firstname = text;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'YouTube Channel URL',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.url,
                        style: TextStyle(
                            fontSize: 16.0,
                            height: 1.4,
                            color: Colors.black,
                            fontFamily: 'Montserrat')),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                        maxLines: 1,
                        validator: (val) => val.isEmpty
                            ? 'Enter your Stack Overflow profile URL'
                            : null,
                        onChanged: (text) {
                          setState(() {
                            firstname = text;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Stack Overflow profile URL',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.url,
                        style: TextStyle(
                            fontSize: 16.0,
                            height: 1.4,
                            color: Colors.black,
                            fontFamily: 'Montserrat')),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                        maxLines: 1,
                        validator: (val) => val.isEmpty
                            ? 'Enter your LinkedIn profile URL'
                            : null,
                        onChanged: (text) {
                          setState(() {
                            firstname = text;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'LinkedIn profile URL',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.url,
                        style: TextStyle(
                            fontSize: 16.0,
                            height: 1.4,
                            color: Colors.black,
                            fontFamily: 'Montserrat')),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                        maxLines: 1,
                        validator: (val) => val.isEmpty
                            ? 'Enter your Medium profile URL'
                            : null,
                        onChanged: (text) {
                          setState(() {
                            firstname = text;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Medium profile URL',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.url,
                        style: TextStyle(
                            fontSize: 16.0,
                            height: 1.4,
                            color: Colors.black,
                            fontFamily: 'Montserrat')),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                        maxLines: 1,
                        validator: (val) => val.isEmpty
                            ? 'Enter your GitHub profile URL'
                            : null,
                        onChanged: (text) {
                          setState(() {
                            firstname = text;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'GitHub profile URL',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.url,
                        style: TextStyle(
                            fontSize: 16.0,
                            height: 1.4,
                            color: Colors.black,
                            fontFamily: 'Montserrat')),
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }

  void _computeResult() async {
    if (_formKey.currentState.validate()) {
      Toast.show("Submitted Successfully!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }
  }


}
