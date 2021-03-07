import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarouselTechContent extends StatefulWidget {
  final String url;
  CarouselTechContent(this.url);
  @override
  _CarouselTechContentState createState() => _CarouselTechContentState(url);
}

class _CarouselTechContentState extends State<CarouselTechContent> {
  final String url;
  _CarouselTechContentState(this.url);
  String title;
  List<String> mainList = [];
  List<String> AI_FACTS = [
    "If you ask Siri, Alexa, Cortana, or your bank’s Voice assistance a question, most likely, you will be answered by a pleasant and polite woman’s voice. The reason? Studies show that males and females are more attracted to a woman's voice",
    "Although real pets are lovable, according to pet-bot developers, they have a few downsides. They need to be fed, cleaned up, and they die. AI pets will be robots that look, feel and act like a real animal, but eliminate such “issues” experienced by owners",
    "Scary right? A new methodology has been developed by roboticists that can create an image of your thoughts using an FMRI scanner. The AI is designed to construct an image from your brain and compare it with other pictures, received from volunteers",
    "AI is Estimated to Kill 6% of Jobs by 2021. That’s about 1,160,000 people out of work only in Canada. Although AI is helpful in cutting business costs, it’s set to create some serious problems",
    "Sophia, a lifelike humanoid has gained guaranteed citizenship of Saudi Arabia. This has brought much controversy as the public wonders and questions whether or not robots should have rights"
  ];

  List<String> BLOCKCHAIN_FACTS = [
    "Many people have assumed this fact on the basis of the introduction of public global blockchains like Bitcoin. However, this is one of the notable Blockchain myths that can confuse any beginner. As a matter of fact, public blockchains are not the only type of Blockchain. Private and hybrid blockchains are also suitable for different use cases.",
    "The first-ever instance of mainstream recognition for Blockchain was the introduction of Bitcoin in 2009. So, many people confuse Blockchain as a cryptocurrency. However, cryptocurrencies are basically another application of Blockchain technology. Blockchain is basically a system that stores records of transactions and the records are maintained throughout different computers linked to each other via a peer-to-peer network.",
    "The primary basis of Blockchain technology is encryption of information related to specific transactions between two parties. The majority of blockchains like the Bitcoin blockchain use the SHA-256 cryptographic hash algorithm. Most important of all, many experts commend SHA-256 for its potential to address encryption requirements for the foreseeable future.",
    "Blockchain technology presents many promising benefits, and therefore people are liable to believe in this myth about Blockchain. Furthermore, news reports of oil-backed cryptocurrency, Petro, in Venezuela, and the Bank of England’s growing interest in cryptocurrencies are also fueling such myths",
    "One of the common Blockchain myths implies that they are just cloud-based databases. In reality, you should download the blockchain and run it on internet-enabled computers for operating it. Any computer in the world running a blockchain is accounted for as a node on the network. The strength of the internet connection of the computer running blockchain is a major factor in strengthening the blockchain network"
  ];

  List<String> VR_AR_FACTS = [
    "The combined installed base of mobile AR devices and smart glasses could exceed two and a half billion units by 2023, creating huge opportunities for innovative AR applications.",
    "The sports sector can leverage AR for uses that Lunge from broadcasting to in-stadium experiences to supplement and drive income.",
    "2021 just may be the year smartphones are recognized as a valuable tool for improving learning outcomes as students are missing out on out-of-school learning experiences.",
    "AR can benefit patients and doctors alike. From assisting with blood draws, improving diagnosis, and assisting in the case of an emergency, the potential is massive.",
    "AR in your car can provide real-time data from your GPS or about road conditions and hazards, your speed, any mechanical issues, and more to improve road safety."
  ];

  List<String> ClOUD_COMPUTING_FACTS = [
    "Companies like Amazon and Microsoft are receiving an ever growing portion of their revenues from the cloud.",
    "Many people currently consider the cloud to be more secure than conventionally stored data. In the last several years new anti-malware and firewall tools have decreased many decision makers reservations about data passing in and out of the cloud. Data is also further secured by encryption, if the user doesn't have the key to decrypt the data, then the data is absolutely useless to even those who are able to access it.",
    "An increased investment in cloud computing will likely be seen across all industries as the cloud helps businesses save money by using staff more efficiently. Long term, IDC expects spending on cloud IT infrastructure to grow at a five-year compound annual growth rate of 10.4%, reaching \$109.3 billion in 2024 and accounting for 63.6% of total IT infrastructure spend",
    "Currently the cloud is being utilized for storage more than it is used for things like application deployment. However, this could change as the demand for cloud services grows and enables new business models.",
    "Banks are the most active users within the cloud. This is a direct result of the popularity of mobile banking applications and virtual transaction services like PayPal and Venmo. Developing currencies like Bitcoin may also play a role in the increase of cloud utilization within the banking industry in the years to come."
  ];

  List<String> BIG_DATA_FACTS = [
    "The data volume is exploding like never before and an immense amount of data has been created in the past two years in comparison to the previous history of human race.",
    "A study has successfully revealed that more than 37.5% of enterprises believe that analyzing the big data is their biggest challenge.",
    "75% of the total digital information is being generated by individuals from different sectors while the enterprises will deal with 80% of the entire digital data at some point in time.",
    "Within the next 5-8 years, you’ll find more than 50 billion smart connected devices available in the entire world which will be all developed to collect, analyze and last but not the least share data.",
    "If the data generated in a day was burned onto DVDs, the number would be so massive that it could be piled on top of each other to reach the moon twice!"
  ];

