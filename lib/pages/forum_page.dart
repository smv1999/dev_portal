import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ForumPage extends StatefulWidget {
  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: 15.0,),
            Center(child:TextLiquidFill(
              text: 'Channels',
              waveColor: Colors.black,
              boxBackgroundColor: Colors.white,
              textStyle: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'MyFont'
              ),
              boxHeight: 50.0,
            ),
            ),
            SizedBox(height: 15.0,),
            Container(
              child:GridView.count(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                mainAxisSpacing: 25.0,
                crossAxisCount: 2,
                children: <Widget>[
                  GestureDetector(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset('images/python.png'),
                    ),
                  ),
                  GestureDetector(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset('images/js.png'),
                    ),

                  ),
                  GestureDetector(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset('images/cplusplus.png'),
                    ),

                  ),
                  GestureDetector(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset('images/android.jpg'),
                    ),

                  ),
                  GestureDetector(
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset('images/mysql.jpg'),
                      ),

                  ),
                  GestureDetector(
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset('images/csharp.png'),
                      ),

                  ),
                  GestureDetector(
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset('images/java.png'),
                      ),

                  ),
                  GestureDetector(
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset('images/php.png'),
                      ),

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
