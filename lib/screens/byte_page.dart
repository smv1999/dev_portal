import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BytePage extends StatefulWidget {
  @override
  _BytePageState createState() => _BytePageState();
}

class _BytePageState extends State<BytePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Mini Bytes',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'MyFont',
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: TyperAnimatedTextKit(
                    text: [
                      "Trending Topics",
                    ],
                    textStyle: TextStyle(fontSize: 30.0, fontFamily: "MyFont"),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () => {
                      showCustomDialog(
                          context,
                          "Artificial Intelligence refers to the simulation of human intelligence in machines that are programmed to think"
                              " like humans and mimic their actions. There are 3 types of AI"
                              "\n1. Artificial Narrow Intelligence"
                              "\n2. Artificial General Intelligence"
                              "\n3. Artificial Super Intelligence",
                          "images/ai.png")
                    },
                    title: Text(
                      'Artificial Intelligence',
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
                SizedBox(
                  height: 10.0,
                ),
                Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () => {
                      showCustomDialog(
                          context,
                          "A blockchain is a distributed ledger that has a growing list of records, called blocks, that are linked using "
                              "cryptography. Each block contains a cryptographic hash of the previous block, a timestamp, and "
                              "transaction data. Popular examples of Cryptocurrency are"
                              "\n1. Bitcoin"
                              "\n2. Ethereum"
                              "\n3. LiteCoin",
                          "images/blockchain.png")
                    },
                    title: Text(
                      'Blockchain',
                      style: GoogleFonts.ptSansNarrow(),
                    ),
                    leading: Container(
                        width: 80, child: Image.asset('images/blockchain.png')),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () => {
                      showCustomDialog(
                          context,
                          "Cloud computing is the on-demand availability of computer system resources, especially data storage "
                              "and computing power, without direct active management by the user. Some popular cloud providers include"
                              "\n1. Amazon Web Services"
                              "\n2. Google Cloud Platform"
                              "\n3. Microsoft Azure",
                          "images/cloudcomputing.png")
                    },
                    title: Text(
                      'Cloud Computing',
                      style: GoogleFonts.ptSansNarrow(),
                    ),
                    leading: Container(
                        width: 80,
                        child: Image.asset('images/cloudcomputing.png')),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () => {
                      showCustomDialog(
                          context,
                          "Big data is a field that treats ways to analyze, systematically extract information from, or "
                              "otherwise deal with data sets that are too large or complex to be dealt with by traditional data-processing application software. The 5 Vs of "
                              "big data are Volume, Velocity, Variety, Veracity and Value. Popular Big Data Tools include"
                              "\n1. Apache Hadoop"
                              "\n2. Cassandra"
                              "\n3. MongoDB",
                          "images/bigdata.png")
                    },
                    title: Text(
                      'Big Data',
                      style: GoogleFonts.ptSansNarrow(),
                    ),
                    leading: Container(
                        width: 80, child: Image.asset('images/bigdata.png')),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () => {
                      showCustomDialog(
                          context,
                          "Network of physical objects that are embedded with sensors, software, and other technologies "
                              "for the purpose of connecting and exchanging data with other devices and systems over the Internet. "
                              "Some applications of IoT include"
                              "\n1. Smart Cars"
                              "\n2. Smart Wearables"
                              "\n3. Smart Retail",
                          "images/iot.png")
                    },
                    title: Text(
                      'Internet of Things',
                      style: GoogleFonts.ptSansNarrow(),
                    ),
                    leading: Container(
                        width: 80, child: Image.asset('images/iot.png')),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () => {
                      showCustomDialog(
                          context,
                          "Augmented reality is an interactive experience of a real-world environment where "
                              "the objects that reside in the real world are enhanced by computer-generated perceptual information. "
                              "This technology is prominent in Gaming and Medicine. Some examples include"
                              "\n1. Pokemon Go"
                              "\n2. Instagram and Snapchat Filters",
                          "images/vrar.png")
                    },
                    title: Text(
                      'Augmented Reality / Virtual Reality',
                      style: GoogleFonts.ptSansNarrow(),
                    ),
                    leading: Container(
                        width: 80, child: Image.asset('images/vrar.png')),
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
        height: 340.0,
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
                    height: 100,
                    width: 100,
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
