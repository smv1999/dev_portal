import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';
import 'package:toast/toast.dart';

class InterviewPage extends StatefulWidget {
  @override
  _InterviewPageState createState() => _InterviewPageState();
}

class _InterviewPageState extends State<InterviewPage> {
  Future<File> createFileOfPdfUrl(String pdfURL) async {
    var url = pdfURL;
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  String pathPDF = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: FittedBox(
            fit: BoxFit.contain,
            child: Image.asset('images/info.png')
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          onPressed: () {
            // Respond to button press
            // show info dialog
            showCustomDialog(context, 'These resources are taken from online platforms and the author of this application '
            'does not propose that he is the author of these resources. The credit goes to the creators of these content. The sole '
            'purpose of using these resources is for educational purposes.', 'images/info.png');
          },
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Interview Preparation Module',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'MyFont',
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Container(
          // child: RaisedButton(
          //   child: Text("Open PDF"),
          //   onPressed: () => Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => PDFScreen(pathPDF)),
          //   ),
          // )
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () => {
                      createFileOfPdfUrl(
                              "http://smv1999.github.io/SubjectTopicsforInterviews.pdf")
                          .then((f) {
                        setState(() {
                          pathPDF = f.path;
                        });
                      }).then((_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PDFScreen(pathPDF,
                                  "Subject Wise Topics for Interview")),
                        );
                      })
                    },
                    title: Text(
                      'Subject Wise Topics for Interview',
                      style: GoogleFonts.ptSansNarrow(),
                    ),
                    leading: Container(
                        width: 80, child: Image.asset('images/ai.png')),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () => {
                      createFileOfPdfUrl(
                              "http://smv1999.github.io/NontechnicalHRQuestions.pdf")
                          .then((f) {
                        setState(() {
                          pathPDF = f.path;
                        });
                      }).then((_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PDFScreen(
                                  pathPDF, "Non Technical HR Questions")),
                        );
                      })
                    },
                    title: Text(
                      'Non Technical HR Questions',
                      style: GoogleFonts.ptSansNarrow(),
                    ),
                    leading: Container(
                        width: 80, child: Image.asset('images/cs.jpg')),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () => {
                      createFileOfPdfUrl(
                              "http://smv1999.github.io/BigOCheatSheet.pdf")
                          .then((f) {
                        setState(() {
                          pathPDF = f.path;
                        });
                      }).then((_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PDFScreen(
                                  pathPDF, "Time Complexity Cheatsheet")),
                        );
                      })
                    },
                    title: Text(
                      'Time Complexity Cheatsheet',
                      style: GoogleFonts.ptSansNarrow(),
                    ),
                    leading: Container(
                        width: 80, child: Image.asset('images/time.jpg')),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ),
                  ),
                ),
                Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () => {
                      createFileOfPdfUrl(
                              "http://smv1999.github.io/OOPsJava.pdf")
                          .then((f) {
                        setState(() {
                          pathPDF = f.path;
                        });
                      }).then((_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PDFScreen(pathPDF, "OOPs Concepts in Java")),
                        );
                      })
                    },
                    title: Text(
                      'OOPs Concepts in Java',
                      style: GoogleFonts.ptSansNarrow(),
                    ),
                    leading: Container(
                        width: 80, child: Image.asset('images/java.png')),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
  showCustomDialog(BuildContext context, String text, String imageName) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 300.0,
        width: 300.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Image.asset(
                    imageName,
                    height: 80,
                    width: 80,
                  )),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  text,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.ptSansNarrow(
                      textStyle: TextStyle(fontSize: 17)),
                ),
              )
            ],
          ),
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }
}

class PDFScreen extends StatelessWidget {
  String pathPDF = "";
  String docName = "";
  PDFScreen(this.pathPDF, this.docName);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text(this.docName),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                // Share the PDF via other apps
                ShareExtend.share(this.pathPDF, "file");
              },
            ),
          ],
        ),
        path: pathPDF);
  }
    
}
