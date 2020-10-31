import 'dart:collection';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:dev_portal/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final _formKey = GlobalKey<FormState>();
  String post_description;
  Auth auth = new Auth();
  File _image;
  final picker = ImagePicker();
  FirebaseStorage _storage = FirebaseStorage.instance;
  DatabaseReference myPostRef, userNameRef;
  String imagePath, firstName, lastName, fullName;
  bool imageFlag = false;
  static int post_no = 0;
  Future<void> getImage() async {
    final FirebaseUser user = await auth.getCurrentUser();
    final userId = user.uid;
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    //Create a reference to the location you want to upload to in firebase
    StorageReference reference =
        _storage.ref().child(userId).child("PostImages/" + post_no.toString());
    setState(() {
      _image = File(pickedFile.path);
    });
    //Upload the file to firebase
    StorageUploadTask uploadTask = reference.putFile(_image);

    //Snapshot of the uploading task
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    Toast.show("Post Media Uploaded Successfully!", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    imagePath = await taskSnapshot.ref.getDownloadURL();
    imageFlag = true;
  }

  @override
  void initState() {
    super.initState();
    getInitialData();
  }

  getInitialData() async {
    final FirebaseUser user = await auth.getCurrentUser();
    final userId = user.uid;
    StorageReference reference = _storage.ref().child(userId).child("Images/");
    DatabaseReference myRef =
        FirebaseDatabase.instance.reference().child('Profile').child(userId);
    myRef.once().then((DataSnapshot dataSnapshot) {
      setState(() {
        if (dataSnapshot.value != null) {
          firstName = dataSnapshot.value["firstname"];
          lastName = dataSnapshot.value["lastname"];
          fullName = firstName + lastName;
        } else {
          setState(() {
            // warning: fill your profile details before creating a post
            showCustomDialog(
                context, "Fill your profile details before creating a post!");
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ++post_no;
    return Center(
          child: Container(
            height: 500.0,
            width: 300.0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: (_image != null)
                              ? InkWell(
                                  onTap: getImage,
                                  child: Image.file(_image),
                                )
                              : InkWell(
                                  onTap: getImage,
                                  child: Image.asset('images/newimage.png'),
                                ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                            maxLines: 1,
                            validator: (val) => val.isEmpty
                                ? 'Enter a Description of your post'
                                : null,
                            onChanged: (text) {
                              setState(() {
                                post_description = text;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Description',
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
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: RaisedButton(
                            child: Text(
                              'POST',
                              style: GoogleFonts.ptSansNarrow(
                                  textStyle:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            onPressed: _submitPost,
                            textColor: Colors.white,
                            padding: EdgeInsets.fromLTRB(10, 18, 10, 18),
                            elevation: 5.0,
                            color: Colors.black,
                            splashColor: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
        ));
  }

  _submitPost() async {
    if (_formKey.currentState.validate()) {
      final FirebaseUser user = await auth.getCurrentUser();
      final userId = user.uid;
      myPostRef = FirebaseDatabase.instance.reference().child("Posts");
      dynamic currentTime = DateFormat.jm().format(DateTime.now());
      dynamic date = DateFormat('yyyy-MM-dd').format(DateTime.now());

      if (imageFlag) {
        HashMap<String, String> profileMap = new HashMap();
        profileMap.putIfAbsent('description', () => post_description);
        profileMap.putIfAbsent('postpath', () => imagePath);
        profileMap.putIfAbsent('name', () => fullName);
        profileMap.putIfAbsent('publisher', () => userId);
        profileMap.putIfAbsent('datetime', () => date + " " + currentTime);
        myPostRef.push().set(profileMap);

        Toast.show("Your Post is successful", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.of(context).pushNamed('/home');
      } else {
        Toast.show("Uploading Please Wait...", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }
  }

  showCustomDialog(BuildContext context, String text) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Icon(Icons.warning_sharp,),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  text,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.ptSansNarrow(
                      textStyle: TextStyle(fontSize: 17)),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: RaisedButton(
                  child: Text(
                    'Go to Profile',
                    style: GoogleFonts.ptSansNarrow(
                        textStyle: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, "/profile", ModalRoute.withName('/profile'));
                  },
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(10, 18, 10, 18),
                  elevation: 5.0,
                  color: Colors.black,
                  splashColor: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog, barrierDismissible: false);
  }
}
