import 'package:alcoholvrijheid/models/alcoholvrijerd.dart';
import 'package:alcoholvrijheid/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference AV
  final CollectionReference alcoholvrijheidCollection =
      FirebaseFirestore.instance.collection('alcoholvrijheid');

  // update alcoholvrij users
  Future updateUserData(
    String name,
    DateTime stopdate,
    int geld,
    int bier,
    int wijn,
    int sterk,
    int katers,
    DateTime creationTime,
    DateTime lastSignInTime,
    DateTime userLastSeenTime,
  ) async {
    return await alcoholvrijheidCollection.doc(uid).set({
      'name': name,
      'stopdate': Timestamp.fromDate(stopdate),
      'geld': geld,
      'bier': bier,
      'wijn': wijn,
      'sterk': sterk,
      'katers': katers,
      'creationTime': Timestamp.fromDate(creationTime),
      'lastSignInTime': Timestamp.fromDate(lastSignInTime),
      'userLastSeenTime': Timestamp.fromDate(userLastSeenTime),
    });
  }

  // update alcoholvrij settings
  Future updateUserSettings(
    String name,
    DateTime stopdate,
    int geld,
    int bier,
    int wijn,
    int sterk,
    int katers,
    DateTime userLastSeenTime,
  ) async {
    return await alcoholvrijheidCollection.doc(uid).update({
      'name': name,
      'stopdate': Timestamp.fromDate(stopdate),
      'geld': geld,
      'bier': bier,
      'wijn': wijn,
      'sterk': sterk,
      'katers': katers,
      'userLastSeenTime': userLastSeenTime,
    });
  }

  // update alcoholvrij users
  Future updateUserSigninTime(
    DateTime lastSignInTime,
  ) async {
    return await alcoholvrijheidCollection.doc(uid).update({
      'lastSignInTime': lastSignInTime,
    });
  }

  // update userLastSeenTime
  Future updateUserLastSeenTime(
    DateTime userLastSeenTime,
  ) async {
    return await alcoholvrijheidCollection.doc(uid).update({
      'userLastSeenTime': userLastSeenTime,
    });
  }

  // update alcoholvrij users
  Future updateReminders(
    List reminders,
  ) async {
    return await alcoholvrijheidCollection.doc(uid).update({
      'reminders': reminders,
    });
  }

  // alcoholvrijerds list from snapshot
  List<Alcoholvrijerd> _alcoholvrijerdsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Alcoholvrijerd(
        name: doc.data()['name'] ?? '',
        stopdate: doc.data()['stopdate'].toDate() ?? DateTime.now(),
        geld: doc.data()['geld'] ?? 0,
        bier: doc.data()['bier'] ?? 0,
        wijn: doc.data()['wijn'] ?? 0,
        sterk: doc.data()['sterk'] ?? 0,
        katers: doc.data()['katers'] ?? 0,
      );
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      stopdate: snapshot.data()['stopdate'].toDate(),
      geld: snapshot.data()['geld'],
      bier: snapshot.data()['bier'],
      wijn: snapshot.data()['wijn'],
      sterk: snapshot.data()['sterk'],
      katers: snapshot.data()['katers'],
      reminders: snapshot.data()['reminders'],
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
