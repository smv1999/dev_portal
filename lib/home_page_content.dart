import 'package:dev_portal/screens/carousel_tech_content.dart';
import 'package:dev_portal/services/ProgressBar.dart';
import 'package:dev_portal/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  FirebaseStorage _storage = FirebaseStorage.instance;
  DatabaseReference myRef;
  Auth auth = new Auth();
  String _profile_image, firstName = "Developer";
  ProgressBar progressBar;

  @override
  void initState() {
    super.initState();
    progressBar = ProgressBar();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add Your Code here.
      showSendingProgressBar();
      setState(() {
        _setData();
      });
    });
  }

  @override
  void dispose() {
    progressBar.hide();
    super.dispose();
  }

  void showSendingProgressBar() {
    progressBar.show(context);
  }

  void hideSendingProgressBar() {
    progressBar.hide();
  }

  Future<void> _setData() async {
    // retrieve from Firebase DB and display
    final FirebaseUser user = await auth.getCurrentUser();
    final userId = user.uid;
    StorageReference reference = _storage.ref().child(userId).child("Images/");
    myRef =
        FirebaseDatabase.instance.reference().child('Profile').child(userId);
    myRef.once().then((DataSnapshot dataSnapshot) {
      setState(() {
        if (dataSnapshot.value != null) {
          _profile_image = dataSnapshot.value["imagepath"];
          firstName = dataSnapshot.value["firstname"];
          hideSendingProgressBar();
        } else {
          setState(() {
            hideSendingProgressBar();
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.blue,
              child: ListView(
                shrinkWrap: true,
                children: [
                  _profile_image != null
                      ? InkWell(
                          child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50.0,
                          child: CircleAvatar(
                            radius: 48.0,
                            backgroundImage: new NetworkImage(_profile_image),
                            backgroundColor: Colors.white,
                          ),
                        ))
                      : InkWell(
                          child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50.0,
                          child: CircleAvatar(
                            radius: 48.0,
                            backgroundImage: NetworkImage(
                                'https://raw.githubusercontent.com/github/explore/80688e429a7d4ef2fca1e82350fe8e3517d3494d/topics/react/react.png'),
                            backgroundColor: Colors.white,
                          ),
                        )),
                  SizedBox(
                    height: 15.0,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: new TextSpan(
                      children: <TextSpan>[
                        new TextSpan(
                            text: 'Welcome, ',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white)),
                        new TextSpan(
                          text: firstName + "!",
                          style: new TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                          child: Text(
                            'Explore Jobs',
                            style: GoogleFonts.ptSansNarrow(
                                textStyle:
                                    TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/jobs');
                          },
                          textColor: Colors.blue,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          elevation: 5.0,
                          color: Colors.white,
                          splashColor: Colors.white54,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0))),
                      RaisedButton(
                          child: Text(
                            'Find People',
                            style: GoogleFonts.ptSansNarrow(
                                textStyle:
                                    TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/findpeople');
                          },
                          textColor: Colors.blue,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          elevation: 5.0,
                          color: Colors.white,
                          splashColor: Colors.white54,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0)))
                    ],
                  )
                ],
              )),
          SizedBox(
            height: 15.0,
          ),
          Container(
            height: 35,
            width: 75,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/homebackgroundimage.png"),
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 190.0,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 2),
              autoPlayAnimationDuration: Duration(milliseconds: 3000),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
            items: [
              'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/ai.png',
              'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/blockchain.png',
              'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/vrar.png',
              'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/cloudcomputing.png',
              'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/bigdata.jpeg',
              'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/rpa.png',
              'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/iot.png'
            ].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey)),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: Duration(seconds: 2),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        CarouselTechContent(i),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  animation = CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.elasticInOut);

                                  return ScaleTransition(
                                    scale: animation,
                                    alignment: Alignment.center,
                                    child: child,
                                  );
                                },
                              ));
                        },
                        child: Image.network(i),
                      ));
                },
              );
            }).toList(),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 35,
            width: 70,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/top_it_jobs.png"),
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: '• ',
                    style: TextStyle(color: Colors.lightBlue, fontSize: 19),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Software Developer',
                          style: GoogleFonts.ptSansNarrow(
                              textStyle: TextStyle(
                                  fontSize: 18, color: Colors.black))),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: '• ',
                    style: TextStyle(color: Colors.lightBlue, fontSize: 19),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Network Engineer',
                          style: GoogleFonts.ptSansNarrow(
                              textStyle: TextStyle(fontSize: 18),
                              color: Colors.black)),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: '• ',
                    style: TextStyle(color: Colors.lightBlue, fontSize: 19),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Systems Engineer',
                          style: GoogleFonts.ptSansNarrow(
                              textStyle: TextStyle(fontSize: 18),
                              color: Colors.black)),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: '• ',
                    style: TextStyle(color: Colors.lightBlue, fontSize: 19),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Java Developer',
                          style: GoogleFonts.ptSansNarrow(
                              textStyle: TextStyle(fontSize: 18),
                              color: Colors.black)),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: '• ',
                    style: TextStyle(color: Colors.lightBlue, fontSize: 19),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Software QA Engineer',
                          style: GoogleFonts.ptSansNarrow(
                              textStyle: TextStyle(fontSize: 18),
                              color: Colors.black)),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: '• ',
                    style: TextStyle(color: Colors.lightBlue, fontSize: 19),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'IT Project Manager',
                          style: GoogleFonts.ptSansNarrow(
                              textStyle: TextStyle(fontSize: 18),
                              color: Colors.black)),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: '• ',
                    style: TextStyle(color: Colors.lightBlue, fontSize: 19),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Application Developer',
                          style: GoogleFonts.ptSansNarrow(
                              textStyle: TextStyle(fontSize: 18),
                              color: Colors.black)),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: '• ',
                    style: TextStyle(color: Colors.lightBlue, fontSize: 19),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Computer Support Specialist',
                          style: GoogleFonts.ptSansNarrow(
                              textStyle: TextStyle(fontSize: 18),
                              color: Colors.black)),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: '• ',
                    style: TextStyle(color: Colors.lightBlue, fontSize: 19),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Business Analyst',
                          style: GoogleFonts.ptSansNarrow(
                              textStyle: TextStyle(fontSize: 18),
                              color: Colors.black)),
                    ],
                  ),
                )
              ],
            ),
          ),
          Column(children: [
            Text(
              "Want to know what is popular among developers?",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15.0,
            ),
            ButtonTheme(
              minWidth: 150.0,
              child: RaisedButton(
                  child: Text(
                    'Take a Look',
                    style: GoogleFonts.ptSansNarrow(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/popular');
                  },
                  textColor: Colors.white,
                  padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                  elevation: 5.0,
                  color: Colors.blue,
                  splashColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0))),
            ),
            SizedBox(
              height: 15.0,
            ),
          ])
        ],
      ),
    );
  }
}
