import 'package:firebase_database/firebase_database.dart';
import 'package:randomsampleapp/data/models/random_number.dart';

class FirebaseDatabaseService {
  final databaseReference = FirebaseDatabase.instance.reference();

  Future saveRandomNumber(RandomNumber random) async {
    var id = databaseReference.child('random/').push();
    id.set(random.toJson());
  }

  Future<List<RandomNumber>> getData() async {
    DataSnapshot dataSnapshot = await databaseReference.child('random/').once();
    List<RandomNumber> randoms = [];
    if (dataSnapshot != null) {
      dataSnapshot.value.forEach((k, v) {
        var random = RandomNumber.fromJson(v);
        randoms.add(random);
      });
    }
    return randoms;
  }
}
