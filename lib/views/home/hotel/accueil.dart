import 'package:flutter/material.dart';
import 'package:locate_resto/models/user.dart';
class HomeHotel extends StatefulWidget {
  UserData utilisateur;
  HomeHotel(this.utilisateur);
  @override
  _HomeHotelState createState() => _HomeHotelState();
}

class _HomeHotelState extends State<HomeHotel> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('HomeHotel'),);
  }
}
