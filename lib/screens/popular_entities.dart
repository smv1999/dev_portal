import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';

class Popular extends StatefulWidget {
  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
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
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.yellow
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
}
