import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              height: 45,
              width: 80,
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
                height: 250.0,
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
          ],
        ),
      ),
    );
  }
}
