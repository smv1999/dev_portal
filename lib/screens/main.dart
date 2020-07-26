import 'package:after_layout/after_layout.dart';
import 'file:///C:/Users/smv1999/dev_portal/lib/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/route_generator.dart';

void main() {
  runApp(MainApplication());
}

class MainApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
//  with AfterLayoutMixin<IntroScreen>
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: "Write Better Code",
        description: "Best Coding Practices and tips for writing cleaner code",
        pathImage: "images/intro1.png",
        styleTitle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
        styleDescription: TextStyle(color: Colors.black, fontSize: 18),
        backgroundColor: Colors.white,
      ),
    );
    slides.add(
      new Slide(
        title: "Read what matters",
        description: "Best books for improving coding skills",
        pathImage: "images/intro2.png",
        styleTitle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
        styleDescription: TextStyle(color: Colors.black, fontSize: 18),
        backgroundColor: Colors.white,
      ),
    );
    slides.add(
      new Slide(
        title: "Make learning Fun",
        description: "Have fun and get inspired through Memes and Quotes",
        pathImage: "images/intro3.png",
        styleTitle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
        styleDescription: TextStyle(color: Colors.black, fontSize: 18),
        backgroundColor: Colors.white,
      ),
    );
    slides.add(
      new Slide(
        title: "Learn the right way",
        description: "Best Learning resources and YouTube Channels",
        pathImage: "images/intro4.png",
        styleTitle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
        styleDescription: TextStyle(color: Colors.black, fontSize: 18),
        backgroundColor: Colors.white,
      ),
    );
    slides.add(
      new Slide(
        title: "Have a discussion",
        description: "Make use of the discussion forums and learn together",
        pathImage: "images/intro5.png",
        styleTitle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
        styleDescription: TextStyle(color: Colors.black, fontSize: 18),
        backgroundColor: Colors.white,
      ),
    );
  }

  Future<void> onDonePress() async {
    // Do what you want
    final navigator = Navigator.of(context);
    await navigator.pushNamed('/login');
    navigator.pop();
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushNamed('/login');
    } else {
       await prefs.setBool('seen', true);
    }
  }


  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: checkFirstSeen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child:
              Container(
                child: CircularProgressIndicator(),
              )
            );
          } else {
            return new IntroSlider(
              slides: this.slides,
              onDonePress: this.onDonePress,
              styleNameSkipBtn: TextStyle(color: Colors.black),
              styleNamePrevBtn: TextStyle(color: Colors.black),
              styleNameDoneBtn: TextStyle(color: Colors.black),
            );
          }
        });
  }
}