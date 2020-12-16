import 'dart:collection';
import 'package:intl/intl.dart';
import 'package:dev_portal/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final _formKey = GlobalKey<FormState>();
  Auth auth = new Auth();
  String taskTitle, taskDescription, taskDeadline, dateCreated;
  final TextEditingController controller = TextEditingController(text: '');
  DatabaseReference myTaskRef;

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Task',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'MyFont',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap:
                    // Submit Profile Details
                    () => _saveTaskData(context),
                child: Icon(Icons.check_circle),
              )),
        ],
        actionsIconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 30,
              ),
              TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter a title' : null,
                  onChanged: (text) {
                    setState(() {
                      taskTitle = text;
                    });
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      hintText: 'Task Title',
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
                      taskDescription = text;
                    });
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      hintText: 'What is to be done?',
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
                  controller: controller,
                  maxLines: 1,
                  maxLength: 10,
                  validator: (val) =>
                      val.isEmpty ? 'Enter your Deadline' : null,
                  onTap: () => {
                        selectDate(context),
                        controller.text =
                            "${selectedDate.toLocal()}".split(' ')[0],
                        taskDeadline = "${selectedDate.toLocal()}".split(' ')[0]
                      },
                  onChanged: (text) {
                    setState(() {
                      taskDeadline = "${selectedDate.toLocal()}".split(' ')[0];
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Due Date',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.datetime,
                  style: TextStyle(
                      fontSize: 16.0,
                      height: 1.2,
                      color: Colors.black,
                      fontFamily: 'MyFont')),
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveTaskData(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      final FirebaseUser user = await auth.getCurrentUser();
      final userId = user.uid;
      myTaskRef =
          FirebaseDatabase.instance.reference().child('Tasks').child(userId);

      dynamic currentTime = DateFormat.jm().format(DateTime.now());
      dynamic date = DateFormat('yyyy-MM-dd').format(DateTime.now());

      dateCreated = date + currentTime;

      HashMap<String, String> taskMap = new HashMap();
      taskMap.putIfAbsent('title', () => taskTitle);
      taskMap.putIfAbsent('description', () => taskDescription);
      taskMap.putIfAbsent('deadline', () => taskDeadline);
      taskMap.putIfAbsent('created', () => dateCreated);

      print(taskDeadline);

      myTaskRef.push().set(taskMap);

      Toast.show("Task Saved Successfully!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      Navigator.of(context).pushReplacementNamed('/todolist');
    }
  }
}
