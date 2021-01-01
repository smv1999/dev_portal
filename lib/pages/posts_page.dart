import 'dart:io';
import 'package:dev_portal/services/ProgressBar.dart';
import 'package:dev_portal/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:dev_portal/models/posts.dart';

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  Auth auth = new Auth();
  FirebaseStorage _storage = FirebaseStorage.instance;
  DatabaseReference myfollowingRef, myPeopleRef, postsRef;
  Future f;
  ProgressBar _sendingMsgProgressBar;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sendingMsgProgressBar = ProgressBar();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add Your Code here.
      showSendingProgressBar();
    });
    f = retrievePostsData();
  }

  @override
  void dispose() {
    _sendingMsgProgressBar.hide();
    super.dispose();
  }

  void showSendingProgressBar() {
    _sendingMsgProgressBar.show(context);
  }

  void hideSendingProgressBar() {
    _sendingMsgProgressBar.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 20.0,
          ),
          FutureBuilder(
              future: f,
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  if (snapshot.data.length != 0) {
                    return ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.all(8.0),
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: ListView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  ListTile(
                                    subtitle:
                                        Text(snapshot.data[index].datetime),
                                    title: Text(snapshot.data[index].name),
                                    leading:
                                        snapshot.data[index].profileImage !=
                                                null
                                            ? InkWell(
                                                child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 30.0,
                                                child: CircleAvatar(
                                                  radius: 28.0,
                                                  backgroundImage:
                                                      new NetworkImage(snapshot
                                                          .data[index]
                                                          .profileImage),
                                                  backgroundColor: Colors.white,
                                                ),
                                              ))
                                            : InkWell(
                                                child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 30.0,
                                                child: CircleAvatar(
                                                  radius: 28.0,
                                                  backgroundImage: AssetImage(
                                                      'images/newimage.png'),
                                                  backgroundColor: Colors.white,
                                                ),
                                              )),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    height: 230.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              snapshot.data[index].postpath),
                                          fit: BoxFit.contain),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 3.0,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(snapshot.data[index].description,
                                      style: GoogleFonts.ptSansNarrow(
                                          textStyle: TextStyle(fontSize: 15.0)))
                                ],
                              ),
                            ),
                          );
                        });
                  }
                  return Container(
                    child: Image.asset('images/data_not_found.png'),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Container();
              }),
        ],
      ),
    );
  }

  Future<List<Post>> retrievePostsData() async {
    final FirebaseUser user = await auth.getCurrentUser();
    final userId = user.uid;
    myfollowingRef = FirebaseDatabase.instance
        .reference()
        .child('Follow')
        .child(userId)
        .child('following');

    List<Post> posts = [];
    myfollowingRef.once().then((DataSnapshot dataSnapshot) {
      setState(() {
        if (dataSnapshot.value != null) {
          for (var snapshot in dataSnapshot.value.values) {
            myPeopleRef =
                FirebaseDatabase.instance.reference().child('Profile');
            myPeopleRef.once().then((DataSnapshot dataSnapshot) {
              for (var snap in dataSnapshot.value.values) {
                if (snap["username"] == snapshot["userid"]) {
                  var addFollowerUserId = dataSnapshot.value.keys.firstWhere(
                      (k) => dataSnapshot.value[k] == snap,
                      orElse: () => null);
                  postsRef = FirebaseDatabase.instance
                      .reference()
                      .child("Posts")
                      .child(addFollowerUserId);
                  postsRef.once().then((DataSnapshot dataSnapshot) {
                    setState(() {
                      if (dataSnapshot.value != null) {
                        for (var snapshot in dataSnapshot.value.values) {
                          Post task = Post(
                              snapshot["datetime"],
                              snapshot["description"],
                              snapshot["name"],
                              snapshot["postpath"],
                              snapshot["publisher"],
                              snapshot["profileimage"]);

                          posts.add(task);
                        }
                      }
                      return posts;
                    });
                  });
                }
              }
            });
          }
        }
      });
    });
    setState(() {
      hideSendingProgressBar();
    });
    return posts;
  }
}
