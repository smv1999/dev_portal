import 'package:dev_portal/models/posts.dart';
import 'package:dev_portal/services/ProgressBar.dart';
import 'package:dev_portal/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyPosts extends StatefulWidget {
  @override
  _MyPostsState createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  ProgressBar _sendingMsgProgressBar;
  FirebaseStorage _storage = FirebaseStorage.instance;
  DatabaseReference myPostRef;
  Auth auth = new Auth();
  Future f;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    f = retrievePostData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushReplacementNamed('/home');
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0, // to remove the shadow effect
          backgroundColor: Colors.blue,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white), // for the back button
          title: Text(
            'My Posts',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'MyFont',
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
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
                                  padding: EdgeInsets.all(15.0),
                                  child: ListView(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    children: [
                                      ListTile(
                                        subtitle:
                                            Text(snapshot.data[index].datetime),
                                        title: Text(snapshot.data[index].name),
                                        leading: snapshot
                                                    .data[index].profileImage !=
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
                                              image: NetworkImage(snapshot
                                                  .data[index].postpath),
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
                                              textStyle:
                                                  TextStyle(fontSize: 15.0)))
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
        ),
      ),
    );
  }

  Future<List<Post>> retrievePostData() async {
    final FirebaseUser user = await auth.getCurrentUser();
    final userId = user.uid;
    List<Post> posts = [];
    myPostRef =
        FirebaseDatabase.instance.reference().child("Posts").child(userId);
    myPostRef.once().then((DataSnapshot dataSnapshot) {
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
    return posts;
  }
}
