import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlighter_coachmark/highlighter_coachmark.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class CodingTipsPage extends StatefulWidget {
  @override
  _CodingTipsPageState createState() => _CodingTipsPageState();
}

class _CodingTipsPageState extends State<CodingTipsPage> with TickerProviderStateMixin {
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
      child: Column(
        children: [
          SizedBox(
            height: 30.0,
          ),
          Center(child:TextLiquidFill(
            text: 'Tips for Best Coding Style',
            waveColor: Colors.black,
            boxBackgroundColor: Colors.white,
            textStyle: TextStyle(
              fontSize: 35.0,
              fontFamily: 'MyFont'
            ),
            boxHeight: 50.0,
          ),
          ),
          Container(
            key: _cardKey,
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.height * 0.6,
          child:TinderSwapCard(
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
        ],
      ),
    );
  }
  Future checkTipSeen() async {
    prefs = await SharedPreferences.getInstance();
    _seen = (prefs.getBool('tipseen') ?? false);
    if(!_seen){
      showCardTip();
      await prefs.setBool('tipseen', true);
    }
  }
  void showCardTip() {
    CoachMark coachMarkFAB = CoachMark();
    RenderBox target = _cardKey.currentContext.findRenderObject();

    // you can change the shape of the mark
    Rect markRect = target.localToGlobal(Offset.zero) & target.size;
    markRect = Rect.fromCircle(center: markRect.center, radius: markRect.longestSide * 0.6);

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
}
