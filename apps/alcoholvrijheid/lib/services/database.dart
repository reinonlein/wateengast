import 'package:alcoholvrijheid/models/alcoholvrijerd.dart';
import 'package:alcoholvrijheid/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  // final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  // collection reference AV
  final CollectionReference alcoholvrijerdsCollection =
      FirebaseFirestore.instance.collection('alcoholvrijerds');

  // update alcoholvrij users
  Future updateUserData(String sugars, String name, int strength) async {
    return await alcoholvrijerdsCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // update brew users
  // Future updateUserData(String sugars, String name, int strength) async {
  //   return await brewCollection.doc(uid).set({
  //     'sugars': sugars,
  //     'name': name,
  //     'strength': strength,
  //   });
  // }

  // brew list from snapshot
  List<Alcoholvrijerd> _alcoholvrijerdsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Alcoholvrijerd(
        name: doc.data()['name'] ?? '',
        strength: doc.data()['strength'] ?? 0,
        sugars: doc.data()['sugars'] ?? '0',
      );
    }).toList();
  }

  // // brew list from snapshot
  // List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return Brew(
  //       name: doc.data()['name'] ?? '',
  //       strength: doc.data()['strength'] ?? 0,
  //       sugars: doc.data()['sugars'] ?? '0',
  //     );
  //   }).toList();
  // }

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
    return alcoholvrijerdsCollection.snapshots().map(_alcoholvrijerdsListFromSnapshot);
  }

  // // get brews stream
  // Stream<List<Brew>> get brews {
  //   return brewCollection.snapshots().map(_brewListFromSnapshot);
  // }

  // get user doc stream
  Stream<UserData> get userData {
    return alcoholvrijerdsCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  // // get user doc stream
  // Stream<UserData> get userData {
  //   return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  // }
}
