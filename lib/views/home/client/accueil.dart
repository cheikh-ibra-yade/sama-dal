import 'package:flutter/material.dart';
import 'package:locate_resto/controllers/security/security-mgr.dart';
import 'package:locate_resto/models/user.dart';
import 'package:locate_resto/views/home/client/list-hotel.dart';
class HomeUser extends StatefulWidget {
  UserData utilisateur;
  HomeUser(this.utilisateur);
  @override
  _HomeUserState createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  SecurityMgr security = SecurityMgr();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Hôtels'),
        //backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(
              Icons.logout,
            ),
            onPressed: () => showDialog(context: context, builder: (context)
            => _boiteDeDialogue(context, widget.utilisateur.fullName, widget.utilisateur.email)),
          )
        ],
      ),
      body: ListHotel(),
    );
  }


  //Dialog Déconnexion
  Widget _boiteDeDialogue(BuildContext, String nom, String email){

    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text('$nom',
              style: Theme.of(context).textTheme.title),
              Text('$email',
                  style: Theme.of(context).textTheme.subtitle),
              SizedBox(height: 10.0),
              Wrap(
                children: <Widget>[
                  FlatButton(
                    child: Text('DECONNEXION'),
                    color: Colors.amber,
                    onPressed: () async {
                      await security.signOut();
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                  ),
                  FlatButton(
                    child: Text('ANNULER'),
                  onPressed: (){
                      setState(() {
                        Navigator.pop(context);
                      });
                  })
                ],
              )
            ],
          ),
        )
      ],
    );
  }

}
