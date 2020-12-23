import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dev_portal/models/github_profile.dart';
import 'package:dev_portal/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  SharedPreferences prefs;
  bool _seen;
  DatabaseReference myRef;
  Auth auth = new Auth();
  String githubUsername = "smv1999";
  String githubProfileURL = "https://github.com/harshcasper";
  Future f;
  void initState() {
    super.initState();
    fetchGitHubUsername();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkTipSeen();
    });
    f = fetchGitHubProfileDetails();
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
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      GridView.count(
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
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        'GitHub Activity Score',
                        style: GoogleFonts.ptSansNarrow(
                          textStyle: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      (!(githubUsername == null))
                          ? Container(
                              width: 250,
                              child: GestureDetector(
                                onTap: () {
                                  openProfileURL();
                                },
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  child: ListView(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    children: [
                                      FutureBuilder(
                                        future: f,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return ListView(
                                                padding: EdgeInsets.all(20.0),
                                                shrinkWrap: true,
                                                children: [
                                                  Center(
                                                    child: snapshot.data
                                                                .profileImage ==
                                                            null
                                                        ? InkWell(
                                                            child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors.black,
                                                            radius: 50.0,
                                                            child: CircleAvatar(
                                                              radius: 48.0,
                                                              backgroundImage:
                                                                  new AssetImage(
                                                                      'images/programming.jpg'),
                                                              backgroundColor:
                                                                  Colors.black,
                                                            ),
                                                          ))
                                                        : InkWell(
                                                            child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors.black,
                                                            radius: 50.0,
                                                            child: CircleAvatar(
                                                              radius: 48.0,
                                                              backgroundImage:
                                                                  new NetworkImage(
                                                                      snapshot
                                                                          .data
                                                                          .profileImage),
                                                              backgroundColor:
                                                                  Colors.white,
                                                            ),
                                                          )),
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      snapshot.data.name,
                                                      style: GoogleFonts
                                                          .ptSansNarrow(
                                                              textStyle:
                                                                  TextStyle(
                                                                      fontSize:
                                                                          16.0)),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.0,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text('Followers: ' +
                                                              snapshot.data
                                                                  .followers
                                                                  .toString()),
                                                          SizedBox(
                                                            height: 8.0,
                                                          ),
                                                          Text('Following: ' +
                                                              snapshot.data
                                                                  .following
                                                                  .toString()),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text('Public Repos: ' +
                                                              snapshot.data
                                                                  .publicRepos
                                                                  .toString()),
                                                          SizedBox(
                                                            height: 8.0,
                                                          ),
                                                          Text('Blog: ' +
                                                              snapshot
                                                                  .data.blog),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8.0,
                                                  ),
                                                  RichText(
                                                    textAlign: TextAlign.center,
                                                    text: new TextSpan(
                                                      children: <TextSpan>[
                                                        new TextSpan(
                                                            text:
                                                                'Your Score: ',
                                                            style: TextStyle(
                                                                fontSize: 16.0,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        new TextSpan(
                                                          text: (snapshot.data
                                                                          .followers *
                                                                      1 +
                                                                  snapshot.data
                                                                          .publicRepos *
                                                                      2)
                                                              .toString(),
                                                          style: new TextStyle(
                                                            fontSize: 16.0,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ]);
                                          } else if (snapshot.hasError) {
                                            return Text("${snapshot.error}");
                                          }

                                          // By default, show a loading spinner.
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                  elevation: 5,
                                ),
                              ),
                            )
                          : Container(
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  Text("In order to see your activity score, please provide your GitHub username in profile.",
                                  style: GoogleFonts.ptSansNarrow(textStyle: TextStyle(fontSize: 16.0,)),
                                  textAlign: TextAlign.justify,),
                                  SizedBox(height: 8.0,),
                                  RaisedButton(
                                child: Text(
                                  'Go to Profile',
                                  style: GoogleFonts.ptSansNarrow(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      "/profile",
                                      ModalRoute.withName('/profile'));
                                },
                                textColor: Colors.white,
                                padding: EdgeInsets.fromLTRB(10, 18, 10, 18),
                                elevation: 5.0,
                                color: Colors.black,
                                splashColor: Colors.grey,
                              ),
                                ],
                              ),
                            )
                    ],
                  ),
                )
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

  void openProfileURL() async {
    var url = githubProfileURL;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void fetchGitHubUsername() async {
    final FirebaseUser user = await auth.getCurrentUser();
    final userId = user.uid;
    myRef =
        FirebaseDatabase.instance.reference().child('Profile').child(userId);
    myRef.once().then((DataSnapshot dataSnapshot) {
      setState(() {
        if (dataSnapshot.value != null) {
          githubUsername = dataSnapshot.value["github"];
        }
      });
    });
  }

  Future<GitHubProfile> fetchGitHubProfileDetails() async {
    final response =
        await http.get('https://api.github.com/users/' + githubUsername);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonData = json.decode(response.body);

      GitHubProfile gitHubProfile = GitHubProfile(
          jsonData["avatar_url"],
          jsonData["html_url"],
          jsonData["followers"],
          jsonData["following"],
          jsonData["name"],
          jsonData["blog"],
          jsonData["public_repos"]);
      githubProfileURL = jsonData["html_url"];
      return gitHubProfile;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
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
