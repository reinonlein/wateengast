import 'package:alcoholvrijheid/models/user.dart' as userClass;
import 'package:alcoholvrijheid/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on FirebaseUser
  userClass.User _userFromFirebaseUser(User user) {
    return user != null ? userClass.User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<userClass.User> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign in anonymous
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      await DatabaseService(uid: user.uid).updateUserSigninTime(DateTime.now());

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result =
          await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(
        'Gast',
        DateTime.now(),
        0,
        0,
        0,
        0,
        0,
        DateTime.now(),
        DateTime.now(),
        DateTime.now(),
      );

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
