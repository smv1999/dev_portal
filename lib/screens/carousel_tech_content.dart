import 'package:flutter/material.dart';

class CarouselTechContent extends StatefulWidget {
  final String url;
  CarouselTechContent(this.url);
  @override
  _CarouselTechContentState createState() => _CarouselTechContentState(url);
}

class _CarouselTechContentState extends State<CarouselTechContent> {
  final String url;
  _CarouselTechContentState(this.url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue,
          title: Text(
            'Tech Content',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'MyFont',
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Image.network(url, width: double.infinity));
  }
}
