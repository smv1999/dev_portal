import 'package:dev_portal/models/people.dart';
import 'package:dev_portal/services/query_people.dart';
import 'package:flutter/material.dart';

class FindPeople extends StatefulWidget {
  @override
  _FindPeopleState createState() => _FindPeopleState();
}

class _FindPeopleState extends State<FindPeople> {
  List<People> _people = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
          _setUpPeople();
      });
    });
  }

  void _setUpPeople() async {
    _people = await DatabaseService.getPeople();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView.builder(
                shrinkWrap: true,
                key: UniqueKey(),
                itemCount: _people.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Text(
                        _people[index].employmenttitle,
                        key: UniqueKey(),
                      )
                    ],
                  );
                })));
  }
}
