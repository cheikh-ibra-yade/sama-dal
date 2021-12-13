import 'package:locate_resto/choose-location.dart';
import 'package:locate_resto/map.dart';
import 'package:locate_resto/models/user.dart';
import 'package:locate_resto/views/home/client/accueil.dart';
import 'package:locate_resto/views/security/authenticate.dart';
import 'package:locate_resto/views/home/home-wrapper.dart';
import 'package:flutter/material.dart';
import 'package:locate_resto/views/security/connexion.dart';
import 'package:locate_resto/views/security/register.dart';
import 'package:locate_resto/views/shared/chargement.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Utilisateur>(context);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return HomeWrapper();
    }
  }
}
