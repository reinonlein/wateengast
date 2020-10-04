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
  Future updateUserData(String sugars, String name, int strength) async {
    return await alcoholvrijheidCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // alcoholvrijerds list from snapshot
  List<Alcoholvrijerd> _alcoholvrijerdsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Alcoholvrijerd(
        name: doc.data()['name'] ?? '',
        strength: doc.data()['strength'] ?? 0,
        sugars: doc.data()['sugars'] ?? '0',
      );
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      strength: snapshot.data()['strength'],
      sugars: snapshot.data()['sugars'],
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
