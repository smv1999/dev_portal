import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _formKey = GlobalKey<FormState>();
  String firstname,lastname;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Profile',
        style: TextStyle(
            color: Colors.black,
        ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 40.0,
                    child: CircleAvatar(
                      radius: 38.0,
                      child: ClipOval(
                        child: Image.asset('images/newimage.png'),
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  TextFormField(
                    maxLines: 1,
                    validator: (val) => val.isEmpty ? 'Enter your First Name' : null,
                    onChanged: (text) {
                      setState(() {
                        firstname = text;
                      });
                    },
                      decoration: InputDecoration(
                        hintText: 'First Name',
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          fontSize: 16.0,
                          height: 1.4,
                          color: Colors.black,
                          fontFamily: 'Montserrat')
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                      maxLines: 1,
                      validator: (val) => val.isEmpty ? 'Enter your Last Name' : null,
                      onChanged: (text) {
                        setState(() {
                          firstname = text;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          fontSize: 16.0,
                          height: 1.4,
                          color: Colors.black,
                          fontFamily: 'Montserrat')
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                      maxLines: 1,
                      validator: (val) => val.isEmpty ? 'Enter your DOB' : null,
                      onChanged: (text) {
                        setState(() {
                          firstname = text;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Date of birth',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.datetime,
                      style: TextStyle(
                          fontSize: 16.0,
                          height: 1.4,
                          color: Colors.black,
                          fontFamily: 'Montserrat')
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                      maxLines: 1,
                      validator: (val) => val.isEmpty ? 'Enter your Summary' : null,
                      onChanged: (text) {
                        setState(() {
                          firstname = text;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Summary',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          fontSize: 16.0,
                          height: 1.4,
                          color: Colors.black,
                          fontFamily: 'Montserrat')
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                      maxLines: 1,
                      validator: (val) => val.isEmpty ? 'Enter your Email' : null,
                      onChanged: (text) {
                        setState(() {
                          firstname = text;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                          fontSize: 16.0,
                          height: 1.4,
                          color: Colors.black,
                          fontFamily: 'Montserrat')
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                      maxLines: 1,
                      validator: (val) => val.isEmpty ? 'Enter your Username' : null,
                      onChanged: (text) {
                        setState(() {
                          firstname = text;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Username',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          fontSize: 16.0,
                          height: 1.4,
                          color: Colors.black,
                          fontFamily: 'Montserrat')
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                      maxLines: 1,
                      validator: (val) => val.isEmpty ? 'Enter your Website' : null,
                      onChanged: (text) {
                        setState(() {
                          firstname = text;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Website',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.url,
                      style: TextStyle(
                          fontSize: 16.0,
                          height: 1.4,
                          color: Colors.black,
                          fontFamily: 'Montserrat')
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                      maxLines: 1,
                      maxLength: 10,
                      validator: (val) => val.isEmpty ? 'Enter your Phone Number' : null,
                      onChanged: (text) {
                        setState(() {
                          firstname = text;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontSize: 16.0,
                          height: 1.4,
                          color: Colors.black,
                          fontFamily: 'Montserrat')
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                      maxLines: 1,
                      validator: (val) => val.isEmpty ? 'Enter your Employment Title' : null,
                      onChanged: (text) {
                        setState(() {
                          firstname = text;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Employment Title',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          fontSize: 16.0,
                          height: 1.4,
                          color: Colors.black,
                          fontFamily: 'Montserrat')
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                      maxLines: 1,
                      validator: (val) => val.isEmpty ? 'Enter your Skills/Languages' : null,
                      onChanged: (text) {
                        setState(() {
                          firstname = text;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Skills/Languages',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          fontSize: 16.0,
                          height: 1.4,
                          color: Colors.black,
                          fontFamily: 'Montserrat')
                  ),
                  SizedBox(height: 15.0,),
                  Center(
                    child:Text('Social Links',
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  TextFormField(
                      maxLines: 1,
                      validator: (val) => val.isEmpty ? 'Enter your YouTube Channel URL' : null,
                      onChanged: (text) {
                        setState(() {
                          firstname = text;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'YouTube Channel URL',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.url,
                      style: TextStyle(
                          fontSize: 16.0,
                          height: 1.4,
                          color: Colors.black,
                          fontFamily: 'Montserrat')
                  )
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
