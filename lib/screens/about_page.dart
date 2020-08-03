import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'About Dev Portal',
          style: TextStyle(
            fontFamily: 'MyFont',
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body:Padding(
        padding: EdgeInsets.all(20.0),
        child:SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Dev Portal is a Community Portal for Developers. It is an initiative to bring the developers across the world to connect with each'
                ' other and creates an environment for learning and growing together.\n\n'
                'The salient features of this platform include: \n• Best Coding Practices and tips for writing cleaner code'
                '\n•  Best books for improving coding skills \n• Have fun and get inspired through Memes and Quotes'
                '\n•  Best Learning resources and YouTube Channels\n• Make use of the discussion forums and learn together\n\n'
                'Dev Portal provides you with all sorts of resources and facilities for improving your learning in '
                'the field of Software Development and also connect with fellow developers to encourage community learning.'
                ' Feel free to check out all the possibilities offered by our platform and bring to our notice'
                ' if you find any bug or have any suggestions for improvements!\n\n'
                'At your service, always!',textAlign: TextAlign.justify,
              style: GoogleFonts.ptSansNarrow(textStyle: TextStyle(
                  fontSize: 17.0
              ),)
            )
          ],
        ),
      ),
      ),
    );
  }
}
