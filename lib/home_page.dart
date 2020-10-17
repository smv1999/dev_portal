import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:dev_portal/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'misc_helpers/Constants.dart';
import 'pages/coding_tips.dart';
import 'home_page_content.dart';
import 'pages/books_page.dart';
import 'pages/forum_page.dart';
import 'pages/posts_page.dart';

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
    PostsPage()
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      backgroundColor: Colors.white,
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavyBar(
        selectedIndex:
            _currentIndex, // this will be set when a new tab is tapped
//        selectedItemColor: Colors.black54,
//        unselectedItemColor: Colors.black,
        onItemSelected: onTabTapped, // new
        items: [
          BottomNavyBarItem(
            activeColor: Colors.black,
            inactiveColor: Colors.grey,
            icon: new Icon(Icons.home),
            title: new Text('Home', style: GoogleFonts.ptSansNarrow(textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),),
          ),
          BottomNavyBarItem(
            activeColor: Colors.black,
            inactiveColor: Colors.grey,
            icon: new Icon(Icons.lightbulb_outline),
            title: new Text('Coding Tips', style: GoogleFonts.ptSansNarrow(textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),),
          ),
          BottomNavyBarItem(
              activeColor: Colors.black,
              inactiveColor: Colors.grey,
              icon: Icon(Icons.library_books),
              title: Text('Books', style: GoogleFonts.ptSansNarrow(textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),)),
          BottomNavyBarItem(
              activeColor: Colors.black,
              inactiveColor: Colors.grey,
              icon: Icon(Icons.chat),
              title: Text('Forum', style: GoogleFonts.ptSansNarrow(textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),)),
          BottomNavyBarItem(
              activeColor: Colors.black,
              inactiveColor: Colors.grey,
              icon: Icon(Icons.post_add),
              title: Text('Feed', style: GoogleFonts.ptSansNarrow(textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),))
        ],
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Dev Portal',
          style: TextStyle(color: Colors.black, fontFamily: 'MyFont', fontWeight: FontWeight.bold),
        ),
//        leading: GestureDetector(
//          onTap: () {
//            // open dialog
//            showCustomDialog(context);
//          },
//          child: Icon(
//            Icons.menu,
//          ),
//        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context){
                return Constants.choices.map((String choice){
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice, style: GoogleFonts.ptSansNarrow(textStyle: TextStyle(fontSize: 16)),),
                  );
                }).toList();
            },
          )
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
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (r) => false);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(color: Colors.black, fontFamily: 'MyFont', fontSize: 16),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        "Continue",
        style: TextStyle(color: Colors.black, fontFamily: 'MyFont', fontSize: 16),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        _logOut();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmation", style: GoogleFonts.ptSansNarrow(textStyle: TextStyle(fontSize: 16)),),
      content: Text("Are you sure to Logout?", style: GoogleFonts.ptSansNarrow(textStyle: TextStyle(fontSize: 16)),),
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

//  showCustomDialog(BuildContext context) {
//    Dialog errorDialog = Dialog(
//      shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(12.0)
//      ),
//      child: Container(
//        height: 300.0,
//        width: 300.0,
//        child: Padding(
//          padding: const EdgeInsets.all(15.0),
//          child: ListView(
//            shrinkWrap: true,
//            children: [
//              Padding(
//                  padding: EdgeInsets.all(15.0),
//                  child: Image.asset('images/dev_animated.gif',
//                  height: 100,
//                  width: 100,
//                  )
//              ),
//              Padding(
//                padding: EdgeInsets.all(10.0),
//                child: RaisedButton(
//                  child: Text('My Profile', style: GoogleFonts.ptSansNarrow(textStyle: TextStyle(fontWeight: FontWeight.bold)),),
//                  onPressed: _viewProfile,
//                  textColor: Colors.white,
//                  padding: EdgeInsets.fromLTRB(10, 18, 10, 18),
//                  elevation: 5.0,
//                  color: Colors.lightBlue,
//                  splashColor: Colors.lightBlueAccent,
//                ),
//              ),
//              SizedBox(
//                height: 5.0,
//              ),
//              Padding(
//                padding: EdgeInsets.all(10.0),
//                child: RaisedButton(
//                  child: Text('Explore Learning Resources', style: GoogleFonts.ptSansNarrow(textStyle: TextStyle(fontWeight: FontWeight.bold)),),
//                  onPressed: _exploreLearningResources,
//                  textColor: Colors.white,
//                  padding: EdgeInsets.fromLTRB(10, 18, 10, 18),
//                  elevation: 5.0,
//                  color: Colors.lightBlue,
//                  splashColor: Colors.lightBlueAccent,
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
//    );
//    showDialog(
//        context: context, builder: (BuildContext context) => errorDialog);
//  }

  void _viewProfile() {
    // show profile
    Navigator.of(context).pushNamed('/profile');
  }

  void choiceAction(String choice)
  {
    if(choice == Constants.Settings)
      {
        Navigator.of(context).pushNamed('/settings');
      }
    else if(choice == Constants.Logout)
      {
        showAlertDialog(context);
      }
    else if(choice == Constants.Profile)
      {
        _viewProfile();
      }
  }
}
