import 'dart:io';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_extend/share_extend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';

class Tools extends StatefulWidget {
  @override
  _ToolsState createState() => _ToolsState();
}

class _ToolsState extends State<Tools> {
  SharedPreferences prefs;
  bool _seen;
  String pathPDF = "";

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkTipSeen();
    });
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
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.justify,
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
                child: Text('Email Validation',
                    style: GoogleFonts.ptSansNarrow(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.0),
                    )),
              ),
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text('^[^@ ]+@[^@ ]+\.[^@ \.]{2,}\$',
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.justify),
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
                child: Text('Date Validation',
                    style: GoogleFonts.ptSansNarrow(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.0),
                    )),
              ),
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text('\d{4}-\d{2}-\d{2}',
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.justify),
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
                child: Text(
                    '^(?:5[1–5][0–9]{2}|222[1–9]|22[3–9][0–9]|2[3–6][0–9]{2}|27[01][0–9]|2720)[0–9]{12}\$',
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.justify),
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
                child: Text('^4[0–9]{12}(?:[0–9]{3})?\$',
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.justify),
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
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.justify),
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
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.justify),
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
                child: Text('(?:\s*(?:\"([^\"]*)\"|([^,]+))\s*,?)+?',
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.justify),
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
          return;
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
                            GestureDetector(
                              onLongPress: () {
                                showFloatingFlushbar(
                                    context, 'Jargons Dictionary');
                              },
                              onTap: () {
                                Navigator.of(context).pushNamed('/jargonsdictionary');

                              },
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                child: Image.network(
                                    'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/dictionary.jpg'),
                                elevation: 5,
                              ),
                            ),
                            GestureDetector(
                              onLongPress: () {
                                showFloatingFlushbar(
                                    context, 'GitHub Activity Score');
                              },
                              onTap: () {
                                Navigator.of(context).pushNamed('/githubactivity');
                              },
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                child: Image.network(
                                    'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/github.png'),
                                elevation: 5,
                              ),
                            )
                          ],
                        ),
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