  List<String> RPA_FACTS = [
    "One of the biggest misconceptions about RPA is that it will eat up human jobs. RPA works alongside humans to make their lives easier. RPA software carries out jobs that are repetitive and mundane. This can enable us to focus on fruitful endeavors thus improving efficiency.",
    "RPA has disrupted the outsourcing industry. The increased efficiency and usability that comes with RPA implementation, has threatened traditional BPO relationships. Since RPA can handle more transactions without making mistakes or taking breaks, traditional outsourcing relationships have declined over the last few years. However, if BPOs embrace the benefits of RPA or any other transformative technology they’ll continue to work.",
    "It’s true that RPA has delivered huge benefits to its users. However, many users have also found that the implementation of RPA was quite challenging. Selecting the wrong RPA is one reason that can cause the RPA project to become more complicated than it actually should. If your company doesn’t have an interconnected system that updates cloud or on-premise infrastructure, then RPA implementation can be a big challenge.",
    "RPA automates processes but does not improve any defects in the existing processes. Due to the hype surrounding RPA, organizations view it as a solution to all their woes. While RPA does help to streamline and modernize processes that are well established, it does nothing to improve a flawed process. So before automating, it’s better to have a clearly defined business process.",
    "RPA can be used where high volumes of repetitive transactions based on business rules are carried out. For eg: banking and financial services, insurance, healthcare, pharmaceuticals, manufacturing, travel, logistics, etc. However, if the processes involve reasoning, making decisions, taking different actions according to scenarios, then those processes will not be able to enjoy the full benefits of business automation."
  ];

  List<String> IOT_FACTS = [
    "The term Internet of Things was coined by Kevin Ashton while working for Procter & Gamble in 1999.",
    "The concept of a network of smart devices was discussed as early as 1982, with a modified Coke machine at Carnegie Mellon University becoming the first internet-connected appliance, able to report its inventory and whether newly loaded drinks were cold.",
    "According to Intel, ATMs were the first end user-oriented elements to be connected online back in the 1970s.",
    "Smart homes are not a thing of future anymore. People have already started adopting smart home appliances like Nest thermostat, Philips Hue, and other home automation devices. As per a research did by a company named Zion, the smart home automation market could grow to the staggering number of \$53 billion by 2022.",
    "Last year, in a research conducted by Forrester, found that 23% of big global enterprise businesses opted more IoT solutions, compared to just 14% of small and medium-sized businesses."
  ];
  void returnTitle() {
    if (url ==
        "https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/ai.png")
      title = "Artificial Intelligence";
    else if (url ==
        "https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/blockchain.png")
      title = "Blockchain";
    else if (url ==
        "https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/vrar.png")
      title = "Virtual Reality / Augmented Reality";
    else if (url ==
        "https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/cloudcomputing.png")
      title = "Cloud Computing";
    else if (url ==
        "https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/bigdata.jpeg")
      title = "Big Data";
    else if (url ==
        "https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/rpa.png")
      title = "Robotic Process Automation";
    else if (url ==
        "https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/iot.png")
      title = "Internet of Things";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    returnTitle();
    if (title == "Artificial Intelligence") {
      mainList = AI_FACTS;
    }
    else if (title == "Blockchain"){
      mainList = BLOCKCHAIN_FACTS;
    }
    else if (title == "Virtual Reality / Augmented Reality"){
      mainList = VR_AR_FACTS;
    }
    else if(title == "Cloud Computing"){
      mainList = ClOUD_COMPUTING_FACTS;
    }
    else if (title == "Big Data"){
      mainList = BIG_DATA_FACTS;
    }
    else if (title == "Robotic Process Automation"){
      mainList = RPA_FACTS;
    }
    else{
      mainList = IOT_FACTS;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        title: Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'MyFont',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        shrinkWrap: true,
        children: [
          Image.network(url, width: double.infinity),
          SizedBox(
            height: 20.0,
          ),
          MaterialButton(
            onPressed: () {
              if (mainList.isNotEmpty) showCustomDialog(context, mainList[0]);
            },
            color: Colors.blue,
            splashColor: Colors.blueAccent,
            textColor: Colors.white,
            child: Icon(
              Icons.school,
              size: 24,
            ),
            padding: EdgeInsets.all(16),
            shape: CircleBorder(),
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                onPressed: () {
                  if (mainList.isNotEmpty)
                    showCustomDialog(context, mainList[1]);
                },
                color: Colors.blue,
                splashColor: Colors.blueAccent,
                textColor: Colors.white,
                child: Icon(
                  Icons.school,
                  size: 24,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              ),
              MaterialButton(
                onPressed: () {
                  if (mainList.isNotEmpty)
                    showCustomDialog(context, mainList[2]);
                },
                color: Colors.blue,
                splashColor: Colors.blueAccent,
                textColor: Colors.white,
                child: Icon(
                  Icons.school,
                  size: 24,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              )
            ],
          ),
          SizedBox(
            height: 25.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                onPressed: () {
                  if (mainList.isNotEmpty)
                    showCustomDialog(context, mainList[3]);
                },
                color: Colors.blue,
                splashColor: Colors.blueAccent,
                textColor: Colors.white,
                child: Icon(
                  Icons.school,
                  size: 24,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              ),
              MaterialButton(
                onPressed: () {
                  if (mainList.isNotEmpty)
                    showCustomDialog(context, mainList[4]);
                },
                color: Colors.blue,
                splashColor: Colors.blueAccent,
                textColor: Colors.white,
                child: Icon(
                  Icons.school,
                  size: 24,
                ),
                padding: EdgeInsets.all(16),
                shape: CircleBorder(),
              )
            ],
          )
        ],
      ),
    );
  }

  showCustomDialog(BuildContext context, String text) {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 280.0,
        width: 300.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                  padding: EdgeInsets.all(10.0), child: Icon(Icons.lightbulb, size: 30.0, color: Colors.blue,)),
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
