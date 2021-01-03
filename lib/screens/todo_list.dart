import 'dart:collection';
import 'package:dev_portal/models/tasks.dart';
import 'package:dev_portal/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  String taskTitle, taskDescription, taskDeadline, dateCreated;
  final _formKey = GlobalKey<FormState>();
  DatabaseReference mytaskRef;
  Auth auth = new Auth();
  Future f;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferences prefs;
  bool _seen;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkTipSeen());
    f = retrieveTaskData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacementNamed('/dashboard');
      },
    child:Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        child: SizedBox.expand(
          child: FittedBox(fit: BoxFit.contain, child: Icon(Icons.add)),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          // Respond to button press

          // open a new screen to add new task
          Navigator.of(context).pushNamed('/newtask');
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: Text(
          'To Do List',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'MyFont',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white60,
      child:ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 20.0,
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
                            subtitle: Text(
                                snapshot.data[index].taskDescription +
                                    "\n" +
                                    snapshot.data[index].dateCreated +
                                    "\n" +
                                    snapshot.data[index].taskDeadline),
                            title: Text(
                              snapshot.data[index].taskTitle,
                              style: GoogleFonts.ptSansNarrow(),
                            ),
                          ),
                        ),
                        onDismissed: (direction) {
                          // Remove the item from the data source.
                          setState(() {
                            String delTitle = snapshot.data[index].taskTitle;
                            String delDescription =
                                snapshot.data[index].taskDescription;
                            String delDeadline =
                                snapshot.data[index].taskDeadline;
                            String delCreated =
                                snapshot.data[index].dateCreated;
                            snapshot.data.removeAt(index);
                            deleteTaskData(delTitle, context, delDescription,
                                delDeadline, delCreated);
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
                  child: Image.network('https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/data_not_found.png'),
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
    ),
    );
  }

  Future checkTipSeen() async {
    prefs = await SharedPreferences.getInstance();
    _seen = (prefs.getBool('todosheetseen') ?? false);
    if (!_seen) {
      showBottomSheetDialog();
      await prefs.setBool('todosheetseen', true);
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
                      'You can view the list of to-dos created here and delete them by swiping left on each item of the list.',
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

  Future<List<Tasks>> retrieveTaskData() async {
    final FirebaseUser user = await auth.getCurrentUser();
    final userId = user.uid;
    List<Tasks> tasks = [];

    mytaskRef =
        FirebaseDatabase.instance.reference().child('Tasks').child(userId);
    mytaskRef.once().then((DataSnapshot dataSnapshot) {
      setState(() {
        if (dataSnapshot.value != null) {
          for (var snapshot in dataSnapshot.value.values) {
            Tasks task = Tasks(snapshot["title"], snapshot["description"],
                snapshot["deadline"], snapshot["created"]);

            tasks.add(task);
          }
        }
        return tasks;
      });
    });
    return tasks;
  }

  deleteTaskData(var delTitle, BuildContext context, var delDescription,
      var delDeadline, var delCreated) async {
    final FirebaseUser user = await auth.getCurrentUser();
    final userId = user.uid;
    FirebaseDatabase.instance
        .reference()
        .child('Tasks')
        .child(userId)
        .once()
        .then((DataSnapshot dataSnapshot) {
      for (var snapshot in dataSnapshot.value.values) {
        if (snapshot["title"] == delTitle) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(snapshot["title"] + " deleted"),
            action: SnackBarAction(
                label: "UNDO",
                onPressed: () => setState(
                      () => {
                        undoDeleteTask(
                            delTitle, delDescription, delDeadline, delCreated)
                      },
                    ) // this is what you needed
                ),
          ));
          var taskKey = dataSnapshot.value.keys.firstWhere(
              (k) => dataSnapshot.value[k] == snapshot,
              orElse: () => null);
          FirebaseDatabase.instance
              .reference()
              .child('Tasks')
              .child(userId)
              .child(taskKey)
              .remove();
        }
      }
    });
  }

  undoDeleteTask(
      var delTitle, var delDescription, var delDeadline, var delCreated) async {
    taskTitle = delTitle;
    taskDescription = delDescription;
    taskDeadline = delDeadline;
    dateCreated = delCreated;
    FirebaseUser user = await auth.getCurrentUser();
    final userId = user.uid;
    mytaskRef =
        FirebaseDatabase.instance.reference().child('Tasks').child(userId);

    HashMap<String, String> taskMap = new HashMap();
    taskMap.putIfAbsent('title', () => taskTitle);
    taskMap.putIfAbsent('description', () => taskDescription);
    taskMap.putIfAbsent('deadline', () => taskDeadline);
    taskMap.putIfAbsent('created', () => dateCreated);

    mytaskRef.push().set(taskMap);

    Toast.show("Undo Successful!", context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    f = retrieveTaskData();
  }
}
