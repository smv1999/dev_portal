import 'package:dev_portal/home_page.dart';
import 'package:dev_portal/services/authentication.dart';
import 'package:dev_portal/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';


class LoginPage extends StatefulWidget {
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyLoginPage(),
    );
  }
}

// Main Login Page
class MyLoginPage extends StatefulWidget {
  MyLoginPageState createState() => MyLoginPageState();
}

class MyLoginPageState extends State {
  String email, password;
  final _formKey = GlobalKey<FormState>();
  Auth auth = new Auth();
  bool _obscureText = true;

  // on-start
  @override
  void initState() {
    _checkIfUserAlreadyLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
                      alignment: Alignment.center, width: 200, height: 200),
                  SizedBox(height: 15.0),
                  TextFormField(
                      maxLines: 1,
                      validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                      onChanged: (text) {
                        setState(() {
                          email = text;
                        });
                      },
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.red, width: 1.0),
                              borderRadius: BorderRadius.circular(20.0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.blue, width: 1.0),
                              borderRadius: BorderRadius.circular(20.0)),
                          hintText: 'Email'),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                          fontSize: 16.0,
                          height: 1.4,
                          color: Colors.black,
                          fontFamily: 'Montserrat')),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    maxLines: 1,
                    validator: (val) => val.length < 6 ? 'Password must be at least 6 chars long' : null,
                    onChanged: (text) {
                      setState(() {
                        password = text;
                      });
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.blue, width: 1.0),
                            borderRadius: BorderRadius.circular(20.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.blue, width: 1.0),
                            borderRadius: BorderRadius.circular(20.0)),
                        hintText: 'Password',
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
                        Route route = MaterialPageRoute(builder: (context) => SignUpPage());
                        Navigator.pushReplacement(context, route);
                      },
                      child: Text("Don't have an Account? Sign Up"),
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

  void _computeResult() async {
    if(_formKey.currentState.validate())
    {
      if((await auth.signIn(email, password))!=null)
      {
        if((await auth.getCurrentUser())!=null)
          {
            if((await auth.isEmailVerified()) != null) {
              Toast.show("Login Successful!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
              Route route = MaterialPageRoute(builder: (context) => HomePage());
              Navigator.pushReplacement(context, route);
            }
          }
      }
      else{
        Toast.show("Authentication Failed!", context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      }
    }
  }
  Future<void> _checkIfUserAlreadyLoggedIn()
  async {
    if (await auth.getCurrentUser() != null)
    {
      // signed in
          Route route = MaterialPageRoute(builder: (context) => HomePage());
          Navigator.pushReplacement(context, route);
    }
    }
  }
