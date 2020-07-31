import 'package:dev_portal/routes/route_generator.dart';
import 'package:dev_portal/screens/main.dart';
import 'package:flutter/material.dart';
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
//      theme: ThemeData(),
//      darkTheme: ThemeData.dark(),
//      themeMode: ThemeMode.dark,
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
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        seconds: 3,
        navigateAfterSeconds: new IntroScreenPage(),
        image: new Image.asset('images/dev_animated.gif'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.black,
        loadingText: Text('Community Portal for Developers'),
      ),
    ) ;
  }
}
