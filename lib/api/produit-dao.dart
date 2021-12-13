import 'package:locate_resto/models/user.dart';
import 'package:locate_resto/models/produit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDao {
  final String uid;
  UserDao({this.uid});
  //final UserData userData;

  // collection reference
  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(
      String email,
      String password,
      String fullName,
      String profile,
      String telephone,
      double latitude,
      double longitude) async {
    return await userCollection.doc(uid).set({
      'email': email,
      'password': password,
      'fullName': fullName,
      'profile': profile,
      'telephone': telephone,
      'latitude': latitude,
      'longitude': longitude,
    });
  }

  // Produit list from snapshot
  List<UserData> _ProduitListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return UserData(
          password: doc.data()['password'] ?? '',
          fullName: doc.data()['fullName'] ?? 0,
          email: doc.data()['email'] ?? '0');
    }).toList();
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        password: snapshot.data()['password'],
        email: snapshot.data()['email'],
        fullName: snapshot.data()['fullName']);
  }

  // user data from snapshots
  UserData _userDataFromDocref(DocumentSnapshot doc) {
    return UserData(
        uid: uid,
        password: doc.data()['password'],
        email: doc.data()['email'],
        fullName: doc.data()['fullName']);
  }

  // get Produits stream
  Stream<List<UserData>> get Produits {
    return userCollection.snapshots().map(_ProduitListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  // get user doc stream
  // UserData get userDataRef {
  //   return userCollection.doc(uid).get().then((doc) => {
  //     value.d
  //   });
  // }
}
