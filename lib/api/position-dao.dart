import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locate_resto/models/position.dart';

class PositionDao {
  CollectionReference positionsRef =
      FirebaseFirestore.instance.collection('positions');

  void add(String uid, double lat, double lng) async {
    await positionsRef.doc(uid).set({'lat': lat, 'lng': lng});
  }

  void update(String id, double lat, double lng) {}

  // Stream<Position> find(String uid) {
  //   // ignore: todo
  //   //TODO:

  //   return positionsRef.doc(uid).snapshots().map((DocumentSnapshot docSnap) => {
  //         Position(
  //           lat: docSnap.data()['lat'],
  //           lng: docSnap.data()['lng'],
  //         )
  //       });
  // }

  // Stream<List<Position>> findAll(String uid) async {
  //   return positionsRef.snapshots().map((QuerySnapshot docSnap) => {
  //     docSnap.docs.map((docSnap) => {

  //     })

  //       });
  // }

  void remove() {}

  // UserData list from snapshot
  List<Position> findAll(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return Position(
        lat: doc.data()['lat'],
        lng: doc.data()['lng'],
      );
    }).toList();
  }

  // get UserDatas stream
  Stream<List<Position>> get positions {
    return positionsRef.snapshots().map(findAll);
  }

  // user data from snapshots
  Position convert(DocumentSnapshot snapshot) {
    return Position(
        lat: snapshot.data()['lat'],
        lng: snapshot.data()['lng'],
      );
  }
// get user doc stream
  Stream<Position> find(String uid) {
    return positionsRef.doc(uid).snapshots().map(convert);
  }
}
