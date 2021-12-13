import 'package:locate_resto/views/home/brew_list.dart';
import 'package:locate_resto/views/home/settings_form.dart';
import 'package:locate_resto/api/user-dao.dart';
import 'package:flutter/material.dart';
import 'package:locate_resto/controllers/security/security-mgr.dart';
import 'package:locate_resto/models/user.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  final SecurityMgr _auth = SecurityMgr();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<UserData>>.value(
      value: UserDao().UserDatas,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: null
        // Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage('assets/coffee_bg.png'),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        //   child: BrewList()
        // ),
      ),
    );
  }
}