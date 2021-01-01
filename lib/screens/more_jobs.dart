import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:http/http.dart' as http;

class MoreJobs extends StatefulWidget {
  @override
  _MoreJobsState createState() => _MoreJobsState();
}

class _MoreJobsState extends State<MoreJobs> {
  static const String FEED_URL =
      "https://weworkremotely.com/categories/remote-programming-jobs.rss";
  RssFeed _feed;
  String _title = "";
  static const String loadingFeedMsg = 'Loading Jobs ...';
  static const String feedLoadErrorMsg = 'Error Loading Jobs!';
  static const String feedOpenErrorMsg = 'Error Opening Jobs!';
  GlobalKey<RefreshIndicatorState> _refreshKey;

  updateTitle(title) {
    setState(() {
      _title = title;
    });
  }

  updateFeed(feed) {
    setState(() {
      _feed = feed;
    });
  }

  load() async {
    updateTitle(loadingFeedMsg);
    loadFeed().then((result) {
      if (result == null || result.toString().isEmpty) {
        updateTitle(feedLoadErrorMsg);
        return;
      }
      updateFeed(result);
      updateTitle(_feed.title);
    });
  }

  Future<void> openFeed(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,
      );
      return;
    }
    updateTitle(feedOpenErrorMsg);
  }

  Future<RssFeed> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(FEED_URL);

      return RssFeed.parse(response.body);
    } catch (exception) {
      //
    }
    return null;
  }

  title(title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  subtitle(subTitle) {
    return Text(
      subTitle,
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w100),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  thumbnail(imageUrl) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0),
      // child: CachedNetworkImage(
      //   placeholder: (context, url) => Image.asset('images/dev.jpg'),
      //   imageUrl: imageUrl,
      //   height: 50,
      //   width: 70,
      //   alignment: Alignment.center,
      //   fit: BoxFit.fill,
      // ),
      child: Image.asset(imageUrl,
          height: 50, width: 70, alignment: Alignment.center, fit: BoxFit.fill),
    );
  }

  rightIcon() {
    return Icon(
      Icons.keyboard_arrow_right,
      color: Colors.grey,
      size: 30.0,
    );
  }

  list() {
    var images = ['images/job1.png','images/job2.jpeg','images/job3.jpg','images/job4.jpg','images/job5.jpg'];

    final _random = new Random();


    return ListView.builder(
      itemCount: _feed.items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = _feed.items[index];
        return ListTile(
          title: title(item.title),
          subtitle: subtitle(item.pubDate.toString()),
          leading: thumbnail(images[_random.nextInt(images.length)]),
          trailing: rightIcon(),
          contentPadding: EdgeInsets.all(5.0),
          onTap: () => openFeed(item.link),
        );
      },
    );
  }

  isFeedEmpty() {
    return null == _feed || null == _feed.items;
  }

  body() {
    return isFeedEmpty()
        ? Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            key: _refreshKey,
            child: list(),
            onRefresh: () => load(),
          );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateTitle("Dev Portal");
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          _title,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'MyFont',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: body(),
    );
  }
}
