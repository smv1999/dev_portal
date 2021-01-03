import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConnectionError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: ListView(shrinkWrap: true, children: [
          Padding(
            padding: EdgeInsets.all(40),
            child: Image.network('https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/somethingwrong.png'),
          ),
          Center(
              child: Text(
            'Something went wrong!',
            style: GoogleFonts.ptSansNarrow(
                textStyle: TextStyle(fontSize: 20, color: Colors.black)),
          ))
        ]));
  }
}
