import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';

class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  @override
  Map<String, double> dataMap = {
    "Python": 40,
    "Java": 25,
    "JavaScript": 15,
    "C#": 10,
    "PHP": 5,
    "C/C++": 5
  };
  List<Color> colorList = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.yellow
  ];
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            Container(
              height: 35,
              width: 75,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/homebackgroundimage.png"),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 190.0,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 2),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
              items: [
                'images/ai.png',
                'images/blockchain.png',
                'images/vrar.png',
                'images/cloudcomputing.png',
                'images/bigdata.png',
                'images/rpa.png',
                'images/iot.png'
              ].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey)),
                        child: Image.asset(i));
                  },
                );
              }).toList(),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 35,
              width: 70,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/top_it_jobs.png"),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      text: '• ',
                      style: TextStyle(color: Colors.lightBlue, fontSize: 19),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Software Developer',
                            style: GoogleFonts.ptSansNarrow(
                                textStyle: TextStyle(
                                    fontSize: 18, color: Colors.black))),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '• ',
                      style: TextStyle(color: Colors.lightBlue, fontSize: 19),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Network Engineer',
                            style: GoogleFonts.ptSansNarrow(
                                textStyle: TextStyle(fontSize: 18),
                                color: Colors.black)),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '• ',
                      style: TextStyle(color: Colors.lightBlue, fontSize: 19),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Systems Engineer',
                            style: GoogleFonts.ptSansNarrow(
                                textStyle: TextStyle(fontSize: 18),
                                color: Colors.black)),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '• ',
                      style: TextStyle(color: Colors.lightBlue, fontSize: 19),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Java Developer',
                            style: GoogleFonts.ptSansNarrow(
                                textStyle: TextStyle(fontSize: 18),
                                color: Colors.black)),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '• ',
                      style: TextStyle(color: Colors.lightBlue, fontSize: 19),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Software QA Engineer',
                            style: GoogleFonts.ptSansNarrow(
                                textStyle: TextStyle(fontSize: 18),
                                color: Colors.black)),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '• ',
                      style: TextStyle(color: Colors.lightBlue, fontSize: 19),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'IT Project Manager',
                            style: GoogleFonts.ptSansNarrow(
                                textStyle: TextStyle(fontSize: 18),
                                color: Colors.black)),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '• ',
                      style: TextStyle(color: Colors.lightBlue, fontSize: 19),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Application Developer',
                            style: GoogleFonts.ptSansNarrow(
                                textStyle: TextStyle(fontSize: 18),
                                color: Colors.black)),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '• ',
                      style: TextStyle(color: Colors.lightBlue, fontSize: 19),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Computer Support Specialist',
                            style: GoogleFonts.ptSansNarrow(
                                textStyle: TextStyle(fontSize: 18),
                                color: Colors.black)),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '• ',
                      style: TextStyle(color: Colors.lightBlue, fontSize: 19),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Business Analyst',
                            style: GoogleFonts.ptSansNarrow(
                                textStyle: TextStyle(fontSize: 18),
                                color: Colors.black)),
                      ],
                    ),
                  )
                ],
              ),
            ),
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
              dataMap: dataMap,
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
          ],
        ),
      ),
    );
  }
}
