import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
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
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black), // for the back button
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        color: Colors.white70,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 8.0,),
              Image.asset('images/dev.jpg',
                  alignment: Alignment.center,
                  width: 180,
                  height: 180),
              SizedBox(height: 8.0,),
              Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                    onTap: _about,
                    title: Text('About Dev Portal'), leading: Icon(Icons.info)
                ),
              ),
              Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                    title: Text('Switch to Dark Mode'),
                    trailing:  Switch(
                      value: isSwitched,
                      onChanged: (value){
                        setState(() {
                          isSwitched = value;
                          print(isSwitched);
                        });
                      },
                      activeTrackColor: Colors.black54,
                      activeColor: Colors.white70,
                    ),
                  leading: Icon(Icons.compare_arrows),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                    onTap: _shareApp,
                    title: Text('Share Our App'), leading: Icon(Icons.share)
                ),
              ),
              Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                    onTap: _rateOurApp,
                    title: Text('Rate Our App'), leading: Icon(Icons.star)
                ),
              ),
              Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                    onTap: _ourOtherApps,
                    title: Text('Our Other Apps'), leading: Icon(Icons.apps),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                    onTap: privacyPolicy,
                    title: Text('Privacy Policy'), leading: Icon(Icons.security)
                ),
              ),
              Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                    onTap: _sendEmail,
                    title: Text('Contact Us'), leading: Icon(Icons.contact_mail)
                ),
              ),
              Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                    onTap: _reportIssue,
                    title: Text('Report an issue'), leading: Icon(Icons.bug_report)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  privacyPolicy()  {
    Navigator.of(context).pushNamed('/policy');
  }
  void _shareApp()  {
    final RenderBox box = context.findRenderObject();

    Share.share('Check out the app here: https://play.google.com/store/apps/details?id=com.programmersgateway.sm1999.dev_portal',
        subject: 'A Community Portal for Developers',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
  void _rateOurApp() async{
    const url = 'https://play.google.com/store/apps/details?id=com.programmersgateway.sm1999.dev_portal';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _ourOtherApps() async
  {
    const url = 'https://play.google.com/store/apps/developer?id=Programmers+Gateway';
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

  void _reportIssue() async{
    final Email email = Email(
      body: 'I would like to bring the following about Dev Portal to your notice:',
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
