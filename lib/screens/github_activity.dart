import 'package:dev_portal/models/github_profile.dart';
import 'package:dev_portal/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class GitHubActivity extends StatefulWidget {
  @override
  _GitHubActivityState createState() => _GitHubActivityState();
}

class _GitHubActivityState extends State<GitHubActivity> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Future f;
  String githubUsername = "smv1999";
  String githubProfileURL = "https://github.com/smv1999";
  DatabaseReference myRef;
  Auth auth = new Auth();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchGitHubUsername();
    f = fetchGitHubProfileDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: Text(
          'GitHub Activity Score',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'MyFont',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                showCustomDialog(context);
              },
              child: Icon(
                Icons.info,
              ),
            ),
          )
        ],
        actionsIconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        child: ListView(
          children: [
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
                                        child:
                                        CircleAvatar(
                                          backgroundColor:
                                          Colors.black,
                                          radius: 50.0,
                                          child:
                                          CircleAvatar(
                                            radius: 48.0,
                                            backgroundImage:
                                            new NetworkImage(
                                                'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/programming.jpg'),
                                            backgroundColor:
                                            Colors
                                                .black,
                                          ),
                                        ))
                                        : InkWell(
                                        child:
                                        CircleAvatar(
                                          backgroundColor:
                                          Colors.black,
                                          radius: 50.0,
                                          child:
                                          CircleAvatar(
                                            radius: 48.0,
                                            backgroundImage:
                                            new NetworkImage(
                                                snapshot
                                                    .data
                                                    .profileImage),
                                            backgroundColor:
                                            Colors
                                                .white,
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
                                          RichText(
                                            textAlign:
                                            TextAlign
                                                .center,
                                            text:
                                            new TextSpan(
                                              children: <
                                                  TextSpan>[
                                                new TextSpan(
                                                    text:
                                                    'Followers: ',
                                                    style: TextStyle(
                                                        fontSize:
                                                        11.0,
                                                        color: Colors
                                                            .black,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                                new TextSpan(
                                                  text: (snapshot
                                                      .data
                                                      .followers
                                                      .toString()),
                                                  style:
                                                  new TextStyle(
                                                    fontSize:
                                                    11.0,
                                                    color: Colors
                                                        .black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8.0,
                                          ),
                                          RichText(
                                            textAlign:
                                            TextAlign
                                                .center,
                                            text:
                                            new TextSpan(
                                              children: <
                                                  TextSpan>[
                                                new TextSpan(
                                                    text:
                                                    'Following: ',
                                                    style: TextStyle(
                                                        fontSize:
                                                        11.0,
                                                        color: Colors
                                                            .black,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                                new TextSpan(
                                                  text: (snapshot
                                                      .data
                                                      .following
                                                      .toString()),
                                                  style:
                                                  new TextStyle(
                                                    fontSize:
                                                    11.0,
                                                    color: Colors
                                                        .black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          RichText(
                                            textAlign:
                                            TextAlign
                                                .center,
                                            text:
                                            new TextSpan(
                                              children: <
                                                  TextSpan>[
                                                new TextSpan(
                                                    text:
                                                    'Public Repos: ',
                                                    style: TextStyle(
                                                        fontSize:
                                                        11.0,
                                                        color: Colors
                                                            .black,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                                new TextSpan(
                                                  text: (snapshot
                                                      .data
                                                      .publicRepos
                                                      .toString()),
                                                  style:
                                                  new TextStyle(
                                                    fontSize:
                                                    11.0,
                                                    color: Colors
                                                        .black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8.0,
                                          ),
                                          RichText(
                                            textAlign:
                                            TextAlign
                                                .center,
                                            text:
                                            new TextSpan(
                                              children: <
                                                  TextSpan>[
                                                new TextSpan(
                                                    text:
                                                    'Blog: ',
                                                    style: TextStyle(
                                                        fontSize:
                                                        11.0,
                                                        color: Colors
                                                            .black,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                                new TextSpan(
                                                  text: (snapshot
                                                      .data
                                                      .blog),
                                                  style:
                                                  new TextStyle(
                                                    fontSize:
                                                    11.0,
                                                    color: Colors
                                                        .black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  RichText(
                                    textAlign:
                                    TextAlign.center,
                                    text: new TextSpan(
                                      children: <TextSpan>[
                                        new TextSpan(
                                            text:
                                            'Your Score: ',
                                            style: TextStyle(
                                                fontSize:
                                                14.0,
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
                                          style:
                                          new TextStyle(
                                            fontSize: 14.0,
                                            color:
                                            Colors.black,
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
                            child:
                            CircularProgressIndicator(),
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
                  Text(
                    "In order to see your activity score, please provide your GitHub username in profile.",
                    style: GoogleFonts.ptSansNarrow(
                        textStyle: TextStyle(
                          fontSize: 16.0,
                        )),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
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
                    padding:
                    EdgeInsets.fromLTRB(10, 18, 10, 18),
                    elevation: 5.0,
                    color: Colors.black,
                    splashColor: Colors.grey,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
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
  showCustomDialog(BuildContext context) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 250.0,
        width: 280.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              InkWell(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50.0,
                    child: CircleAvatar(
                      radius: 48.0,
                      backgroundImage: new NetworkImage(
                          'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/github.png'),
                      backgroundColor: Colors.white,
                    ),
                  )),
              SizedBox(
                height: 15.0,
              ),
              Column(
                children: [
                  Text(
                    'Followers : 1 point',
                    style: GoogleFonts.ptSansNarrow(
                        textStyle: TextStyle(fontSize: 17)),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Public Repos : 2 points',
                    style: GoogleFonts.ptSansNarrow(
                        textStyle: TextStyle(fontSize: 17)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) => errorDialog,
        barrierDismissible: true);
  }
}
