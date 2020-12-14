import 'package:dev_portal/models/people.dart';
import 'package:dev_portal/services/query_people.dart';
import 'package:flutter/material.dart';

class FindPeople extends StatefulWidget {
  @override
  _FindPeopleState createState() => _FindPeopleState();
}

class _FindPeopleState extends State<FindPeople> {
  List<People> _people = [];

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
        refreshList();
    });
  }

  Future<void> refreshList() async {
    refreshKey.currentState?.show();
    await Future.delayed(Duration(seconds: 2));
    List<People> temp = await DatabaseService.getPeople();
    setState(() {
      _people = temp;
    });
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
        body: RefreshIndicator(
          key: refreshKey,
            onRefresh: refreshList,
            child: ListView.builder(
              key: UniqueKey(),
                shrinkWrap: true,
                itemCount: _people?.length,
                itemBuilder: (BuildContext context, int index) => ListTile(
                    title: Text(
                        _people[index].firstname + _people[index].lastname)))));
  }
}
