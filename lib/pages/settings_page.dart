import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 8.0,),
              Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                    title: Text('Share Our App'), leading: Icon(Icons.share)
                ),
              ),
              Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                    title: Text('Rate Our App'), leading: Icon(Icons.star)
                ),
              ),
              Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                    title: Text('Our Other Apps'), leading: Icon(Icons.apps),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                    title: Text('Contact Us'), leading: Icon(Icons.contact_mail)
                ),
              ),
              Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                    title: Text('Report an issue'), leading: Icon(Icons.bug_report)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
