import 'dart:collection';

import 'package:dev_portal/models/people.dart';
import 'package:dev_portal/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FindPeople extends StatefulWidget {
  @override
  _FindPeopleState createState() => _FindPeopleState();
}

class _FindPeopleState extends State<FindPeople> {
  Auth auth = new Auth();
  DatabaseReference myPeopleRef, myfollowingRef, myfollowersRef, myProfileRef;
  List<String> following = [], followers = [];
  Future f;
  String currentUserName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    f = retrievePeopleData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Find People',
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
            FutureBuilder(
              future: f,
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  if (snapshot.data.length != 0) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.all(8.0),
                          child: ListTile(
                            subtitle:
                                Text(snapshot.data[index].employmentTitle),
                            title: Text(
                              snapshot.data[index].firstName +
                                  " " +
                                  snapshot.data[index].lastName,
                              style: GoogleFonts.ptSansNarrow(),
                            ),
                            leading: CircleAvatar(
                                backgroundColor: Theme.of(context).platform ==
                                        TargetPlatform.iOS
                                    ? Colors.black
                                    : Colors.white,
                                child: Image.network(
                                    snapshot.data[index].imagePath)

                                // Later to be changed as profile image
                                ),
                            trailing: Container(
                              height: 50,
                              child: RaisedButton(
                                  child: following.contains(
                                          snapshot.data[index].userName)
                                      ? Text(
                                          'Following',
                                          style: GoogleFonts.ptSansNarrow(
                                              textStyle:
                                                  TextStyle(fontSize: 14)),
                                        )
                                      : Text(
                                          'Follow',
                                          style: GoogleFonts.ptSansNarrow(
                                              textStyle:
                                                  TextStyle(fontSize: 14)),
                                        ),
                                  onPressed: () => followPeople(
                                      snapshot.data[index].userName),
                                  color: Colors.black,
                                  splashColor: Colors.black54,
                                  textColor: Colors.white,
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0))),
                            ),
                          ),
                        );
                      },
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    );
                  }
                  return Container(
                    child: Image.asset('images/data_not_found.png'),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Container();
              },
            )
          ],
        ));
  }

  followPeople(String toFollowUserName) async {
    final FirebaseUser user = await auth.getCurrentUser();
    final userId = user.uid;

    myPeopleRef = FirebaseDatabase.instance.reference().child('Profile');
    myPeopleRef.once().then((DataSnapshot dataSnapshot) {
      for (var snapshot in dataSnapshot.value.values) {
        if (snapshot["username"] == toFollowUserName) {
          var addFollowerUserId = dataSnapshot.value.keys.firstWhere(
              (k) => dataSnapshot.value[k] == snapshot,
              orElse: () => null);
          myfollowersRef = FirebaseDatabase.instance
              .reference()
              .child('Follow')
              .child(addFollowerUserId)
              .child('followers');

          HashMap<String, String> addFollowersMap = new HashMap();
          // add the current user as follower to the followed user.
          addFollowersMap.putIfAbsent('userid', () => currentUserName);

          myfollowersRef.push().set(addFollowersMap);
        }
      }
    });

    myfollowingRef = FirebaseDatabase.instance
        .reference()
        .child('Follow')
        .child(userId)
        .child('following');

    HashMap<String, String> toFollowMap = new HashMap();
    // add the followed user to the following list
    toFollowMap.putIfAbsent('userid', () => toFollowUserName);

    myfollowingRef.push().set(toFollowMap);

    f = retrievePeopleData();
  }

  Future<List<People>> retrievePeopleData() async {
    final FirebaseUser user = await auth.getCurrentUser();
    final userId = user.uid;
    List<People> people = [];

    // get the current user's username
    myProfileRef =
        FirebaseDatabase.instance.reference().child('Profile').child(userId);
    myProfileRef.once().then((DataSnapshot dataSnapshot) {
      setState(() {
        currentUserName = dataSnapshot.value["username"];
      });
    });

    myPeopleRef = FirebaseDatabase.instance.reference().child('Profile');
    myfollowingRef = FirebaseDatabase.instance
        .reference()
        .child('Follow')
        .child(userId)
        .child('following');

    myfollowingRef.once().then((DataSnapshot dataSnapshot) {
      setState(() {
        if (dataSnapshot.value != null) {
          for (var snapshot in dataSnapshot.value.values) {
            following.add(snapshot['userid']);
          }
        }
      });
    });

    myPeopleRef.once().then((DataSnapshot dataSnapshot) {
      setState(() {
        if (dataSnapshot.value != null) {
          for (var snapshot in dataSnapshot.value.values) {
            if (snapshot["username"] != currentUserName) {
              People person = People(
                  snapshot["imagepath"],
                  snapshot["firstname"],
                  snapshot["lastname"],
                  snapshot["employmenttitle"],
                  snapshot["username"]);

              people.add(person);
            }
          }
        }
        return people;
      });
    });
    return people;
  }
}
