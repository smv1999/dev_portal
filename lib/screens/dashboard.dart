import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Create a grid layout of the dashboard items
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Dashboard',
            style: TextStyle(
                color: Colors.black,
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
                  child: TextLiquidFill(
                    text: 'Dashboard',
                    waveColor: Colors.black,
                    boxBackgroundColor: Colors.white,
                    textStyle: TextStyle(fontSize: 30.0, fontFamily: 'MyFont'),
                    boxHeight: 50.0,
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
                      // add buttons
                      GestureDetector(
                        onLongPress: () {
                          showFloatingFlushbar(context, 'Career Guidance');
                        },
                        onTap: () {},
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          child: Image.asset('images/career_guidance.png'),
                          // Text('Career Guidance'),
                          elevation: 5,
                        ),
                      ),
                      GestureDetector(
                        onLongPress: () {
                          showFloatingFlushbar(context, 'Productivity Meter');
                        },
                        onTap: () {
                          Navigator.of(context).pushNamed('/todolist');
                        },
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          child: Image.asset('images/productivity.png'),
                          // Text('Productivity Meter'),
                          elevation: 5,
                        ),
                      ),
                       GestureDetector(
                        onLongPress: () {
                          showFloatingFlushbar(context, 'Project Ideas');
                        },
                        onTap: () {},
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
      message: text
    )..show(context);
  }
}
