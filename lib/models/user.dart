import 'package:locate_resto/models/position.dart';

class Utilisateur {
  final String uid;

  Utilisateur({this.uid});
}

class UserData {
  final String uid;
  final String fullName;
  final String profile;
  final String email;
  final String password;
  final String telephone;
  final double latitude;
  final double longitude;
  final String urlImage;
  //final Position position;

  UserData(
      {this.uid,
      this.fullName,
      this.profile,
      this.email,
      this.password,
      this.telephone,
      this.latitude,
      this.longitude,
      this.urlImage
      //this.position
      });
}
