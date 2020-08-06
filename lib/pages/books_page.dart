import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class BooksPage extends StatefulWidget {
  @override
  _BooksPageState createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(height: 15.0,),
              Center(child:TextLiquidFill(
                text: 'Popular Books',
                waveColor: Colors.black,
                boxBackgroundColor: Colors.white,
                textStyle: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'MyFont'
                ),
                boxHeight: 50.0,
              ),
              ),
              SizedBox(height: 15.0,),
              Container(
                  child:GridView.count(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    mainAxisSpacing: 25.0,
                    crossAxisCount: 2,
                    children: <Widget>[
                      GestureDetector(
                        child: Image.network('https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/book1.jpg?token=AKHIZQM4JUEGEBNWLOXCEP27GUZUY'),
                        onTap: () => _openBookURL(1),
                      ),
                      GestureDetector(
                        child: Image.network('https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/book2.jpg?token=AKHIZQLM76ECMP2M765WEMS7GU3EK'),
                        onTap: () => _openBookURL(2),
                      ),
                      GestureDetector(
                        child: Image.network('https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/book3.jpg?token=AKHIZQOI6NFOSVQAKW5JOKS7GU3KG'),
                        onTap: () => _openBookURL(3),
                      ),
                      GestureDetector(
                        child: Image.network('https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/book4.jpg?token=AKHIZQNWRB6EGOHROULYHG27GU3LU'),
                        onTap: () => _openBookURL(4),
                      ),
                      GestureDetector(
                        child: Image.network('https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/book5.jpg?token=AKHIZQNHHL7BGIDPHNSYBBK7GU3NQ'),
                        onTap: () => _openBookURL(5),
                      ),
                      GestureDetector(
                        child: Image.network('https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/book6.jpg?token=AKHIZQNJ4FMLZAX66CCVNVS7GU3O2'),
                        onTap: () => _openBookURL(6),
                      ),
                      GestureDetector(
                        child: Image.network('https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/book7.jpg?token=AKHIZQPXXWVCG4YB2JKYNSK7GU3QC'),
                        onTap: () => _openBookURL(7),
                      ),
                      GestureDetector(
                        child: Image.network('https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/book8.jpg?token=AKHIZQJVJZQQITMWPCUBS427GU3SI'),
                        onTap: () => _openBookURL(8),
                      ),
                      GestureDetector(
                        child: Image.network('https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/book9.jpg?token=AKHIZQNS42BUS2GOQWSQK6S7GU3TS'),
                        onTap: () => _openBookURL(9),
                      ),
                      GestureDetector(
                        child: Image.network('https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/book10.jpg?token=AKHIZQJZDBGK4LWOBMXOLOK7GU3UO'),
                        onTap: () => _openBookURL(10),
                      ),
                    ],
                  ),
              ),
              SizedBox(height: 15.0,),
              Center(child:TyperAnimatedTextKit(
                  onTap: () {
                    print("Tap Event");
                  },
                  text: [
                    "Popular Best Tech Movies",
                  ],
                  textStyle: TextStyle(
                      fontSize: 30.0,
                      fontFamily: "MyFont"
                  ),
              ),
              ),
              SizedBox(height: 10.0,),
              Container(
                child:GridView.count(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  mainAxisSpacing: 25.0,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Image.network('https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/movie1.jpg?token=AKHIZQNXUUWPQWIAW6AGUBC7GVXC6'),
                    Container(
                      height:100.0,
                    child:Image.network('https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/movie2.jpg?token=AKHIZQLW7YSUEHR5A5NJQIC7GVVSS'),
                    ),
                    Image.network('https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/movie3.jpg?token=AKHIZQL3L5TY7UCG3UBPC2C7GVUZM'),
                    Image.network('https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/movie4.jpg?token=AKHIZQLKORCRFKRDVPBZ76K7GVU3K'),
                    Image.network('https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/movie5.jpg?token=AKHIZQN2ANMEKAJ44VOJNBK7GVXEY'),
                    Image.network('https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/movie6.jpg?token=AKHIZQIYKP2CMLGQQQ25BLC7GVVDA'),
                    Image.network('https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/movie7.jpg?token=AKHIZQNQKCUJUQRBJ5J7CDK7GVVGK'),
                    Image.network('https://raw.githubusercontent.com/smv1999/FlutterNetworkImagesDP/master/movie8.jpg?token=AKHIZQMI7TGYCNUPMUK4NPC7GVVXM'),

                  ],
                ),
              ),
            ],
        ),
      ),
    );
  }
}

