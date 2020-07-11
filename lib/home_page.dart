import 'package:dev_portal/login_page.dart';
import 'package:dev_portal/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'coding_tips.dart';
import 'home_page_content.dart';
import 'books_page.dart';
import 'forum_page.dart';
import 'fun_area_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  Auth auth = new Auth();
  final List<Widget> _children = [
    HomePageContent(),
    CodingTipsPage(),
    BooksPage(),
    ForumPage(),
    FunAreaPage()
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      backgroundColor: Colors.white,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            _currentIndex, // this will be set when a new tab is tapped
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.black,
        onTap: onTabTapped, // new
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.lightbulb_outline),
            title: new Text('Coding Tips'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), title: Text('Books')),
          BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text('Forum')),
          BottomNavigationBarItem(
              icon: Icon(Icons.image), title: Text('Fun Area'))
        ],
      ),
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        leading: GestureDetector(
          onTap: () {
            // open dialog
            showCustomDialog(context);
          },
          child: Icon(
            Icons.menu,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  // open alert dialog
                  showAlertDialog(context);
                },
                child: Icon(
                  Icons.power_settings_new,
                  size: 26.0,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  // open settings activity
                },
                child: Icon(Icons.settings),
              )),
        ],
        actionsIconTheme: IconThemeData(color: Colors.black),
      ),
    );
  }

  void _logOut() {
    // logout
    if (auth.getCurrentUser() != null) {
      auth.signOut();
      // return to login page
      Navigator.of(context).pushNamed('/login');
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        "Continue",
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        _logOut();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text("Are you sure to Logout?"),
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
  }

  showCustomDialog(BuildContext context) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)
      ),
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Image.asset('images/dev.jpg',
                  height: 100,
                  width: 100,
                  )
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: RaisedButton(
                  child: Text('My Profile'),
                  onPressed: _viewProfile,
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
                  child: Text('Explore Learning Resources'),
                  onPressed: _viewProfile,
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
  }
}
