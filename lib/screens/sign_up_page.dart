import 'package:dev_portal/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

// Main Register Page
class MyRegisterPage extends StatefulWidget {
  MyRegisterPageState createState() => MyRegisterPageState();
}

class MyRegisterPageState extends State {
  String email, password;
  final _formKey = GlobalKey<FormState>();
  Auth auth = new Auth();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Dev Portal',
          style: TextStyle(color: Colors.black,
          fontFamily: 'MyFont',
          fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Image.asset('images/dev.jpg',
                      alignment: Alignment.center, width: 180, height: 180),
                  SizedBox(height: 15.0),
                  TextFormField(
                      validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                      onChanged: (text) {
                        setState(() {
                          email = text;
                        });
                      },
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(32.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(32.0)),
                          hintText: 'Email', hintStyle: GoogleFonts.ptSansNarrow()),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                          fontSize: 16.0,
                          height: 1.2,
                          color: Colors.black,
                          fontFamily: 'MyFont')),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
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
                            borderRadius: BorderRadius.circular(32.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(32.0)),
                        hintText: 'Password', hintStyle: GoogleFonts.ptSansNarrow(),
                      suffixIcon: IconButton(
                    icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _obscureText
                    ? Icons.visibility
                      : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
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
                        height: 1.2,
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
                      child: Text('REGISTER', style: GoogleFonts.ptSansNarrow(textStyle: TextStyle(fontSize: 18)),),
                      onPressed: _computeResult,
                      color: Colors.lightBlue,
                      splashColor: Colors.lightBlueAccent,
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 18, 10, 18),
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                      child: Text("Already have an Account? Log In",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.lightBlue,
                          fontFamily: 'MyFont'
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

  void _computeResult() {
    if (_formKey.currentState.validate()) {
      if (auth.signUp(email, password) != null) {
        // show toast of email verification sent
        Toast.show("Email Verification Sent. Check your Inbox", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.of(context).pushReplacementNamed('/login');
      }
      else{
        Toast.show("Something went wrong!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      }
    }
  }
}
