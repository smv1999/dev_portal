import 'dart:async';

import 'file:///C:/Users/smv1999/dev_portal/lib/screens/forgot_password_page.dart';
import 'package:dev_portal/home_page.dart';
import 'package:dev_portal/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'file:///C:/Users/smv1999/dev_portal/lib/screens/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

// Main Login Page
class MyLoginPage extends StatefulWidget {
  MyLoginPageState createState() => MyLoginPageState();
}

class MyLoginPageState extends State {
  String email, password;
  final _formKey = GlobalKey<FormState>();
  Auth auth = new Auth();
  bool _obscureText = true;
  ProgressDialog pr;
  bool isAuth;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    @override
    void initState(){
      super.initState();
    }

    return FutureBuilder<FirebaseUser>(
        future: FirebaseAuth.instance.currentUser(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.hasData) {
            FirebaseUser user = snapshot.data; // this is your user instance
            /// is because there is user already logged
            return MyHomePage();
          }

          /// other way there is no user logged.
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                'Dev Portal',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: Center(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Image.asset('images/dev.jpg',
                            alignment: Alignment.center,
                            width: 180,
                            height: 180),
                        SizedBox(height: 15.0),
                        TextFormField(
                            maxLines: 1,
                            validator: (val) =>
                            val.isEmpty
                                ? 'Enter an Email'
                                : null,
                            onChanged: (text) {
                              setState(() {
                                email = text;
                              });
                            },
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(20.0)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(20.0)
                                ),
                                hintText: 'Email'),
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                                fontSize: 16.0,
                                height: 1.4,
                                color: Colors.black,
                                fontFamily: 'Montserrat')
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          maxLines: 1,
                          validator: (val) =>
                          val.length < 6
                              ? 'Password must be at least 6 chars long'
                              : null,
                          onChanged: (text) {
                            setState(() {
                              password = text;
                            });
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(20.0)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                                borderRadius: BorderRadius.circular(20.0)),
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Theme
                                    .of(context)
                                    .primaryColorDark,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16.0,
                              height: 1.4,
                              color: Colors.black,
                              fontFamily: 'Montserrat'),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _obscureText,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            child: Text('LOGIN'),
                            onPressed: _computeResult,
                            color: Colors.black,
                            splashColor: Colors.grey,
                            textColor: Colors.white,
                            padding: EdgeInsets.fromLTRB(10, 18, 10, 18),
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0)),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  '/forgotpassword');
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Colors.lightBlue,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 18.0,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('/signup');
                            },
                            child: Text(
                              "Don't have an Account? Sign Up",
                              style: TextStyle(
                                color: Colors.lightBlue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  void _computeResult() async {
    if (_formKey.currentState.validate()) {
      if ((await auth.signIn(email, password)) != null) {
        if ((await auth.getCurrentUser()) != null) {
          if ((await auth.isEmailVerified()) != null) {
            Toast.show("Login Successful!", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            Navigator.of(context).pushNamed('/home');
          }
        }
      } else {
        Toast.show("Authentication Failed!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }
  }

  Future<void> _checkIfUserAlreadyLoggedIn() async {
    if (await auth.getCurrentUser() != null) {
      // signed in
        setState(() {
          isAuth = true;
        });
    }
    else {
      setState(() {
        isAuth = false;
      });
    }
  }

  void _showProgressDialog() {
      pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
      pr.style(
          message: 'Syncing please wait...',
          borderRadius: 6.0,
          backgroundColor: Colors.white,
          progressWidget: CircularProgressIndicator(),
          elevation: 10.0,
          insetAnimCurve: Curves.easeInOut,
          progress: 0.0,
          maxProgress: 100.0,
          progressTextStyle: TextStyle(
              color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
          messageTextStyle: TextStyle(
              color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
      );
      pr.show();
      _checkIfUserAlreadyLoggedIn();
  }
  void _dismissProgressDialog()
   {
    Future.delayed(Duration(seconds: 3)).then((value) {
      pr.hide();
    });
  }
}
