import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dev_portal/models/jobs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ExploreJobs extends StatefulWidget {
  @override
  _ExploreJobsState createState() => _ExploreJobsState();
}

class _ExploreJobsState extends State<ExploreJobs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Dev Portal',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'MyFont',
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(
              height: 15.0,
            ),
            Center(
              child: TextLiquidFill(
                text: 'Explore Job Opportunities',
                waveColor: Colors.black,
                boxBackgroundColor: Colors.white,
                textStyle: TextStyle(fontSize: 25.0, fontFamily: 'MyFont'),
                boxHeight: 50.0,
              ),
            ),
            FutureBuilder(
              future: fetchJobs(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        subtitle: Text(snapshot.data[index].companyName),
                        title: Text(
                          snapshot.data[index].title,
                          style: GoogleFonts.ptSansNarrow(),
                        ),
                        leading: Container(
                          width: 80,
                          height: 80,
                          child: snapshot.data[index].companyLogoURL == null
                              ? Image.asset('images/somethingwrong.png')
                              : Image.network(
                                  snapshot.data[index].companyLogoURL),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        ),
                      );
                    },
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          ],
        ));
  }

  Future<List<Jobs>> fetchJobs() async {
    final response = await http.get('https://jobs.github.com/positions.json?');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonData = json.decode(response.body);

      List<Jobs> jobs = [];
      for (var j in jsonData) {
        Jobs job = Jobs(
            j["type"],
            j["created_at"],
            j["company"],
            j["company_url"],
            j["location"],
            j["title"],
            j["description"],
            j["how_to_apply"],
            j["company_logo"]);
        jobs.add(job);
      }
      return jobs;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
