import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:locate_resto/api/produit-dao.dart';
import 'package:locate_resto/models/user.dart';
import 'package:locate_resto/views/home/hotel/accueil.dart';
import 'package:provider/provider.dart';

import 'client/accueil.dart';

class HomeWrapper extends StatelessWidget {
  UserData useConnected;
  String uid;
  String fullName = '';
  String profile = '';
  String email = '';
  String password = '';
  String telephone = '';
  double latitude = 0.0;
  double longitude = 0.0;
  String urlImage = '';

  @override
  Widget build(BuildContext context) {
    // CollectionReference users = FirebaseFirestore.instance.collection('users');
    final user = Provider.of<Utilisateur>(context);

    return FutureBuilder<DocumentSnapshot>(
      future: UserDao(uid: user.uid).userCollection.doc(user.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          this.useConnected = UserData(
              uid: data['uid'],
              fullName: data['fullName'],
              profile: data['profile'],
              email: data['email'],
              password: data['password'],
              telephone: data['telephone'],
              latitude: data['latitude'],
              longitude: data['longitude'],
              urlImage: data['urlImage']);

              if (useConnected.profile =='Client') {
                return HomeUser(useConnected);
              } else {
                return HomeUser(useConnected);
              }
          // return Text("Full Name: ${data['fullName']} ${data['profile']}== ${this.useConnected.email}");
        }

        return Text("loading");
      },
    );
  }

  // getUserInfo(){
  //   UserDao(uid:uid).userCollection.doc(uid).get().then((docSnap) =>
  //   {
  //     this.uid = docSnap.data()['uid'],
  //     this.fullName = docSnap.data()['fullName'],
  //     this.profile = docSnap.data()['profile'],
  //     this.email = docSnap.data()['email'],
  //     this.password = docSnap.data()['password'],
  //     this.telephone = docSnap.data()['telephone'],
  //     this.latitude = docSnap.data()['latitude'],
  //     this.longitude = docSnap.data()['longitude'],
  //     print(docSnap.data()['fullName']),
  //     this.urlImage = docSnap.data()['urlImage'],
  //     this.useConnected = UserData(uid:uid, fullName:fullName,profile: profile,email:email,password:password,telephone:telephone,latitude:latitude,longitude:longitude,urlImage:urlImage),
  //   });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   final user = Provider.of<Utilisateur>(context);
  //   this.uid = user.uid;
  //   getUserInfo();

  //   // return either the Home or Authenticate widget
  //   print('44444444444444444444444444444444444444444444444444444444444');
  //   print(fullName);

  //   print(useConnected);
  //   if (useConnected.profile =='Client') {
  //     return HomeUser(useConnected);
  //   } else {
  //     return HomeHotel(useConnected);
  //   }
  // }
}
