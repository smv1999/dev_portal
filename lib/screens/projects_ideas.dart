import 'dart:collection';

import 'package:dev_portal/models/projects.dart';
import 'package:dev_portal/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  SharedPreferences prefs;
  bool _seen;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkTipSeen());
    f = retrieveProjectData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/tools', (_) => false);
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: SizedBox.expand(
            child: FittedBox(fit: BoxFit.contain, child: Icon(Icons.add)),
          ),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          onPressed: () {
            // Respond to button press
            // show dialog
            showCustomDialog(context);
          },
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          title: Text(
            'Dev Portal',
            style: TextStyle(
                color: Colors.white,
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
                    fontSize: 20.0,
                    color: Colors.black,
                    fontFamily: 'MyFont',
                    fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder(
              future: f,
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  if (snapshot.data.length != 0) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          child: Card(
                            margin: const EdgeInsets.all(8.0),
                            child: ListTile(
                              subtitle:
                                  Text(snapshot.data[index].projectDescription),
                              title: Text(
                                snapshot.data[index].projectTitle,
                                style: GoogleFonts.ptSansNarrow(),
                              ),
                            ),
                          ),
                          onDismissed: (direction) {
                            // Remove the item from the data source.
                            setState(() {
                              String delTitle =
                                  snapshot.data[index].projectTitle;
                              String delDescription =
                                  snapshot.data[index].projectDescription;
                              snapshot.data.removeAt(index);
                              deleteProjectData(
                                  delTitle, context, delDescription);
                            });
                          },
                          // Show a red background as the item is swiped away.
                          background: Container(
                            padding: EdgeInsets.all(20.0),
                            alignment: Alignment.centerRight,
                            color: Colors.grey,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        );
                      },
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    );
                  }
                  return Container(
                    child: Image.network(
                        'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/data_not_found.png'),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }

  showCustomDialog(BuildContext context) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
          height: 310.0,
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
                      'New Project Idea 💡',
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
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(32.0),
                          ),
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
                    color: Colors.blue,
                    splashColor: Colors.blueAccent,
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

  Future checkTipSeen() async {
    prefs = await SharedPreferences.getInstance();
    _seen = (prefs.getBool('projectsheetseen') ?? false);
    if (!_seen) {
      showBottomSheetDialog();
      await prefs.setBool('projectsheetseen', true);
    }
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 250,
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Image.network(
                      'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/getting_started.png',
                      height: 80,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'Getting Started',
                      style: GoogleFonts.ptSansNarrow(
                          textStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'You can view the list of project ideas created here and delete them by swiping left on each item of the list.',
                      style: GoogleFonts.ptSansNarrow(
                          textStyle: TextStyle(
                        fontSize: 18,
                      )),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                ),
              ),
            ),
          );
        });
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
        if (dataSnapshot.value != null) {
          for (var snapshot in dataSnapshot.value.values) {
            Projects project =
                Projects(snapshot["title"], snapshot["description"]);

            projects.add(project);
          }
        }
        return projects;
      });
    });
    return projects;
  }

  deleteProjectData(
      var delTitle, BuildContext context, var delDescription) async {
    final FirebaseUser user = await auth.getCurrentUser();
    final userId = user.uid;
    FirebaseDatabase.instance
        .reference()
        .child('Projects')
        .child(userId)
        .once()
        .then((DataSnapshot dataSnapshot) {
      for (var snapshot in dataSnapshot.value.values) {
        if (snapshot["title"] == delTitle) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(snapshot["title"] + " deleted"),
            action: SnackBarAction(
                label: "UNDO",
                onPressed: () => setState(
                      () => {undoDeleteProject(delTitle, delDescription)},
                    ) // this is what you needed
                ),
          ));
          var projectKey = dataSnapshot.value.keys.firstWhere(
              (k) => dataSnapshot.value[k] == snapshot,
              orElse: () => null);
          FirebaseDatabase.instance
              .reference()
              .child('Projects')
              .child(userId)
              .child(projectKey)
              .remove();
        }
      }
    });
  }

  undoDeleteProject(var delTitle, var delDescription) async {
    projectTitle = delTitle;
    projectDescription = delDescription;
    FirebaseUser user = await auth.getCurrentUser();
    final userId = user.uid;
    myProjRef =
        FirebaseDatabase.instance.reference().child('Projects').child(userId);

    HashMap<String, String> projectMap = new HashMap();
    projectMap.putIfAbsent('title', () => projectTitle);
    projectMap.putIfAbsent('description', () => projectDescription);

    myProjRef.push().set(projectMap);

    Toast.show("Undo Successful!", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    f = retrieveProjectData();
  }
}
