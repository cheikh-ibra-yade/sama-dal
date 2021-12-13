import 'package:locate_resto/api/position-dao.dart';
import 'package:locate_resto/models/position.dart';
import 'package:locate_resto/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDao {
  final String uid;
  final PositionDao positionDao = PositionDao();
  UserDao({this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // TODO: doit être nommé creatUser
  Future<void> updateUserData(String email, String password, String fullName,
      String profile, String telephone, double latitude, double longitude, String urlImage) async {
        //Ajouter la position to DB
    //positionDao.add(uid, position.lat, position.lng);
    return await userCollection.doc(uid).set({
      'email': email,
      'password': password,
      'fullName': fullName,
      'profile': profile,
      'telephone': telephone,
      'latitude': latitude,
      'longitude': longitude,
      'urlImage': urlImage,
    });
  }

  // UserData list from snapshot
  List<UserData> _UserDataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return UserData(
          uid: doc.data()['uid'] ?? '',
          fullName: doc.data()['fullName'] ?? '',
          profile: doc.data()['profile'] ?? '',
          email: doc.data()['email'] ?? '',
          password: doc.data()['password'] ?? '',
          telephone: doc.data()['telephone'] ?? '',
          latitude: doc.data()['latitude'] ?? '',
          longitude: doc.data()['longitude'] ?? '',
          urlImage: doc.data()['urlImage'] ?? '',
          //position: positionDao.convert(positionDao.)
      );
    }).toList();
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        fullName: snapshot.data()['fullName'],
        profile: snapshot.data()['profile'],
        email: snapshot.data()['email'],
        password: snapshot.data()['password'],
        telephone: snapshot.data()['telephone'],
        latitude: snapshot.data()['latitude'],
        longitude: snapshot.data()['longitude'],
        urlImage: snapshot.data()['urlImage'],
        );
  }


  // get UserDatas stream
  Stream<List<UserData>> get UserDatas {
    return userCollection.snapshots().map(_UserDataListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  // // get user doc stream
  // UserData get uidata {
  //   return userCollection.doc(uid).get().then((value) => {
  //     return new UserData();
  //   });
  // }
}
