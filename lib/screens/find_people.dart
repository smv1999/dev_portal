import 'dart:collection';
import 'package:dev_portal/models/people.dart';
import 'package:dev_portal/screens/view_profile.dart';
import 'package:dev_portal/services/ProgressBar.dart';
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
  ProgressBar progressBar;
  Icon searchIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final TextEditingController _searchQuery = new TextEditingController();
  List<String> dictionaryList = [];
  bool _isSearching;
  String _searchText = "";
  Widget appBarTitle = new Text(
    'Find People',
    style: TextStyle(
        color: Colors.white,
        fontFamily: 'MyFont',
        fontWeight: FontWeight.bold),
  );


  _FindPeopleState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isSearching = false;
    progressBar = ProgressBar();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add Your Code here.
      showSendingProgressBar();
    });
    f = retrievePeopleData();
  }

  @override
  void dispose() {
    progressBar.hide();
    super.dispose();
  }

  void showSendingProgressBar() {
    progressBar.show(context);
  }

  void hideSendingProgressBar() {
    progressBar.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          title: appBarTitle,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          actions: [
            new IconButton(
              icon: searchIcon,
              onPressed: () {
                setState(() {
                  if (this.searchIcon.icon == Icons.search) {
                    this.searchIcon =
                    new Icon(Icons.close, color: Colors.white);
                    this.appBarTitle = new TextField(
                      controller: _searchQuery,
                      style: new TextStyle(
                        color: Colors.white,
                      ),
                      decoration: new InputDecoration(
                          prefixIcon:
                          new Icon(Icons.search, color: Colors.white),
                          hintText: "Search...",
                          hintStyle: new TextStyle(color: Colors.white)),
                    );
                  } else {
                    this._searchQuery.clear();
                    this.searchIcon =
                    new Icon(Icons.search, color: Colors.white);
                    this.appBarTitle = new Text(
                      'Find People',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'MyFont',
                          fontWeight: FontWeight.bold),
                    );
                  }
                });
              },
            )
          ],
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
                    return _isSearching ? ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return snapshot.data[index].userName.toLowerCase().contains(_searchText) || (snapshot.data[index].firstName + " " + snapshot.data[index].lastName).toLowerCase().contains(_searchText) ? Card(
                            margin: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewProfile(
                                        text: snapshot.data[index].userName,
                                      ),
                                    ));
                              },
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
                                    backgroundColor:
                                    Theme.of(context).platform ==
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
                                      color: Colors.blue,
                                      splashColor: Colors.blueAccent,
                                      textColor: Colors.white,
                                      elevation: 5.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          new BorderRadius.circular(10.0))),
                                ),
                              ),
                            )) : new Container();
                      },
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ) : ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                            margin: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewProfile(
                                        text: snapshot.data[index].userName,
                                      ),
                                    ));
                              },
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
                                    backgroundColor:
                                        Theme.of(context).platform ==
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
                                      color: Colors.blue,
                                      splashColor: Colors.blueAccent,
                                      textColor: Colors.white,
                                      elevation: 5.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(10.0))),
                                ),
                              ),
                            ));
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
    hideSendingProgressBar();
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
        height: 250.0,
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
                  color: Colors.blue,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
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
                  color: Colors.blue,
                  splashColor: Colors.blueAccent,
                ),
              )
            ],
          ),
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
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
                  color: Colors.blue,
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
                  color: Colors.blue,
                  splashColor: Colors.blueAccent,
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
