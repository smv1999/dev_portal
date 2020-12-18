import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  SharedPreferences prefs;
  bool _seen;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkTipSeen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Create a grid layout of the dashboard items
        appBar: AppBar(
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          title: Text(
            'Dev Portal',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'MyFont',
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Container(
          child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ListView(shrinkWrap: true, children: <Widget>[
                SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: Text(
                    'Dashboard',
                    style: TextStyle(fontSize: 30.0, fontFamily: 'MyFont'),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  child: GridView.count(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    mainAxisSpacing: 25.0,
                    crossAxisCount: 2,
                    children: <Widget>[
                      GestureDetector(
                        onLongPress: () {
                          showFloatingFlushbar(context, 'To Do Lists');
                        },
                        onTap: () {
                          Navigator.of(context).pushNamed('/todolist');
                        },
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          child: Image.asset('images/productivity.png'),
                          elevation: 5,
                        ),
                      ),
                      GestureDetector(
                        onLongPress: () {
                          showFloatingFlushbar(context, 'Project Ideas');
                        },
                        onTap: () {
                          Navigator.of(context).pushNamed('/projects');
                        },
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          child: Image.asset('images/projects.jpg'),
                          // Text('Career Guidance'),
                          elevation: 5,
                        ),
                      ),
                    ],
                  ),
                ),
              ])),
        ));
  }

  Future checkTipSeen() async {
    prefs = await SharedPreferences.getInstance();
    _seen = (prefs.getBool('sheetseen') ?? false);
    if (!_seen) {
      showBottomSheetDialog();
      await prefs.setBool('sheetseen', true);
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
                    Image.asset(
                      'images/getting_started.png',
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
                      'This Dashboard consists of To Do Lists and Project Ideas which will help you increase your productivity.',
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

  void showFloatingFlushbar(BuildContext context, String text) {
    Flushbar(
        icon: Icon(Icons.info),
        padding: EdgeInsets.all(10),
        borderRadius: 8,
        backgroundGradient: LinearGradient(
          colors: [Colors.green.shade800, Colors.greenAccent.shade700],
          stops: [0.6, 1],
        ),
        boxShadows: [
          BoxShadow(
            color: Colors.black45,
            offset: Offset(3, 3),
            blurRadius: 3,
          ),
        ],
        // All of the previous Flushbars could be dismissed by swiping down
        // now we want to swipe to the sides
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        // The default curve is Curves.easeOut
        forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
        message: text)
      ..show(context);
  }
}
