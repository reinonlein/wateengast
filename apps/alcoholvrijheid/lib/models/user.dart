class User {
  final String uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final DateTime stopdate;
  final String sugars;
  final int strength;

  UserData({this.uid, this.name, this.stopdate, this.sugars, this.strength});
}