void _openBookURL(int choice) async{
  var url;
  switch(choice)
  {
    case 1:
      url = 'https://www.amazon.in/Pragmatic-Programmer-journey-mastery-Anniversary/dp/0135957052/ref=as_li_ss_tl?_encoding=UTF8&qid=1581972273&sr=1-1&linkCode=sl1&tag=daolf-20&linkId=7d7bc7849584bd034c885e970153263c&language=en_US';
      break;
    case 2:
      url = 'https://www.amazon.in/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882/ref=as_li_ss_tl?keywords=clean+code&qid=1581972195&s=books&sr=1-1&linkCode=sl1&tag=daolf-20&linkId=8f76f14e5a27299c76415f7b76fca383&language=en_US';
      break;
    case 3:
      url = 'https://www.amazon.in/Code-Complete-Practical-Handbook-Construction/dp/0735619670/ref=as_li_ss_tl?keywords=code+complete&qid=1581972119&s=books&sr=1-1&linkCode=sl1&tag=daolf-20&linkId=04ded90404272a7ad18caa3ca663ee6f&language=en_US';
      break;
    case 4:
      url = 'https://www.amazon.in/Refactoring-Improving-Existing-Addison-Wesley-Signature/dp/0134757599/ref=as_li_ss_tl?keywords=refactoring&qid=1581971932&s=books&sr=1-1&linkCode=sl1&tag=daolf-20&linkId=88e49f76709c99275a2b3de81fde6c16&language=en_US';
      break;
    case 5:
      url = 'https://www.amazon.in/Head-First-Design-Patterns-Brain-Friendly/dp/0596007124/ref=as_li_ss_tl?keywords=head+first+design+patterns&qid=1581971830&s=books&sr=1-1&linkCode=sl1&tag=daolf-20&linkId=38d4d0ad91837df35be062b555c089b0&language=en_US';
      break;
    case 6:
      url = 'https://www.amazon.in/Mythical-Man-Month-Software-Engineering-Anniversary/dp/0201835959/ref=as_li_ss_tl?keywords=mythical+man+month&qid=1581971745&s=books&sr=1-1&linkCode=sl1&tag=daolf-20&linkId=19491bbda47a589ed411d6b862b90496&language=en_US';
      break;
    case 7:
      url = 'https://www.amazon.in/Clean-Coder-Conduct-Professional-Programmers/dp/0137081073/ref=as_li_ss_tl?keywords=clean+coder&qid=1581971654&s=books&sr=1-1&linkCode=sl1&tag=daolf-20&linkId=7bf870e3ab68154ad04c3dc63293f5f6&language=en_US';
      break;
    case 8:
      url = 'https://www.amazon.in/Working-Effectively-Legacy-Michael-Feathers/dp/0131177052/ref=as_li_ss_tl?crid=PF12YCMSEVRA&keywords=working+effectively+with+legacy+code&qid=1581971577&s=books&sprefix=working+ef,stripbooks-intl-ship,237&sr=1-1&linkCode=sl1&tag=daolf-20&linkId=5a3e625e7269ae68d09595fa64662486&language=en_US';
      break;
    case 9:
      url = 'https://www.amazon.in/Design-Patterns-Elements-Reusable-Object-Oriented/dp/0201633612/ref=as_li_ss_tl?keywords=design+patterns&qid=1581971481&s=books&sr=1-1&linkCode=sl1&tag=daolf-20&linkId=367fa9e050c9ec6a623e2b0272c03259&language=en_US';
      break;
    case 10:
      url = 'https://www.amazon.in/Cracking-Coding-Interview-Programming-Questions/dp/0984782850/ref=as_li_ss_tl?keywords=cracking+the+coding+interview&qid=1581971348&s=books&sr=1-1&linkCode=sl1&tag=daolf-20&linkId=a7d30aad79c08c0712b93ccfbd902d6d&language=en_US';
      break;
  }

  if (await canLaunch(url)) {
  await launch(url);
  } else {
  throw 'Could not launch $url';
  }
}


