class User {
  final String uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final DateTime stopdate;
  final int geld;
  final int bier;
  final int wijn;
  final int sterk;
  final int katers;
  final DateTime creationTime;
  final DateTime lastSignInTime;
  final DateTime userLastSeenTime;

  UserData({
    this.uid,
    this.name,
    this.stopdate,
    this.geld,
    this.bier,
    this.wijn,
    this.sterk,
    this.katers,
    this.creationTime,
    this.lastSignInTime,
    this.userLastSeenTime,
  });
}
