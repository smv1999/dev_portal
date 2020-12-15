import 'dart:collection';

import 'package:dev_portal/models/projects.dart';
import 'package:dev_portal/services/ProgressBar.dart';
import 'package:dev_portal/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

class ProjectIdeas extends StatefulWidget {
  @override
  _ProjectIdeasState createState() => _ProjectIdeasState();
}

class _ProjectIdeasState extends State<ProjectIdeas> {
  String projectTitle, projectDescription;
  final _formKey = GlobalKey<FormState>();
  DatabaseReference myProjRef;
  Auth auth = new Auth();
  Future f;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    f = retrieveProjectData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: SizedBox.expand(
          child: FittedBox(fit: BoxFit.contain, child: Icon(Icons.add)),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: () {
          // Respond to button press
          // show dialog
          showCustomDialog(context);
        },
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Dev Portal',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'MyFont',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Text(
              'Scribblet - Save your project ideas!',
              style: TextStyle(
                  fontSize: 25.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                  fontFamily: 'MyFont',
                  fontWeight: FontWeight.bold),
            ),
          ),
          FutureBuilder(
            future: f,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      subtitle: Text(snapshot.data[index].projectDescription),
                      title: Text(
                        snapshot.data[index].projectTitle,
                        style: GoogleFonts.ptSansNarrow(),
                      ),
                    );
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )
        ],
      ),
    );
  }

  showCustomDialog(BuildContext context) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
          height: 400.0,
          width: 400.0,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Center(
                    child: Text(
                      'New Project Idea',
                      style: GoogleFonts.ptSansNarrow(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      validator: (val) => val.isEmpty ? 'Enter a title' : null,
                      onChanged: (text) {
                        setState(() {
                          projectTitle = text;
                        });
                      },
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(32.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(32.0)),
                          hintText: 'Project Title',
                          hintStyle: GoogleFonts.ptSansNarrow()),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          fontSize: 16.0,
                          height: 1.2,
                          color: Colors.black,
                          fontFamily: 'MyFont')),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'Enter a description' : null,
                      onChanged: (text) {
                        setState(() {
                          projectDescription = text;
                        });
                      },
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(32.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(32.0)),
                          hintText: 'Project Description',
                          hintStyle: GoogleFonts.ptSansNarrow()),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          fontSize: 16.0,
                          height: 1.2,
                          color: Colors.black,
                          fontFamily: 'MyFont')),
                  SizedBox(
                    height: 30.0,
                  ),
                  RaisedButton(
                    child: Text(
                      'SAVE',
                      style: GoogleFonts.ptSansNarrow(
                          textStyle: TextStyle(fontSize: 15)),
                    ),
                    onPressed: () => _saveProjectData(context),
                    color: Colors.black,
                    splashColor: Colors.black54,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(10, 18, 10, 18),
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                  )
                ],
              ),
            ),
          )),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }

  void _saveProjectData(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      final FirebaseUser user = await auth.getCurrentUser();
      final userId = user.uid;
      myProjRef =
          FirebaseDatabase.instance.reference().child('Projects').child(userId);

      HashMap<String, String> projectMap = new HashMap();
      projectMap.putIfAbsent('title', () => projectTitle);
      projectMap.putIfAbsent('description', () => projectDescription);

      myProjRef.push().set(projectMap);

      Toast.show("Project Saved Successfully!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      f = retrieveProjectData();
      Navigator.of(context).pop();
    }
  }

  Future<List<Projects>> retrieveProjectData() async {
    final FirebaseUser user = await auth.getCurrentUser();
    final userId = user.uid;
    List<Projects> projects = [];

    myProjRef =
        FirebaseDatabase.instance.reference().child('Projects').child(userId);
      myProjRef.once().then((DataSnapshot dataSnapshot) {
        setState(() {
          for (var snapshot in dataSnapshot.value.values) {
             Projects project =
              Projects(snapshot["title"], snapshot["description"]);

          projects.add(project);
        }
                return projects;

        });
        
      });    
      return projects;
  }
}
