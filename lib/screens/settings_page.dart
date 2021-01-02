import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // to remove the shadow effect
        backgroundColor: Colors.blue,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white), // for the back button
        title: Text(
          'Settings',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'MyFont',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Colors.white70,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 8.0,
              ),
              Image.asset('images/dev.jpg',
                  alignment: Alignment.center, width: 180, height: 180),
              SizedBox(
                height: 8.0,
              ),
              Text(
                'Made in India',
                textAlign: TextAlign.center,
                style: GoogleFonts.ptSansNarrow(
                    textStyle: TextStyle(fontSize: 20.0)),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                'Version 1.0.0',
                textAlign: TextAlign.center,
                style: GoogleFonts.ptSansNarrow(
                    textStyle: TextStyle(fontSize: 12.0)),
              ),
              Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: _about,
                  title: Text(
                    'About Dev Portal',
                    style: GoogleFonts.ptSansNarrow(),
                  ),
                  leading: Icon(
                    Icons.info,
                    color: Colors.blue,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                ),
              ),
              // Card(
              //   margin: const EdgeInsets.all(8.0),
              //   child: ListTile(
              //       title: Text('Switch to Dark Mode',
              //       style: GoogleFonts.ptSansNarrow(),
              //       ),
              //       trailing:  Switch(
              //         value: isSwitched,
              //         onChanged: (value){
              //           setState(() {
              //             isSwitched = value;
              //             print(isSwitched);
              //           });
              //         },
              //         activeTrackColor: Colors.black, // black54
              //         activeColor: Colors.grey,
              //       ),
              //     leading: Icon(Icons.compare_arrows, color: Colors.black),
              //   ),
              // ),
              Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: _shareApp,
                  title: Text(
                    'Share Our App',
                    style: GoogleFonts.ptSansNarrow(),
                  ),
                  leading: Icon(
                    Icons.share,
                    color: Colors.blue,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: _rateOurApp,
                  title: Text(
                    'Rate Our App',
                    style: GoogleFonts.ptSansNarrow(),
                  ),
                  leading: Icon(
                    Icons.star,
                    color: Colors.blue,
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: _ourOtherApps,
                  title: Text(
                    'Our Other Apps',
                    style: GoogleFonts.ptSansNarrow(),
                  ),
                  leading: Icon(
                    Icons.apps,
                    color: Colors.blue,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: privacyPolicy,
                  title: Text(
                    'Privacy Policy',
                    style: GoogleFonts.ptSansNarrow(),
                  ),
                  leading: Icon(
                    Icons.security,
                    color: Colors.blue,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: _sendEmail,
                  title: Text(
                    'Contact Us',
                    style: GoogleFonts.ptSansNarrow(),
                  ),
                  leading: Icon(
                    Icons.contact_mail,
                    color: Colors.blue,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: _reportIssue,
                  title: Text(
                    'Report an issue',
                    style: GoogleFonts.ptSansNarrow(),
                  ),
                  leading: Icon(
                    Icons.bug_report,
                    color: Colors.blue,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Center(
                  child: Text(
                'from',
                style: GoogleFonts.ptSansNarrow(),
              )),
              Center(
                child: Text(
                  "Programmers Gateway",
                  style: TextStyle(fontSize: 25.0, fontFamily: "MyFont"),
                ),
              ),
              SizedBox(
                height: 10.0,
              )
            ],
          ),
        ),
      ),
    );
  }

  privacyPolicy() {
    Navigator.of(context).pushNamed('/policy');
  }

  void _shareApp() {
    final RenderBox box = context.findRenderObject();

    Share.share(
        'Check out the app here: https://play.google.com/store/apps/details?id=com.programmersgateway.sm1999.dev_portal',
        subject: 'A Community Portal for Developers',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  void _rateOurApp() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.programmersgateway.sm1999.dev_portal';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _ourOtherApps() async {
    const url =
        'https://play.google.com/store/apps/developer?id=Programmers+Gateway';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _sendEmail() async {
    final Email email = Email(
      recipients: ['devteamprogrammersgateway@gmail.com'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  void _reportIssue() async {
    final Email email = Email(
      body:
          'I would like to bring the following about Dev Portal to your notice:',
      subject: 'Issue Report - Dev Portal',
      recipients: ['devteamprogrammersgateway@gmail.com'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  _about() {
    Navigator.of(context).pushNamed('/about');
  }
}
