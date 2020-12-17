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
  bool followingOn = false;

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

    myfollowingRef = FirebaseDatabase.instance
        .reference()
        .child('Follow')
        .child(userId)
        .child('following');

    if (following.contains(toFollowUserName)) {
      myPeopleRef = FirebaseDatabase.instance.reference().child('Profile');
      myPeopleRef.once().then((DataSnapshot dataSnapshot) {
        for (var snapshot in dataSnapshot.value.values) {
          if (snapshot["username"] == toFollowUserName) {
            var addFollowerUserId = dataSnapshot.value.keys.firstWhere(
                (k) => dataSnapshot.value[k] == snapshot,
                orElse: () => null);
            showUnfollowDialog(context, "Are you sure you want to unfollow?",
                toFollowUserName, addFollowerUserId);
          }
        }
      });
    } else {
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

      HashMap<String, String> toFollowMap = new HashMap();
      // add the followed user to the following list
      toFollowMap.putIfAbsent('userid', () => toFollowUserName);

      myfollowingRef.push().set(toFollowMap);

      f = retrievePeopleData();
    }
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
        if (dataSnapshot.value != null)
          currentUserName = dataSnapshot.value["username"];
        if (currentUserName == "") {
          showCustomDialog(context,
              "You cannot Follow/Unfollow anyone before creating your profile. Go ahead and create your stunning profile!");
        }
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

  unfollowPeople(String unfollowUserName, String addFollowUserId) async {
    final FirebaseUser user = await auth.getCurrentUser();
    final userId = user.uid;

    myfollowingRef = FirebaseDatabase.instance
        .reference()
        .child('Follow')
        .child(userId)
        .child('following');

    myfollowersRef = FirebaseDatabase.instance
        .reference()
        .child('Follow')
        .child(addFollowUserId)
        .child('followers');

    myfollowingRef.once().then((DataSnapshot dataSnapshot) {
      for (var snapshot in dataSnapshot.value.values) {
        if (snapshot["userid"] == unfollowUserName) {
          var userKey = dataSnapshot.value.keys.firstWhere(
              (k) => dataSnapshot.value[k] == snapshot,
              orElse: () => null);
          FirebaseDatabase.instance
              .reference()
              .child('Follow')
              .child(userId)
              .child('following')
              .child(userKey)
              .remove();
        }
      }
    });

    myfollowersRef.once().then((DataSnapshot dataSnapshot) {
      for (var snapshot in dataSnapshot.value.values) {
        if (snapshot["userid"] == currentUserName) {
          var userKey = dataSnapshot.value.keys.firstWhere(
              (k) => dataSnapshot.value[k] == snapshot,
              orElse: () => null);
          FirebaseDatabase.instance
              .reference()
              .child('Follow')
              .child(addFollowUserId)
              .child('followers')
              .child(userKey)
              .remove();
        }
      }
    });

    f = retrievePeopleData();
    Navigator.of(context).pop();
  }

  showUnfollowDialog(BuildContext context, String text, String unfollowUserName,
      String addFollowUserId) {
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
                child: Icon(
                  Icons.warning_sharp,
                  size: 80,
                ),
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
                    'Unfollow',
                    style: GoogleFonts.ptSansNarrow(
                        textStyle: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  onPressed: () {
                    // call unfollow function
                    unfollowPeople(unfollowUserName, addFollowUserId);
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
        context: context,
        builder: (BuildContext context) => errorDialog,
        barrierDismissible: false);
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
                child: Icon(
                  Icons.warning_sharp,
                  size: 80,
                ),
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
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/profile", ModalRoute.withName('/profile'));
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
        context: context,
        builder: (BuildContext context) => errorDialog,
        barrierDismissible: false);
  }
}
