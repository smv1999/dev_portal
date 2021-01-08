import 'dart:collection';
import 'dart:io';
import 'package:dev_portal/services/ProgressBar.dart';
import 'package:dev_portal/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

class EditUserProfile extends StatefulWidget {
  @override
  _EditUserProfileState createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  final _formKey = GlobalKey<FormState>();
  String firstName,
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
  Auth auth = new Auth();
  File _image;
  final picker = ImagePicker();
  FirebaseStorage _storage = FirebaseStorage.instance;
  DatabaseReference myRef, userNameRef;
  String imagePath, profileImage = "";
  bool imageFlag = false;
  ProgressBar _sendingMsgProgressBar;
  final TextEditingController dateController = TextEditingController(text: '');
  final TextEditingController firstNameController = TextEditingController(text: '');
  final TextEditingController lastNameController = TextEditingController(text: '');
  final TextEditingController phoneNumberController = TextEditingController(text: '');
  final TextEditingController summaryController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController usernameController = TextEditingController(text: '');
  final TextEditingController websiteController = TextEditingController(text: '');
  final TextEditingController employeeTitleController = TextEditingController(text: '');
  final TextEditingController stackoverflowController = TextEditingController(text: '');
  final TextEditingController youtubeController = TextEditingController(text: '');
  final TextEditingController skillsController = TextEditingController(text: '');
  final TextEditingController linkedinController = TextEditingController(text: '');
  final TextEditingController mediumController = TextEditingController(text: '');
  final TextEditingController githubController = TextEditingController(text: '');
  

