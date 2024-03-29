import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:dev_portal/home_page_content.dart';
import 'package:dev_portal/pages/books_page.dart';
import 'package:dev_portal/pages/coding_tips.dart';
import 'package:dev_portal/pages/new_post.dart';
import 'package:dev_portal/pages/posts_page.dart';
import 'package:dev_portal/screens/profile_image.dart';
import 'package:dev_portal/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  Auth auth = new Auth();
  DatabaseReference myRef;
  String fullName = "Developer",
      email = "developer@gmail.com",
      profileImageUrl =
          "https://raw.githubusercontent.com/github/explore/80688e429a7d4ef2fca1e82350fe8e3517d3494d/topics/react/react.png";
  final List<Widget> _children = [
    HomePageContent(),
    CodingTipsPage(),
    NewPost(),
    BooksPage(),
    PostsPage()
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      drawer: Container(
        width: 260.0,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(fullName),
                accountEmail: Text(email),
                currentAccountPicture: InkWell(
                    child: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).platform == TargetPlatform.iOS
                                ? Colors.black
                                : Colors.white,
                        radius: 50.0,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileImage(
                                      image: profileImageUrl, name: fullName),
                                ));
                          },
                          child: CircleAvatar(
                            radius: 48.0,
                            backgroundImage: new NetworkImage(profileImageUrl),
                            backgroundColor: Colors.white,
                          ),
                        ))),
              ),
              ListTile(
                title: Text("Tools"),
                leading: Icon(MdiIcons.wrench),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/tools');
                },
              ),
              ListTile(
                title: Text("My Profile"),
                leading: Icon(
                  Icons.person,
                ),
                onTap: () {
                  _viewProfile();
                },
              ),
              ListTile(
                title: Text("My Posts"),
                leading: Icon(
                  Icons.post_add,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/myposts');
                },
              ),
              ListTile(
                title: Text("Find people"),
                leading: Icon(Icons.search),
                onTap: () {
                  Navigator.of(context).pushNamed('/findpeople');
                },
              ),
              ListTile(
                title: Text("Interview Preparation"),
                leading: Icon(Icons.corporate_fare),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/interviewpage');
                },
              ),
              ListTile(
                title: Text("Explore Jobs"),
                leading: Icon(Icons.explore),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/jobs');
                },
              ),
              ListTile(
                title: Text("Mini Bytes"),
                leading: Icon(Icons.donut_small),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/bytepage');
                },
              ),
              ListTile(
                title: Text("Settings"),
                leading: Icon(Icons.settings),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/settings');
                },
              ),
            ],
          ),
        ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavyBar(
        selectedIndex:
            _currentIndex, // this will be set when a new tab is tapped
        //        selectedItemColor: Colors.black54,
        //        unselectedItemColor: Colors.black,
        onItemSelected: onTabTapped, // new
        items: [
          BottomNavyBarItem(
            activeColor: Colors.blue,
            inactiveColor: Colors.blueGrey,
            icon: new Icon(Icons.home),
            title: new Text(
              'Home',
              style: GoogleFonts.ptSansNarrow(
                  textStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ),
          BottomNavyBarItem(
            activeColor: Colors.blue,
            inactiveColor: Colors.blueGrey,
            icon: new Icon(Icons.lightbulb_outline),
            title: new Text(
              'Coding Tips',
              style: GoogleFonts.ptSansNarrow(
                  textStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ),
          BottomNavyBarItem(
              activeColor: Colors.blue,
              inactiveColor: Colors.blueGrey,
              icon: Icon(Icons.add_circle),
              title: Text(
                'New Post',
                style: GoogleFonts.ptSansNarrow(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              )),
          BottomNavyBarItem(
              activeColor: Colors.blue,
              inactiveColor: Colors.blueGrey,
              icon: Icon(Icons.library_books),
              title: Text(
                'Books',
                style: GoogleFonts.ptSansNarrow(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              )),
          BottomNavyBarItem(
              activeColor: Colors.blue,
              inactiveColor: Colors.blueGrey,
              icon: Icon(Icons.dynamic_feed),
              title: Text(
                'Feed',
                style: GoogleFonts.ptSansNarrow(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ))
        ],
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        title: Text(
          'Dev Portal',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'MyFont',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                showAlertDialog(context);
              },
              child: Icon(
                Icons.logout,
              ),
            ),
          )
        ],
        actionsIconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }

  void _logOut() {
    // logout
    if (auth.getCurrentUser() != null) {
      auth.signOut();
      // return to login page
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (r) => false);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "Cancel",
        style:
            TextStyle(color: Colors.blue, fontFamily: 'MyFont', fontSize: 16),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        "Continue",
        style:
            TextStyle(color: Colors.blue, fontFamily: 'MyFont', fontSize: 16),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        _logOut();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Confirmation",
        style: GoogleFonts.ptSansNarrow(
          textStyle: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      ),
      content: ListView(shrinkWrap: true, children: [
        Icon(
          Icons.logout,
          color: Colors.blue,
          size: 80.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          "Are you sure to Logout?",
          style: GoogleFonts.ptSansNarrow(textStyle: TextStyle(fontSize: 16)),
        ),
      ]),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    if (auth.getCurrentUser() == null) {
      Navigator.of(context).pushNamed('/login');
    }
    // retrieve fullname and email from the DB
    retrieveData();
  }

  showCustomDialog(BuildContext context) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 400.0,
        width: 300.0,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.dashboard,
                      size: 40,
                    ),
                    Text('Dashboard',
                        style: GoogleFonts.ptSansNarrow(
                            textStyle: TextStyle(fontWeight: FontWeight.bold)))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: RaisedButton(
                  child: Text(
                    'New Post',
                    style: GoogleFonts.ptSansNarrow(
                        textStyle: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/newpost');
                  },
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(10, 18, 10, 18),
                  elevation: 5.0,
                  color: Colors.black,
                  splashColor: Colors.grey,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: RaisedButton(
                  child: Text(
                    'Share Snippets',
                    style: GoogleFonts.ptSansNarrow(
                        textStyle: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  onPressed: () {},
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(10, 18, 10, 18),
                  elevation: 5.0,
                  color: Colors.black,
                  splashColor: Colors.grey,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: RaisedButton(
                  child: Text(
                    'Career Guidance',
                    style: GoogleFonts.ptSansNarrow(
                        textStyle: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  onPressed: () {
                    // Contains Resume Tips
                  },
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(10, 18, 10, 18),
                  elevation: 5.0,
                  color: Colors.black,
                  splashColor: Colors.grey,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: RaisedButton(
                  child: Text(
                    'Productivity Meter',
                    style: GoogleFonts.ptSansNarrow(
                        textStyle: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  onPressed: () {},
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(10, 18, 10, 18),
                  elevation: 5.0,
                  color: Colors.black,
                  splashColor: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }

  void _viewProfile() {
    // show profile
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed('/profile');
  }

  void retrieveData() async {
    final FirebaseUser user = await auth.getCurrentUser();
    final userId = user.uid;
    myRef =
        FirebaseDatabase.instance.reference().child('Profile').child(userId);
    myRef.once().then((DataSnapshot dataSnapshot) {
      setState(() {
        if (dataSnapshot.value != null) {
          profileImageUrl = dataSnapshot.value["imagepath"];
          fullName = dataSnapshot.value["firstname"] +
              " " +
              dataSnapshot.value["lastname"];
          email = dataSnapshot.value["email"];
        }
      });
    });
  }
}
