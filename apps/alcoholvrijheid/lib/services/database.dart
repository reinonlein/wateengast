import 'package:alcoholvrijheid/models/alcoholvrijerd.dart';
import 'package:alcoholvrijheid/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  // final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  // collection reference AV
  final CollectionReference alcoholvrijheidCollection =
      FirebaseFirestore.instance.collection('alcoholvrijheid');

  // update alcoholvrij users
  Future updateUserData(String name, DateTime stopdate, String sugars, int strength) async {
    return await alcoholvrijheidCollection.doc(uid).set({
      'name': name,
      'stopdate': Timestamp.fromDate(stopdate),
      'sugars': sugars,
      'strength': strength,
    });
  }

  // alcoholvrijerds list from snapshot
  List<Alcoholvrijerd> _alcoholvrijerdsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Alcoholvrijerd(
        name: doc.data()['name'] ?? '',
        stopdate: doc.data()['stopdate'].toDate() ?? DateTime.now(),
        sugars: doc.data()['sugars'] ?? '0',
        strength: doc.data()['strength'] ?? 0,
      );
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      stopdate: snapshot.data()['stopdate'].toDate(),
      sugars: snapshot.data()['sugars'],
      strength: snapshot.data()['strength'],
    );
  }

  // get alcoholvrijerds stream
  Stream<List<Alcoholvrijerd>> get alcoholvrijerds {
    return alcoholvrijheidCollection.snapshots().map(_alcoholvrijerdsListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return alcoholvrijheidCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
