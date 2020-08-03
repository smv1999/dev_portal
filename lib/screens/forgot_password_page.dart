import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import '../services/authentication.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  String email;
  Auth auth = new Auth();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Dev Portal',
              style: TextStyle(
                fontFamily: 'MyFont',
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Image.asset(
                      'images/dev.jpg',
                      height: 180,
                      width: 180,
                      alignment: Alignment.center,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                        maxLines: 1,
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (text) {
                          setState(() {
                            email = text;
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
                            hintText: 'Email', hintStyle: GoogleFonts.ptSansNarrow()),
                        textAlign: TextAlign.left,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                            fontSize: 16.0,
                            height: 1.4,
                            color: Colors.black,
                            fontFamily: 'MyFont')),
                    SizedBox(
                      height: 15.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        child: Text('Send Password Reset Email',
                        style: GoogleFonts.ptSansNarrow(textStyle: TextStyle(fontSize: 18)),
                        ),
                        onPressed: _sendPasswordResetEmail,
                        color: Colors.lightBlue,
                        splashColor: Colors.lightBlueAccent,
                        textColor: Colors.white,
                        padding: EdgeInsets.fromLTRB(10, 18, 10, 18),
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
  }

  void _sendPasswordResetEmail() {
    if (_formKey.currentState.validate()) {
      if (auth.sendPasswordResetEmail(email) != null) {
        Toast.show("Password reset email sent!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.of(context).pushNamed('/login');
      }
    }
  }
}
