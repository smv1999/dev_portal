import 'package:dev_portal/models/people.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  static Future<List<People>> getPeople() async {
    List<People> people = [];
    DatabaseReference myRef;
    myRef = FirebaseDatabase.instance.reference().child('Profile');
    myRef.once().then((DataSnapshot dataSnapshot) {
      Map<String, dynamic> mapOfMaps = Map.from(dataSnapshot.value);
      mapOfMaps.values.forEach((value) {
        people.add(People.fromJson(Map.from(value)));
      });
    });

    return people;
  }
}
