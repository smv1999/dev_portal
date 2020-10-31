import 'package:dev_portal/services/ProgressBar.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroScreen();
  }
}

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
//  with AfterLayoutMixin<IntroScreen>
  List<Slide> slides = new List();
  bool _seen = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Add Your Code here.
      setState(() {
        checkFirstSeen();
      });
    });
    slides.add(
      new Slide(
        title: "Write Better Code",
        description: "Best Coding Practices and tips for writing cleaner code",
        pathImage: "images/intro1.png",
        styleTitle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontFamily: 'MyFont'),
        styleDescription:
            TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'MyFont'),
        backgroundColor: Colors.white,
      ),
    );
    slides.add(
      new Slide(
        title: "Read what matters",
        description: "Best books for improving coding skills",
        pathImage: "images/intro2.png",
        styleTitle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontFamily: 'MyFont'),
        styleDescription:
            TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'MyFont'),
        backgroundColor: Colors.white,
      ),
    );
    slides.add(
      new Slide(
        title: "Have a Byte",
        description: "Get information in byte sized high-quality content",
        pathImage: "images/intro3.png",
        styleTitle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontFamily: 'MyFont'),
        styleDescription:
            TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'MyFont'),
        backgroundColor: Colors.white,
      ),
    );
    slides.add(
      new Slide(
        title: "Interview Preparation Module",
        description: "Quality content to help you prepare for interviews",
        pathImage: "images/intro4.png",
        styleTitle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontFamily: 'MyFont'),
        styleDescription:
            TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'MyFont'),
        backgroundColor: Colors.white,
      ),
    );
    slides.add(
      new Slide(
        title: "Have a discussion",
        description: "Make use of the discussion forums and learn together",
        pathImage: "images/intro5.png",
        styleTitle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            fontFamily: 'MyFont'),
        styleDescription:
            TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'MyFont'),
        backgroundColor: Colors.white,
      ),
    );
  }

  Future<void> onDonePress() async {
    // Do what you want
    final navigator = Navigator.of(context);
    await navigator.pushNamedAndRemoveUntil('/login', (r) => false);
    navigator.pop();
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (r) => false);
    } else {
      await prefs.setBool('seen', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return !_seen ?
    new IntroSlider(
            slides: this.slides,
            onDonePress: this.onDonePress,
            styleNameSkipBtn:
                TextStyle(color: Colors.black, fontFamily: 'MyFont'),
            styleNamePrevBtn:
                TextStyle(color: Colors.black, fontFamily: 'MyFont'),
            styleNameDoneBtn:
                TextStyle(color: Colors.black, fontFamily: 'MyFont'),
          )
        : new Container(
          color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            ),
          );
  }
}
