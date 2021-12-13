import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:locate_resto/api/user-dao.dart';
import 'package:locate_resto/views/home/hotel/detail-hotel.dart';
import 'package:random_color/random_color.dart';

class ListHotel extends StatelessWidget {
  UserDao dao = UserDao();
  @override
  Widget build(BuildContext context) {
    
    Widget _buildListItem(DocumentSnapshot document) {
    var lettreInitial;

    Widget affichageImage() {
      RandomColor _randomColor = RandomColor();

      Color _color =
          _randomColor.randomColor(colorBrightness: ColorBrightness.light);

      if (document['urlImage'].length > 0) {
        lettreInitial = "";
        return CircleAvatar(
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage('${document['urlImage']}'),
        );
      } else {
        lettreInitial = document['fullName'][0];
        return CircleAvatar(
          backgroundColor: _color,
          child:
              Text(lettreInitial, style: Theme.of(context).textTheme.display1),
        );
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 32.0),
      child: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailHotel(
                          // uid: document['uid'] ?? '',
                          uid:  'uid',
                          fullName: document['fullName']?? '',
                          email: document['email'] ?? '',
                          telephone: document['telephone'] ?? '',
                          latitude: document['latitude']?? 0.0,
                          longitude: document['longitude']?? 0.0,
                          urlImage: document['urlImage']?? '')));
            },
            leading: affichageImage(),
            title: Text('${document['fullName']}',
                style: Theme.of(context).textTheme.title),
            subtitle: Text(' ${document['telephone']}'),
          ),
        ),
      ),
    );
  }

    
    
    return StreamBuilder(
      stream: dao.userCollection
          .where('profile', isEqualTo: 'Hotélier')
          //.orderBy('latitude')
          .snapshots(),
          //.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child:
                Text('chargement..', style: Theme.of(context).textTheme.title),
          );
        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) =>
              _buildListItem(snapshot.data.docs[index]),
        );
      },
    );


  }
  
}
