import 'package:firebase_database/firebase_database.dart';

class People {
  String imagepath;
  String firstname;
  String lastname;
  String employmenttitle;

  People({this.imagepath, this.firstname, this.lastname, this.employmenttitle});

  People.fromJson(Map<String, dynamic> json) {
    imagepath = json['imagepath'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    employmenttitle = json['employmenttitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imagepath'] = this.imagepath;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['employmenttitle'] = this.employmenttitle;
    return data;
  }
}