  Future<void> getImage() async {
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
    imagePath = await taskSnapshot.ref.getDownloadURL();
    imageFlag = true;
  }

  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  void initState() {
    // TODO: implement initState
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
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Edit Profile',
          style: TextStyle(
              fontFamily: 'MyFont',
              color: Colors.white,
              fontWeight: FontWeight.bold),
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
        actionsIconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      (_image != null || profileImage != "")
                          ? InkWell(
                              onTap: getImage,
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 60.0,
                                child: CircleAvatar(
                                  radius: 58.0,
                                  backgroundImage: profileImage == "" ? new FileImage(_image) : new NetworkImage(profileImage),
                                  backgroundColor: Colors.white,
                                ),
                              ))
                          : InkWell(
                              onTap: getImage,
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 50.0,
                                child: CircleAvatar(
                                  radius: 48.0,
                                  backgroundImage: NetworkImage(
                                      'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/newimage.png'),
                                  backgroundColor: Colors.white,
                                ),
                              )),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextFormField(
                          controller: firstNameController,
                          maxLines: 1,
                          validator: (val) =>
                              val.isEmpty ? 'Enter your First Name' : null,
                          onChanged: (text) {
                            setState(() {
                              firstName = text;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: firstNameController.text != "" ? 'First Name' : firstNameController.text,
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
                        controller: lastNameController,
                          maxLines: 1,
                          validator: (val) =>
                              val.isEmpty ? 'Enter your Last Name' : null,
                          onChanged: (text) {
                            setState(() {
                              lastName = text;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: lastNameController.text != "" ? 'Last Name' : lastNameController.text ,
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
                          controller: dateController,
                          maxLines: 1,
                          maxLength: 10,
                          validator: (val) =>
                              val.isEmpty ? 'Enter your DOB' : null,
                          onTap: () => {
                                selectDate(context),
                                dateController.text =
                                    "${selectedDate.toLocal()}".split(' ')[0],
                                dob = "${selectedDate.toLocal()}".split(' ')[0]
                              },
                          onChanged: (text) {
                            setState(() {
                              dob = "${selectedDate.toLocal()}".split(' ')[0];
                            });
                          },
                          decoration: InputDecoration(
                            hintText: dateController.text != "" ? 'Enter Date of birth' : dateController.text,
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
                        controller: summaryController,
                          maxLines: 1,
                          validator: (val) =>
                              val.isEmpty ? 'Enter your Summary' : null,
                          onChanged: (text) {
                            setState(() {
                              summary = text;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: summaryController.text != "" ? 'Summary' : summaryController.text,
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
                        controller: emailController,
                          maxLines: 1,
                          validator: (val) =>
                              val.isEmpty ? 'Enter your Email' : null,
                          onChanged: (text) {
                            setState(() {
                              email = text;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: emailController.text != "" ? 'Email' : emailController.text,
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
                        controller: usernameController,
                          maxLines: 1,
                          validator: (val) =>
                              val.isEmpty ? 'Enter your Username' : null,
                          onChanged: (text) {
                            setState(() {
                              username = text;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: usernameController.text != "" ? 'Username' : usernameController.text,
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
                        controller: websiteController,
                          maxLines: 1,
                          validator: (val) =>
                              val.isEmpty ? 'Enter your Website' : null,
                          onChanged: (text) {
                            setState(() {
                              website = text;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: websiteController.text != "" ? 'Website' : websiteController.text,
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
                        controller: phoneNumberController,
                          maxLines: 1,
                          maxLength: 10,
                          validator: (val) =>
                              val.isEmpty ? 'Enter your Phone Number' : null,
                          onChanged: (text) {
                            setState(() {
                              phoneNumber = text;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: phoneNumberController.text != "" ? 'Phone Number' : phoneNumberController.text,
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
                        controller: employeeTitleController,
                          maxLines: 1,
                          validator: (val) => val.isEmpty
                              ? 'Enter your Employment Title'
                              : null,
                          onChanged: (text) {
                            setState(() {
                              employmentTitle = text;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: employeeTitleController.text != "" ? 'Employment Title' : employeeTitleController.text,
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
                        controller: skillsController,
                          maxLines: 1,
                          validator: (val) => val.isEmpty
                              ? 'Enter your Skills/Languages'
                              : null,
                          onChanged: (text) {
                            setState(() {
                              skills = text;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: skillsController.text != "" ? 'Skills/Languages' : skillsController.text,
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'MyFont',
                              fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: youtubeController,
                          maxLines: 1,
                          onChanged: (text) {
                            setState(() {
                              youtube = text;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: youtubeController.text != "" ? 'YouTube Channel URL' : youtubeController.text,
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
                        controller: stackoverflowController,
                          maxLines: 1,
                          onChanged: (text) {
                            setState(() {
                              stackoverflow = text;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: stackoverflowController.text != "" ? 'Stack Overflow profile URL' : stackoverflowController.text,
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
                        controller: linkedinController,
                          maxLines: 1,
                          onChanged: (text) {
                            setState(() {
                              linkedin = text;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: linkedinController.text != "" ? 'LinkedIn profile URL' : linkedinController.text,
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
                        controller: mediumController,
                          maxLines: 1,
                          onChanged: (text) {
                            setState(() {
                              medium = text;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: mediumController.text != "" ? 'Medium profile URL' : mediumController.text,
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
                        controller: githubController,
                          maxLines: 1,
                          onChanged: (text) {
                            setState(() {
                              github = text;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: githubController.text != "" ? 'GitHub profile URL' : githubController.text,
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
                )),
              ),
            )),
      ),
    );
  }

  Future<void> _setData() async {
    // retrieve from Firebase DB and display
    final FirebaseUser user = await auth.getCurrentUser();
    final userId = user.uid;
    myRef =
        FirebaseDatabase.instance.reference().child('Profile').child(userId);
    myRef.once().then((DataSnapshot dataSnapshot) {
      setState(() {
        if (dataSnapshot.value != null) {
          firstName = dataSnapshot.value["firstname"];
          firstNameController.text = firstName;
          lastName = dataSnapshot.value["lastname"];
          lastNameController.text = lastName;
          dob = dataSnapshot.value["dob"];
          dateController.text = dob;
          summary = dataSnapshot.value["summary"];
          summaryController.text = summary;
          email = dataSnapshot.value["email"];
          emailController.text = email;
          username = dataSnapshot.value["username"];
          usernameController.text = username;
          website = dataSnapshot.value["website"];
          websiteController.text = website;
          phoneNumber = dataSnapshot.value["phonenumber"];
          phoneNumberController.text = phoneNumber;
          employmentTitle = dataSnapshot.value["employmenttitle"];
          employeeTitleController.text = employmentTitle;
          skills = dataSnapshot.value["skills"];
          skillsController.text = skills;
          youtube = dataSnapshot.value["youtube"];
          youtubeController.text = youtube;
          stackoverflow = dataSnapshot.value["stackoverflow"];
          stackoverflowController.text = stackoverflow;
          linkedin = dataSnapshot.value["linkedin"];
          linkedinController.text = linkedin;
          medium = dataSnapshot.value["medium"];
          mediumController.text = medium;
          github = dataSnapshot.value["github"];
          githubController.text = github;
          profileImage = dataSnapshot.value["imagepath"];
          hideSendingProgressBar();
        } else {
          setState(() {
            hideSendingProgressBar();
          });
        }
      });
    });
  }

  void _computeResult() async {
    if (_formKey.currentState.validate()) {
      final FirebaseUser user = await auth.getCurrentUser();
      final userId = user.uid;
      myRef =
          FirebaseDatabase.instance.reference().child('Profile').child(userId);
      userNameRef = FirebaseDatabase.instance
          .reference()
          .child('Usernames')
          .child(userId);

      if (imageFlag) {
        HashMap<String, String> profileMap = new HashMap();
        profileMap.putIfAbsent('firstname', () => firstName);
        profileMap.putIfAbsent('lastname', () => lastName);
        profileMap.putIfAbsent('dob', () => dob);
        profileMap.putIfAbsent('summary', () => summary);
        profileMap.putIfAbsent('email', () => email);
        profileMap.putIfAbsent('username', () => username);
        profileMap.putIfAbsent('website', () => website);
        profileMap.putIfAbsent('phonenumber', () => phoneNumber);
        profileMap.putIfAbsent('employmenttitle', () => employmentTitle);
        profileMap.putIfAbsent('skills', () => skills);
        profileMap.putIfAbsent('imagepath', () => imagePath);
        profileMap.putIfAbsent('youtube', () => youtube);
        profileMap.putIfAbsent('stackoverflow', () => stackoverflow);
        profileMap.putIfAbsent('linkedin', () => linkedin);
        profileMap.putIfAbsent('medium', () => medium);
        profileMap.putIfAbsent('github', () => github);
        myRef.set(profileMap);

        HashMap<String, String> userMap = new HashMap();
        userMap.putIfAbsent('username', () => username);
        userNameRef.set(userMap);

        Toast.show("Submitted Successfully!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.of(context).pushReplacementNamed('/profile'); // change this
      } else {
        Toast.show("Please select your profile image", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }
  }
}
