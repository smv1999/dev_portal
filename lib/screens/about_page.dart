import 'package:flutter/material.dart';


class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'About Dev Portal',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body:Padding(
        padding: EdgeInsets.all(20.0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Dev Portal is a Community Portal for Developers. It is an initiative to bring the developers across the world to connect with each'
                ' other and creates an environment for learning and growing together.\n'
                'The salient features of this platform include: \n• Best Coding Practices and tips for writing cleaner code'
                '\n• Best books for improving coding skills \n• Have fun and get inspired through Memes and Quotes '
                '\n• Best Learning resources and YouTube Channels \n• Make use of the discussion forums and learn together',textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16.0
              ),)
          ],
        ),
      )
    );
  }
}
