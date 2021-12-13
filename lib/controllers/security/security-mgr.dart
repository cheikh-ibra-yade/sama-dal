import 'package:firebase_auth/firebase_auth.dart';
import 'package:locate_resto/api/user-dao.dart';
import 'package:locate_resto/models/user.dart';

//UserCredential pour Flus incrir
//User = firbase user

class SecurityMgr {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create user obj based on firebase user
  //
  // TODO: utilise directement UserData ()=> change main Stream<UserD..>
  Utilisateur _userFromFirebaseUser(User userCredential) {
    return userCredential != null ? Utilisateur(uid: userCredential.uid) : null;
  }

  // auth change user stream
  Stream<Utilisateur> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign in anon
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

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      //#################TODO:Returner User with actu localisation SI Profile == Client |OU| trier Liste Prestataire in Akti local
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(
      String email,
      String password,
      String fullName,
      String profile,
      String telephone,
      double lat,
      double lng,
      String urlImage) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      // create a new document for the user with the uid
      await UserDao(uid: user.uid).updateUserData(
          email, password, fullName, profile, telephone, lat, lng,urlImage);

      //#################TODO:Returner User with actu localisation SI Profile == Client |OU| trier Liste Prestataire in Akti local
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
