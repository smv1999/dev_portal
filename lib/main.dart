import 'package:dev_portal/routes/route_generator.dart';
import 'package:dev_portal/screens/intro_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(SplashScreenPage());

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      home: new MySplash(),
      theme: ThemeData(fontFamily: 'MyFont', primaryColor: Colors.white),
    );
  }
}

class MySplash extends StatefulWidget {
  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SplashScreen(
        title: new Text(
          'Dev Portal',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              fontFamily: 'MyFont'),
        ),
        seconds: 3,
        navigateAfterSeconds: new IntroScreenPage(),
        image: new Image.network('https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/dev_animated.gif'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.blue,
        loadingText: Text(
          'Community Portal for Developers',
          style: GoogleFonts.ptSansNarrow(),
        ),
      ),
    );
  }
}
