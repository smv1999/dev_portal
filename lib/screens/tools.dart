import 'dart:io';

import 'package:dev_portal/models/github_profile.dart';
import 'package:dev_portal/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_extend/share_extend.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';

class Tools extends StatefulWidget {
  @override
  _ToolsState createState() => _ToolsState();
}

class _ToolsState extends State<Tools> {
  SharedPreferences prefs;
  bool _seen;
  DatabaseReference myRef;
  Auth auth = new Auth();
  String githubUsername = "smv1999";
  String githubProfileURL = "https://github.com/harshcasper";
  Future f;

  String pathPDF = "";

  void initState() {
    super.initState();
    fetchGitHubUsername();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkTipSeen();
    });
    f = fetchGitHubProfileDetails();
  }

  showRegEx1(BuildContext context) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 200.0,
        width: 350.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Text(
                  'Password Validation',
                  style: GoogleFonts.ptSansNarrow(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Center(
                  child: Text(
                '(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s)(?=.*[!@#\$*])',
                style: TextStyle(fontSize: 16.0),textAlign: TextAlign.justify,
              )),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                      child: Text(
                        'Copy to Clipboard',
                        style: GoogleFonts.ptSansNarrow(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0)),
                      ),
                      onPressed: () {
                        // Copy operation
                        Clipboard.setData(new ClipboardData(
                            text:
                                "(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s)(?=.*[!@#\$*])"));
                        Toast.show("Copied to Clipboard Successfully!", context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      },
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                      elevation: 5.0,
                      color: Colors.blue,
                      splashColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0))),
                  RaisedButton(
                      child: Text(
                        'Next',
                        style: GoogleFonts.ptSansNarrow(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0)),
                      ),
                      onPressed: () {
                        // Next Dialog
                        Navigator.pop(context);
                        showRegEx2(context);
                      },
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                      elevation: 5.0,
                      color: Colors.blue,
                      splashColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)))
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

  showRegEx2(BuildContext context) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 200.0,
        width: 320.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Text(
                  'Email Validation',
                  style: GoogleFonts.ptSansNarrow(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                  )
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text(
                  '^[^@ ]+@[^@ ]+\.[^@ \.]{2,}\$',
                  style: TextStyle(fontSize: 16.0),textAlign: TextAlign.justify
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                      child: Text(
                        'Copy to Clipboard',
                        style: GoogleFonts.ptSansNarrow(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0)),
                      ),
                      onPressed: () {
                        // Copy operation
                        Clipboard.setData(new ClipboardData(
                            text: "^[^@ ]+@[^@ ]+\.[^@ \.]{2,}\$"));
                        Toast.show("Copied to Clipboard Successfully!", context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      },
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                      elevation: 5.0,
                      color: Colors.blue,
                      splashColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0))),
                  RaisedButton(
                      child: Text(
                        'Next',
                        style: GoogleFonts.ptSansNarrow(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0)),
                      ),
                      onPressed: () {
                        // Next Dialog
                        Navigator.pop(context);

                        showRegEx3(context);
                      },
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                      elevation: 5.0,
                      color: Colors.blue,
                      splashColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)))
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

  showRegEx3(BuildContext context) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 200.0,
        width: 320.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Text(
                  'Date Validation',
                  style: GoogleFonts.ptSansNarrow(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                  )
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text(
                  '\d{4}-\d{2}-\d{2}',
                  style: TextStyle(fontSize: 16.0),textAlign: TextAlign.justify
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                      child: Text(
                        'Copy to Clipboard',
                        style: GoogleFonts.ptSansNarrow(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0)),
                      ),
                      onPressed: () {
                        // Copy operation
                        Clipboard.setData(
                            new ClipboardData(text: "\d{4}-\d{2}-\d{2}"));
                        Toast.show("Copied to Clipboard Successfully!", context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      },
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                      elevation: 5.0,
                      color: Colors.blue,
                      splashColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0))),
                  RaisedButton(
                      child: Text(
                        'Next',
                        style: GoogleFonts.ptSansNarrow(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0)),
                      ),
                      onPressed: () {
                        // Next Dialog
                        Navigator.pop(context);

                        showRegEx4(context);
                      },
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                      elevation: 5.0,
                      color: Colors.blue,
                      splashColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)))
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

  showRegEx4(BuildContext context) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 200.0,
        width: 320.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Text(
                  'Mastercard Validation',
                  style: GoogleFonts.ptSansNarrow(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Center( 
              child:Text(
                '^(?:5[1–5][0–9]{2}|222[1–9]|22[3–9][0–9]|2[3–6][0–9]{2}|27[01][0–9]|2720)[0–9]{12}\$',
                style: TextStyle(fontSize: 16.0),textAlign: TextAlign.justify
              ),),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                      child: Text(
                        'Copy to Clipboard',
                        style: GoogleFonts.ptSansNarrow(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0)),
                      ),
                      onPressed: () {
                        // Copy operation
                        Clipboard.setData(new ClipboardData(
                            text:
                                "^(?:5[1–5][0–9]{2}|222[1–9]|22[3–9][0–9]|2[3–6][0–9]{2}|27[01][0–9]|2720)[0–9]{12}\$"));
                        Toast.show("Copied to Clipboard Successfully!", context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      },
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                      elevation: 5.0,
                      color: Colors.blue,
                      splashColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0))),
                  RaisedButton(
                      child: Text(
                        'Next',
                        style: GoogleFonts.ptSansNarrow(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0)),
                      ),
                      onPressed: () {
                        // Next Dialog
                        Navigator.pop(context);

                        showRegEx5(context);
                      },
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                      elevation: 5.0,
                      color: Colors.blue,
                      splashColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)))
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

  showRegEx5(BuildContext context) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 200.0,
        width: 320.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Text(
                  'Visa card Validation',
                  style: GoogleFonts.ptSansNarrow(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text(
                  '^4[0–9]{12}(?:[0–9]{3})?\$',
                  style: TextStyle(fontSize: 16.0),textAlign: TextAlign.justify
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                      child: Text(
                        'Copy to Clipboard',
                        style: GoogleFonts.ptSansNarrow(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0)),
                      ),
                      onPressed: () {
                        // Copy operation
                        Clipboard.setData(new ClipboardData(
                            text: "^4[0–9]{12}(?:[0–9]{3})?\$"));
                        Toast.show("Copied to Clipboard Successfully!", context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      },
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                      elevation: 5.0,
                      color: Colors.blue,
                      splashColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0))),
                  RaisedButton(
                      child: Text(
                        'Next',
                        style: GoogleFonts.ptSansNarrow(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0)),
                      ),
                      onPressed: () {
                        // Next Dialog
                        Navigator.pop(context);

                        showRegEx6(context);
                      },
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                      elevation: 5.0,
                      color: Colors.blue,
                      splashColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)))
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

  showRegEx6(BuildContext context) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 200.0,
        width: 320.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Text(
                  'IPv4 Address Validation',
                  style: GoogleFonts.ptSansNarrow(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text(
                  '^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\$',
                  style: TextStyle(fontSize: 16.0),textAlign: TextAlign.justify
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                      child: Text(
                        'Copy to Clipboard',
                        style: GoogleFonts.ptSansNarrow(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0)),
                      ),
                      onPressed: () {
                        // Copy operation
                        Clipboard.setData(new ClipboardData(
                            text:
                                "^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\$"));
                        Toast.show("Copied to Clipboard Successfully!", context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      },
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                      elevation: 5.0,
                      color: Colors.blue,
                      splashColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0))),
                  RaisedButton(
                      child: Text(
                        'Next',
                        style: GoogleFonts.ptSansNarrow(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0)),
                      ),
                      onPressed: () {
                        // Next Dialog
                        Navigator.pop(context);

                        showRegEx7(context);
                      },
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                      elevation: 5.0,
                      color: Colors.blue,
                      splashColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)))
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

  showRegEx7(BuildContext context) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 200.0,
        width: 320.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Text(
                  'JSON Validation & Parsing',
                  style: GoogleFonts.ptSansNarrow(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text(
                  '(?(DEFINE)(?<json>(?>\s*(?&object)\s*|\s*(?&array)\s*))(?<object>(?>\{\s*(?>(?&pair)(?>\s*,\s*(?&pair))*)?\s*\}))(?<pair>(?>(?&STRING)\s*:\s*(?&value)))(?<array>(?>\[\s*(?>(?&value)(?>\s*,\s*(?&value))*)?\s*\]))(?<value>(?>true|false|null|(?&STRING)|(?&NUMBER)|(?&object)|(?&array)))(?<STRING>(?>"(?>\\(?>["\\\/bfnrt]|u[a-fA-F0-9]{4})|[^"\\\0-\x1F\x7F]+)*"))(?<NUMBER>(?>-?(?>0|[1-9][0-9]*)(?>\.[0-9]+)?(?>[eE][+-]?[0-9]+)?)))\A(?&json)\z',
                  style: TextStyle(fontSize: 16.0),textAlign: TextAlign.justify
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                      child: Text(
                        'Copy to Clipboard',
                        style: GoogleFonts.ptSansNarrow(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0)),
                      ),
                      onPressed: () {
                        // Copy operation
                        Clipboard.setData(new ClipboardData(
                            text:
                                '(?(DEFINE)(?<json>(?>\s*(?&object)\s*|\s*(?&array)\s*))(?<object>(?>\{\s*(?>(?&pair)(?>\s*,\s*(?&pair))*)?\s*\}))(?<pair>(?>(?&STRING)\s*:\s*(?&value)))(?<array>(?>\[\s*(?>(?&value)(?>\s*,\s*(?&value))*)?\s*\]))(?<value>(?>true|false|null|(?&STRING)|(?&NUMBER)|(?&object)|(?&array)))(?<STRING>(?>"(?>\\(?>["\\\/bfnrt]|u[a-fA-F0-9]{4})|[^"\\\0-\x1F\x7F]+)*"))(?<NUMBER>(?>-?(?>0|[1-9][0-9]*)(?>\.[0-9]+)?(?>[eE][+-]?[0-9]+)?)))\A(?&json)\z'));
                        Toast.show("Copied to Clipboard Successfully!", context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      },
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                      elevation: 5.0,
                      color: Colors.blue,
                      splashColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0))),
                  RaisedButton(
                      child: Text(
                        'Next',
                        style: GoogleFonts.ptSansNarrow(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0)),
                      ),
                      onPressed: () {
                        // Next Dialog
                        Navigator.pop(context);

                        showRegEx8(context);
                      },
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                      elevation: 5.0,
                      color: Colors.blue,
                      splashColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)))
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

  showRegEx8(BuildContext context) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 200.0,
        width: 350.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Text(
                  'CSV Validation',
                  style: GoogleFonts.ptSansNarrow(
                    textStyle:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text(
                  '(?:\s*(?:\"([^\"]*)\"|([^,]+))\s*,?)+?',
                  style: TextStyle(fontSize: 16.0),textAlign: TextAlign.justify
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                      child: Text(
                        'Copy to Clipboard',
                        style: GoogleFonts.ptSansNarrow(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0)),
                      ),
                      onPressed: () {
                        // Copy operation
                        Clipboard.setData(new ClipboardData(
                            text: "(?:\s*(?:\"([^\"]*)\"|([^,]+))\s*,?)+?"));
                        Toast.show("Copied to Clipboard Successfully!", context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      },
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                      elevation: 5.0,
                      color: Colors.blue,
                      splashColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0))),
                  RaisedButton(
                      child: Text(
                        'Done',
                        style: GoogleFonts.ptSansNarrow(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0)),
                      ),
                      onPressed: () {
                        // Next Dialog
                        Navigator.pop(context);
                      },
                      textColor: Colors.white,
                      padding: EdgeInsets.fromLTRB(10, 12, 10, 12),
                      elevation: 5.0,
                      color: Colors.blue,
                      splashColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)))
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

  Future<File> createFileOfPdfUrl(String pdfURL) async {
    var url = pdfURL;
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.of(context).pushNamedAndRemoveUntil('/home', (_) => false);
        },
        child: Scaffold(
          // Create a grid layout of the dashboard items
          appBar: AppBar(
            elevation: 0,
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
            child: Padding(
                padding: EdgeInsets.all(15.0),
                child: ListView(shrinkWrap: true, children: <Widget>[
                  SizedBox(
                    height: 15.0,
                  ),
                  Center(
                    child: Text(
                      'Tools',
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
                                child: Image.network(
                                    'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/productivity.png'),
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
                                child: Image.network(
                                    'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/projects.jpg'),
                                elevation: 5,
                              ),
                            ),
                            GestureDetector(
                              onLongPress: () {
                                showFloatingFlushbar(context, 'ASCII Chart');
                              },
                              onTap: () {
                                // Open PDF
                                createFileOfPdfUrl(
                                        "http://smv1999.github.io/ASCII_CHART.pdf")
                                    .then((f) {
                                  setState(() {
                                    pathPDF = f.path;
                                  });
                                }).then((_) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PDFScreen(pathPDF, "ASCII Chart")),
                                  );
                                });
                              },
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                child: Image.network(
                                    'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/chart.jpg'),
                                elevation: 5,
                              ),
                            ),
                            GestureDetector(
                              onLongPress: () {
                                showFloatingFlushbar(
                                    context, 'RegEx Templates');
                              },
                              onTap: () {
                                showRegEx1(context);
                              },
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                child: Image.network(
                                    'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/regex.jpg'),
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
                  )
                ])),
          ),
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
                    Image.network(
                      'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/getting_started.png',
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

class PDFScreen extends StatelessWidget {
  String pathPDF = "";
  String docName = "";
  PDFScreen(this.pathPDF, this.docName);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(this.docName,
              style: TextStyle(
                color: Colors.white,
              )),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                // Share the PDF via other apps
                ShareExtend.share(this.pathPDF, "file");
              },
            ),
          ],
          actionsIconTheme: IconThemeData(color: Colors.white),
        ),
        path: pathPDF);
  }
}
