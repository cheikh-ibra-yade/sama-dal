import 'package:flutter/material.dart';
import 'package:locate_resto/choose-location.dart';
import 'package:locate_resto/views/shared/chargement.dart';
import 'package:locate_resto/views/shared/photoView.dart';
import 'package:random_color/random_color.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailHotel extends StatefulWidget {
  final String uid, fullName, email, telephone, urlImage;
  final double latitude, longitude;
  DetailHotel(
      {this.uid,
      this.fullName,
      this.email,
      this.telephone,
      this.latitude,
      this.longitude,
      this.urlImage});

  @override
  _DetailHotelState createState() => _DetailHotelState();
}

class _DetailHotelState extends State<DetailHotel> {
  // FirebaseUser currentUser;
  bool chargement = false;

  static RandomColor _randomColor = RandomColor();

  Color _color =
      _randomColor.randomColor(colorBrightness: ColorBrightness.light);

  var lettreInitial;

  Widget affichageImage() {
    if (widget.urlImage.length > 0) {
      lettreInitial = "";
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      PhotoViewUrl(urlImage: widget.urlImage)));
        },
        child: CircleAvatar(
          radius: 90.0,
          backgroundImage: NetworkImage('${widget.urlImage}'),
        ),
      );
    } else {
      lettreInitial = widget.fullName[0];
      return CircleAvatar(
        radius: 70.0,
        backgroundColor: _color,
        child: Text(
          lettreInitial,
          style: Theme.of(context).textTheme.display4,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
    //   setState(() { // call setState to rebuild the view
    //     this.currentUser = user;
    //   });
    // });

    // String _idUtil(){
    //   if(currentUser != null){
    //     return currentUser.uid;
    //   }else{
    //     return 'pas id';
    //   }
    // }

    //  void _panneauDeSupression(){
    //   showModalBottomSheet(context: context, builder: (context){
    //     return Container(
    //       padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
    //       child: Column(
    //         children: <Widget>[
    //           Icon(Icons.ac_unit, color: Colors.red, size: 50.0),
    //           SizedBox(height: 10.0),
    //           Text('Voulez-vous supprimer ${widget.fullName} ${widget.postfullName}',
    //           style: Theme.of(context).textTheme.title),
    //           SizedBox(height: 10.0),
    //           FlatButton.icon(
    //             color: Colors.red,
    //             icon: Icon(Icons.delete, color: Colors.white,),
    //             label: Text('Supprimer', style: TextStyle(color: Colors.white),),
    //             onPressed: () async {

    //               setState(() {
    //                 Navigator.pop(context);
    //               });

    //               setState(() => chargement = true);

    //               await Firestore.instance.collection('utilisateurs').document(_idUtil())
    //                   .collection('contacts').document(widget.telephone).delete();

    //               Scaffold.of(context).showSnackBar(
    //                   SnackBar(
    //                     content: Text('${widget.fullName} ${widget.email}'
    //                         'supprimé(e) avec succès'),
    //                   )
    //               );

    //               setState(() {
    //                 Navigator.pop(context);
    //               });
    //             },
    //           )
    //         ],
    //       ),
    //     );
    //   });
    //  }

    _lancerLAppel() async {
      String url = 'tel:${widget.telephone}';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Impossible d\'appeller $url';
      }
    }

    _lancerSMS() async {
      String url = 'sms:${widget.telephone}';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Impossible de texter $url';
      }
    }

    _lancerGmail() async {
      String url = 'mailto:${widget.email}';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Impossible d\'envoyer le mail à $url';
      }
    }

    return chargement
        ? Chargement()
        : Scaffold(
            appBar: AppBar(
              //backgroundColor: Colors.white,
              title: Text('${widget.fullName}'),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.map), onPressed: () => _goToLocation(context)),
              ],
            ),
            body: Column(
              children: <Widget>[
                SizedBox(height: 10.0),
                affichageImage(),
                Divider(
                  height: 20.0,
                  color: Colors.orange,
                ),
                Text('${widget.fullName} ${widget.email}',
                    style: Theme.of(context).textTheme.display1),
                Divider(
                  height: 20.0,
                  // color: Colors.grey[800],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTap: _lancerLAppel,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.phone, color: Colors.pink),
                          Text(
                            'Appel',
                            style: TextStyle(color: Colors.pink),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: _lancerSMS,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.sms, color: Colors.pink),
                          Text(
                            'SMS',
                            style: TextStyle(color: Colors.pink),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: _lancerGmail,
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.email, color: Colors.pink),
                          Text(
                            'Email',
                            style: TextStyle(color: Colors.pink),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Divider(
                  height: 20.0,
                  // color: Colors.grey[800],
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10.0,
                    ),
                    Icon(Icons.phone),
                    SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.telephone,
                          style: Theme.of(context).textTheme.title,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Mobil',
                          style: Theme.of(context).textTheme.title,
                        ),
                      ],
                    )
                  ],
                ),
                Divider(
                  height: 20.0,
                  // color: Colors.grey[800],
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10.0,
                    ),
                    Icon(Icons.mail),
                    SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.email,
                          style: Theme.of(context).textTheme.title,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Email',
                          style: Theme.of(context).textTheme.title,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _goToLocation(context);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => ModifierContact(),
                //         settings: RouteSettings(arguments: {
                //           'urlImage': widget.urlImage,
                //           'fullName': widget.fullName,
                //           'postfullName': widget.postfullName,
                //           'email': widget.email,
                //           'telephone': widget.telephone,
                //         })));
              },
              child: Icon(Icons.location_city),
            ),
          );
  }

  _goToLocation(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChooseLocation(),settings: RouteSettings(
          arguments: {
            'lat' : widget.latitude,
            'lng' : widget.longitude
          }
      )),
    );

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    // ScaffoldMessenger.of(context)
    //   ..removeCurrentSnackBar()
    //   ..showSnackBar(SnackBar(content: Text("${positionChosen['lat']}")));
  }
}


