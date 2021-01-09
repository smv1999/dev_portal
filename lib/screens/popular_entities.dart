import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Popular extends StatefulWidget {
  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  SharedPreferences prefs;
  bool _seen;
  Map<String, double> langs = {
    "Python": 40,
    "Java": 25,
    "JavaScript": 15,
    "C#": 10,
    "PHP": 5,
    "C/C++": 5
  };
  Map<String, double> ides = {
    "Visual Studio": 30,
    "Eclipse": 25,
    "Android Studio": 15,
    "VS Code": 15,
    "pyCharm": 10,
    "IntelliJ": 5
  };

  Map<String, double> databases = {
    "Oracle": 30,
    "MySQL": 20,
    "SQL Server": 15,
    "MS Access": 15,
    "PostgreSQL": 10,
    "MongoDB": 10
  };

  List<Color> colorList = [
    Colors.blueAccent,
    Colors.blue,
    Colors.blueGrey,
    Colors.lightBlue,
    Colors.lightBlueAccent,
    Colors.cyan
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add Your Code here.
      checkTipSeen();
    });
  }

    Future checkTipSeen() async {
    prefs = await SharedPreferences.getInstance();
    _seen = (prefs.getBool('ratingseen') ?? false);
    if (!_seen) {
      showRatingDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue,
          title: Text(
            'Dev Portal',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'MyFont',
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Container(
            child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Popularity of Programming Languages',
              style: GoogleFonts.ptSansNarrow(
                  textStyle:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8,
            ),
            PieChart(
              dataMap: langs,
              animationDuration: Duration(milliseconds: 800),
              chartLegendSpacing: 45,
              chartRadius: MediaQuery.of(context).size.width / 3.2,
              colorList: colorList,
              initialAngleInDegree: 0,
              legendOptions: LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.right,
                showLegends: true,
                legendShape: BoxShape.circle,
                legendTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              chartValuesOptions: ChartValuesOptions(
                showChartValueBackground: false,
                showChartValues: true,
                showChartValuesInPercentage: true,
                showChartValuesOutside: true,
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Text(
              'Popularity of IDEs',
              style: GoogleFonts.ptSansNarrow(
                  textStyle:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8,
            ),
            PieChart(
              dataMap: ides,
              animationDuration: Duration(milliseconds: 800),
              chartLegendSpacing: 45,
              chartRadius: MediaQuery.of(context).size.width / 3.2,
              colorList: colorList,
              initialAngleInDegree: 0,
              legendOptions: LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.right,
                showLegends: true,
                legendShape: BoxShape.circle,
                legendTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              chartValuesOptions: ChartValuesOptions(
                showChartValueBackground: false,
                showChartValues: true,
                showChartValuesInPercentage: true,
                showChartValuesOutside: true,
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Text(
              'Popularity of DBs',
              style: GoogleFonts.ptSansNarrow(
                  textStyle:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8,
            ),
            PieChart(
              dataMap: databases,
              animationDuration: Duration(milliseconds: 800),
              chartLegendSpacing: 45,
              chartRadius: MediaQuery.of(context).size.width / 3.2,
              colorList: colorList,
              initialAngleInDegree: 0,
              legendOptions: LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.right,
                showLegends: true,
                legendShape: BoxShape.circle,
                legendTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              chartValuesOptions: ChartValuesOptions(
                showChartValueBackground: false,
                showChartValues: true,
                showChartValuesInPercentage: true,
                showChartValuesOutside: true,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Center(
              child: Text(
                'Source: PYPL and Google Trends',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        )));
  }

  void showRatingDialog() {
    showDialog(
        context: context,
        barrierDismissible: false, // set to false if you want to force a rating
        builder: (context) {
          return RatingDialog(
            icon: const Icon(
              Icons.star,
              size: 100,
              color: Colors.blue,
            ), // set your own image/icon widget
            title: "Do you enjoy using Dev Portal?",
            description: "Tap a star to give your rating.",
            submitButton: "SUBMIT",
            alternativeButton: "Contact us instead?", // optional
            positiveComment: "We are so happy to hear 😍", // optional
            negativeComment: "We're sad to hear 😭", // optional
            accentColor: Colors.blue, // optional
            onSubmitPressed: (int rating) {
               prefs.setBool('ratingseen', true);
              _rateOurApp();
            },
            onAlternativePressed: () {
               prefs.setBool('ratingseen', true);
              _reportIssue();
            },
          );
        });
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
}
