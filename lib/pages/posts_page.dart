import 'dart:io';
import 'package:dev_portal/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {

  final _formKey = GlobalKey<FormState>();
  String post_description;
  Auth auth = new Auth();
  File _image;
  final picker = ImagePicker();
  FirebaseStorage _storage = FirebaseStorage.instance;
  DatabaseReference myRef, userNameRef;
  String imagePath;
  bool imageFlag = false;


  @override
  Widget build(BuildContext context) {
    return Container(
      // retrieve all followings' posts
    );
  }


}
