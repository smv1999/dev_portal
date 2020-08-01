import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

//void main() {
//  runApp(MainApplication());
//}

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
  ProgressDialog pr;

  @override
  void initState() {
    super.initState();
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    pr.style(
        message: 'Syncing Please Wait...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Add Your Code here.
      await pr.show();
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
      pr.hide();
      Navigator.of(context).pushNamed('/login');
    } else {
      await prefs.setBool('seen', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
      styleNameSkipBtn: TextStyle(color: Colors.black),
      styleNamePrevBtn: TextStyle(color: Colors.black),
      styleNameDoneBtn: TextStyle(color: Colors.black),
    );
  }
}
