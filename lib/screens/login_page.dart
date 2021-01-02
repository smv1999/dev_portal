import 'package:dev_portal/home_page.dart';
import 'package:dev_portal/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    @override
    void initState() {
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
              automaticallyImplyLeading: false,
              title: Text(
                'Login',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'MyFont'),
              ),
              centerTitle: true,
              backgroundColor: Colors.blue,
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
                                val.isEmpty ? 'Enter an Email' : null,
                            onChanged: (text) {
                              setState(() {
                                email = text;
                              });
                            },
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(20.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(20.0)),
                                hintText: 'Email',
                                hintStyle: GoogleFonts.ptSansNarrow()),
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                                fontSize: 16.0,
                                height: 1.4,
                                color: Colors.black,
                                fontFamily: 'MyFont')),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          maxLines: 1,
                          validator: (val) => val.length < 6
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
                            hintStyle: GoogleFonts.ptSansNarrow(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.blue,
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
                              fontFamily: 'MyFont'),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: _obscureText,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(fontSize: 18),
                            ),
                            onPressed: _computeResult,
                            color: Colors.blue,
                            splashColor: Colors.blueAccent,
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
                              Navigator.of(context)
                                  .pushNamed('/forgotpassword');
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black54,
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
                                  fontSize: 18,
                                  color: Colors.black54,
                                  fontFamily: 'MyFont'),
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
        });
  }

  void _computeResult() async {
    if (_formKey.currentState.validate()) {
      if ((await auth.signIn(email, password)) != null) {
        if ((await auth.getCurrentUser()) != null) {
          Toast.show("Login Successful!", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          Navigator.of(context).pushNamedAndRemoveUntil('/home', (r) => false);
        }
        else {
        Navigator.of(context).pushNamed('/connectionerror');
      }
      } 
    }
  }
}
