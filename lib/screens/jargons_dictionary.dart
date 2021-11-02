import 'package:dev_portal/models/jargon_data.dart';
import 'package:dev_portal/services/ProgressBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JargonDictionary extends StatefulWidget {
  @override
  _JargonDictionaryState createState() => _JargonDictionaryState();
}

class _JargonDictionaryState extends State<JargonDictionary> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Future f;
  SharedPreferences prefs;
  bool _seen;
  ProgressBar progressBar;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    progressBar = ProgressBar();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showSendingProgressBar();
      setState(() {
        checkTipSeen();
      });
    });
    f = retrieveJargonsData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.of(context).pushNamedAndRemoveUntil('/tools', (_) => false);
          return;
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.blue,
            automaticallyImplyLeading: false,
            title: Text(
              'Jargon Dictionary',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'MyFont',
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: Container(
            color: Colors.white60,
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                FutureBuilder(
                  future: f,
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      if (snapshot.data.length != 0) {
                        hideSendingProgressBar();
                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.all(8.0),
                              child: ListTile(
                                subtitle: Text(snapshot.data[index].definition,
                                  style: GoogleFonts.ptSansNarrow(textStyle: TextStyle(fontSize: 18)),
                                textAlign: TextAlign.justify,),
                                title: Text(
                                  snapshot.data[index].term,
                                  style: GoogleFonts.ptSansNarrow(textStyle: TextStyle(fontSize: 22)),
                                ),
                              ),
                              elevation: 3,
                            );
                          },
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                        );
                      }
                      return Container(
                        child: Image.network(
                            'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/data_not_found.png'),
                      );
                    } else if (snapshot.hasError) {
                      setState(() {
                        hideSendingProgressBar();
                      });
                      return Text("${snapshot.error}");
                    }
                    return Container();
                  },
                )
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    progressBar.hide();
    super.dispose();
  }

  void showSendingProgressBar() {
    progressBar.show(context);
  }

  void hideSendingProgressBar() {
    progressBar.hide();
  }

  Future checkTipSeen() async {
    prefs = await SharedPreferences.getInstance();
    _seen = (prefs.getBool('dictionarysheetseen') ?? false);
    if (!_seen) {
      showBottomSheetDialog();
      await prefs.setBool('dictionarysheetseen', true);
    }
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 250,
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Image.network(
                      'https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/getting_started.png',
                      height: 80,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'Getting Started',
                      style: GoogleFonts.ptSansNarrow(
                          textStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'You can view the list of programming jargons here and search them by typing it in the search bar.',
                      style: GoogleFonts.ptSansNarrow(
                          textStyle: TextStyle(
                        fontSize: 18,
                      )),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                ),
              ),
            ),
          );
        });
  }

  Future<List<JargonData>> retrieveJargonsData() async {
    final response =
        await http.get('https://programmingjargons.deta.dev/get-jargons');
    List<JargonData> jargonDataList = new List<JargonData>();
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonData = json.decode(response.body);

      for (var i = 0; i < jsonData.length; i++) {
        JargonData jargonData = JargonData(
          jsonData[i]["id"],
          jsonData[i]["term"],
          jsonData[i]["definition"],
        );
        jargonDataList.add(jargonData);
      }
      return jargonDataList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
