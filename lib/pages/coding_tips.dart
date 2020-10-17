import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlighter_coachmark/highlighter_coachmark.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class CodingTipsPage extends StatefulWidget {
  @override
  _CodingTipsPageState createState() => _CodingTipsPageState();
}

class _CodingTipsPageState extends State<CodingTipsPage>
    with TickerProviderStateMixin {
  List<String> welcomeImages = [
    "images/tips1.png",
    "images/tips2.png",
    "images/tips3.png",
    "images/tips4.png",
    "images/tips5.png",
    "images/tips6.png",
    "images/tips7.png",
    "images/tips8.png",
  ];
  GlobalKey _cardKey = GlobalObjectKey("card");
  SharedPreferences prefs;
  bool _seen;
  @override
  void initState() {
    super.initState();
    checkTipSeen();
  }

  @override
  Widget build(BuildContext context) {
    CardController controller; //Use this to trigger swap.

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30.0,
            ),
            Center(
              child: TextLiquidFill(
                text: 'Tips for Best Coding Style',
                waveColor: Colors.black,
                boxBackgroundColor: Colors.white,
                textStyle: TextStyle(fontSize: 35.0, fontFamily: 'MyFont'),
                boxHeight: 50.0,
              ),
            ),
            Container(
              key: _cardKey,
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.height * 0.6,
              child: TinderSwapCard(
                swipeUp: true,
                swipeDown: true,
                orientation: AmassOrientation.BOTTOM,
                totalNum: welcomeImages.length,
                stackNum: 3,
                swipeEdge: 4.0,
                maxWidth: MediaQuery.of(context).size.width * 0.9,
                maxHeight: MediaQuery.of(context).size.width * 0.9,
                minWidth: MediaQuery.of(context).size.width * 0.8,
                minHeight: MediaQuery.of(context).size.width * 0.8,
                cardBuilder: (context, index) => Card(
                  color: Colors.white, // white
                  shadowColor: Colors.grey,
                  child: Image.asset('${welcomeImages[index]}'),
                ),
                cardController: controller = CardController(),
                swipeUpdateCallback:
                    (DragUpdateDetails details, Alignment align) {
                  /// Get swiping card's alignment
                  if (align.x < 0) {
                    //Card is LEFT swiping
                  } else if (align.x > 0) {
                    //Card is RIGHT swiping
                  }
                },
                swipeCompleteCallback:
                    (CardSwipeOrientation orientation, int index) {
                  /// Get orientation & index of swiped card!
                },
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: TyperAnimatedTextKit(
                text: [
                  "Articles on Best Coding Practices",
                ],
                textStyle: TextStyle(fontSize: 30.0, fontFamily: "MyFont"),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () => openArticle(1),
                title: Text(
                  'Few simple Rules for good coding',
                  style: GoogleFonts.ptSansNarrow(),
                ),
                leading: Container(width: 80,
                  child:Image.network(
                    'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/article1.jpg?token=AKHIZQNFJJWTTWO6YHXHWMC7G7J3O'),),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () => openArticle(2),
                title: Text(
                  'Best JavaScript coding practices',
                  style: GoogleFonts.ptSansNarrow(),
                ),
                leading: Container(width: 80.0,
                  child:Image.network(
                    'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/article2.png?token=AKHIZQNIX5T5J5MCI2TWAE27G7LK2'),),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () => openArticle(3),
                title: Text(
                  'A summary of Java Coding Best practices',
                  style: GoogleFonts.ptSansNarrow(),
                ),
                leading: Container(width: 80,
                  child:Image.network(
                    'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/article3.png?token=AKHIZQJF2CPMPK7X7RZIMSS7G7LOA'),),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () => openArticle(4),
                title: Text(
                  'Best coding practices-tips and more for Android',
                  style: GoogleFonts.ptSansNarrow(),
                ),
                leading: Container(width: 80.0,
                  child:Image.network(
                    'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/article4.jpg?token=AKHIZQJDZSO3TPNNLDIPQWC7G7LTW'),),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Center(
              child: TyperAnimatedTextKit(
                text: [
                  "From the Author",
                ],
                textStyle: TextStyle(fontSize: 30.0, fontFamily: "MyFont"),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () => openArticle(5),
                title: Text(
                  'How to build Intro Slider for your Android App',
                  style: GoogleFonts.ptSansNarrow(),
                ),
                leading: Container(width: 80.0,
                  child:Image.network(
                    'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/article4.jpg?token=AKHIZQJDZSO3TPNNLDIPQWC7G7LTW'),),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () => openArticle(6),
                title: Text(
                  'How to Create Custom Alert Dialog in Android',
                  style: GoogleFonts.ptSansNarrow(),
                ),
                leading: Container(width: 80.0,
                  child:Image.network(
                    'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/article4.jpg?token=AKHIZQJDZSO3TPNNLDIPQWC7G7LTW'),),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () => openArticle(7),
                title: Text(
                  'How to Create Dark theme in Android',
                  style: GoogleFonts.ptSansNarrow(),
                ),
                leading: Container(width: 80.0,
                  child:Image.network(
                    'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/article4.jpg?token=AKHIZQJDZSO3TPNNLDIPQWC7G7LTW'),),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () => openArticle(8),
                title: Text(
                  'How to Create Animations and Transitions for your Android App',
                  style: GoogleFonts.ptSansNarrow(),
                ),
                leading: Container(width: 80.0,
                  child:Image.network(
                    'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/article4.jpg?token=AKHIZQJDZSO3TPNNLDIPQWC7G7LTW'),),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () => openArticle(9),
                title: Text(
                  'Projects Vs Competitive Programming',
                  style: GoogleFonts.ptSansNarrow(),
                ),
                leading: Container(width: 80.0,
                  child:Image.network(
                    'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/article9.jpeg?token=AKHIZQILQBJZSTFZTHR2FFK7G735U'),),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () => openArticle(10),
                title: Text(
                  'All you need to know about Pointers - Part-1',
                  style: GoogleFonts.ptSansNarrow(),
                ),
                leading: Container(width: 80.0,
                  child:Image.network(
                    'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/article10.png?token=AKHIZQNHUHXNYUN6VFSALES7G74I4'),),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () => openArticle(11),
                title: Text(
                  'All you need to know about Pointers - Part-2',
                  style: GoogleFonts.ptSansNarrow(),
                ),
                leading: Container(width: 80.0,
                  child:Image.network(
                    'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/article10.png?token=AKHIZQNHUHXNYUN6VFSALES7G74I4'),),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10),
            // button for bytes
            SizedBox(
              width: 150.0,
              child: RaisedButton(
                child: Text(
                  'Have a Byte!',
                  style: GoogleFonts.ptSansNarrow(
                      textStyle: TextStyle(fontWeight: FontWeight.bold)),
                ),
                onPressed: () => {
                  // 
                  Navigator.of(context).pushNamed('/bytepage')
                },
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(10, 18, 10, 18),
                elevation: 5.0,
                color: Colors.black,
                splashColor: Colors.grey,
                shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0)),
              ),
            ),
            SizedBox(height:10),
          ],
        ),
      ),
    );
  }

  
  Future checkTipSeen() async {
    prefs = await SharedPreferences.getInstance();
    _seen = (prefs.getBool('tipseen') ?? false);
    if (!_seen) {
      showCardTip();
      await prefs.setBool('tipseen', true);
    }
  }

  void showCardTip() {
    CoachMark coachMarkFAB = CoachMark();
    RenderBox target = _cardKey.currentContext.findRenderObject();

    // you can change the shape of the mark
    Rect markRect = target.localToGlobal(Offset.zero) & target.size;
    markRect = Rect.fromCircle(
        center: markRect.center, radius: markRect.longestSide * 0.6);

    coachMarkFAB.show(
      targetContext: _cardKey.currentContext,
      markRect: markRect,
      children: [
        Center(
          child: Text(
            "Swipe the Cards right/left to know more tips!",
            style: const TextStyle(
              fontSize: 21.0,
              fontFamily: 'MyFont',
              fontWeight: FontWeight.bold,
              color: Colors.yellow,
            ),
          ),
        )
      ],
      duration: null,
    );
  }

  void openArticle(int choice) async {
    var url;
    switch (choice) {
      case 1:
        url =
            'https://hackernoon.com/few-simple-rules-for-good-coding-my-15-years-experience-96cb29d4acd9';
        break;
      case 2:
        url =
            'https://medium.com/javascript-in-plain-english/javascript-best-practices-for-beginners-b573cbc1ec0f';
        break;
      case 3:
        url =
            'https://medium.com/@rhamedy/a-short-summary-of-java-coding-best-practices-31283d0167d3';
        break;
      case 4:
        url =
            'https://medium.com/mindorks/best-coding-practices-tips-and-more-for-android-4ec03c7eeb2c';
        break;
      case 5:
        url =
            'https://medium.com/@vaidhyanathan.sm/how-to-build-intro-slider-for-your-app-1dfd55e82b17';
        break;
      case 6:
        url =
            'https://medium.com/@vaidhyanathan.sm/how-to-create-custom-alert-dialog-in-android-5ec6c350447a';
        break;
      case 7:
        url =
            'https://medium.com/@vaidhyanathan.sm/how-to-create-dark-theme-in-android-55a84c9a3caa';
        break;
      case 8:
        url =
            'https://medium.com/@vaidhyanathan.sm/how-to-create-animations-and-transitions-for-your-android-app-2bdd31e533a3';
        break;
      case 9:
        url =
            'https://medium.com/@vaidhyanathan.sm/projects-vs-competitive-programming-f0c997486aeb';
        break;
      case 10:
        url =
            'https://medium.com/@vaidhyanathan.sm/all-you-need-to-know-about-pointers-part-1-1470d2d24d78';
        break;
      case 11:
        url =
            'https://medium.com/@vaidhyanathan.sm/all-you-need-to-know-about-pointers-part-2-b6153ed93fe';
        break;
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
