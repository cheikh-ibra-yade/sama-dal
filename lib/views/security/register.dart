import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locate_resto/choose-location.dart';
import 'package:locate_resto/controllers/security/security-mgr.dart';
import 'package:locate_resto/models/myLocation.dart';
import 'package:locate_resto/views/shared/constants.dart';
import 'package:locate_resto/views/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final SecurityMgr _auth = SecurityMgr();
  //final MyLocation _position = MyLocation();
  Map positionChosen = {};
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  bool choosingImage = false;
  // Map labells = {'Client': 'Prénom et nom', 'Hotélier': 'Nom de l\'hôtel'};
  // String labDescription;

  final List<String> profiles = ['Client', 'Hotélier'];
  // var libelle = {
  //   'Client': 'Prénom et nom',
  //   'Prestataire': 'Nom de l\'entreprise'
  // };
  // String labelName;
  // this.labelName = this.libelle['Client'].toString();

  // text field state

  //Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  String email = '';
  String password = '';
  String fullName = '';
  String profile = 'Client';
  String telephone = '';
  String urlImage = '';
  double lng = 0;
  double lat = 0;

  File _fichierSelectionE;
  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {

    // positionChosen = ModalRoute.of(context).settings.arguments;
    //double lng = _position.longitude;
    //double lat = _position.latitude;
    //
    //TODO changer if want modifier in same page
    // labDescription = labells['Client'];
    return loading
        ? Loading()
        : Scaffold(
            // backgroundColor: Colors.brown[100],
            appBar: AppBar(
              // backgroundColor: Colors.brown[400],
              // elevation: 0.0,
              title: Text('Inscription'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Se connecter'),
                  onPressed: () => widget.toggleView(),
                  //onPressed: () => print(positionChosen),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              label: Text('Position'),
              icon: Icon(Icons.add_location_alt_outlined),
              onPressed: () {
                _navigateAndGetLatLng(context);
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) {
                //   return ChooseLocation();
                // }));
              },
              
            ),

            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              obtenirImage(ImageSource.gallery);
                            },
                            child: CircleAvatar(
                              radius: 70.0,
                              backgroundImage: _fichierSelectionE != null
                                  ? FileImage(_fichierSelectionE)
                                  : AssetImage('assets/logo.png'),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              obtenirImage(ImageSource.camera);
                            },
                            icon: Icon(Icons.camera, color: Colors.amber),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Text('Type de compte'),
                      DropdownButtonFormField(
                        value: 'Client',
                        decoration: textInputDecoration,
                        items: profiles.map((p) {
                          return DropdownMenuItem(
                            value: p,
                            child: Text('$p'),
                          );
                        }).toList(),
                        onChanged: (val) => setState(() => {profile = val}),
                      ),
                      SizedBox(height: 20.0),

                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'email'),
                        validator: (val) =>
                            val.isEmpty ? 'Mettez un email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'password'),
                        obscureText: true,
                        validator: (val) => val.length < 6
                            ? 'Entrez au moins 6 charactères'
                            : null,
                        onChanged: (val) {
                          setState(() => {password = val});
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: 'Nom complet'),
                        validator: (val) =>
                            val.isEmpty ? 'Mettez un Nom' : null,
                        onChanged: (val) {
                          setState(() => fullName = val);
                        },
                      ),
                      // SizedBox(height: 20.0),
                      // //TODO:Combo()
                      // TextFormField(
                      //   decoration:
                      //       textInputDecoration.copyWith(hintText: 'Profile'),
                      //   validator: (val) => val.isEmpty ? 'Mettez un email' : null,
                      //   onChanged: (val) {
                      //     setState(() => profile = val);
                      //   },
                      // ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Téléphone'),
                        validator: (val) =>
                            val.isEmpty ? 'Mettez un email' : null,
                        onChanged: (val) {
                          setState(() => telephone = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                          color: Colors.orange,
                          child: Text(
                            'Inscription',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: handleRegister),
                      SizedBox(height: 12.0),
                      // FlatButton.icon(
                      //   icon: Icon(Icons.person),
                      //   label: Text('Se connecter'),
                      //   onPressed: () => widget.toggleView(),
                      // ),
                      // SizedBox(height: 12.0),

                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  // Fonction
  obtenirImage(ImageSource source) async {
    setState(() {
      choosingImage = true;
    });

    final pickedFile = await picker.getImage(source: source);
    File image = File(pickedFile.path);
    if (image != null) {
      File croppE = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.png,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.white,
            toolbarTitle: 'Rognez l\'image',
            statusBarColor: Colors.amber,
            backgroundColor: Colors.black,
          ));
      this.setState(() {
        _fichierSelectionE = croppE;
        choosingImage = false;
      });
    } else {
      this.setState(() {
        choosingImage = false;
      });
    }
  }

  handleRegister() async {
    if (_formKey.currentState.validate()) {
      setState(() => loading = true);
      // Position position = await Geolocator.getCurrentPosition(
      //     desiredAccuracy: LocationAccuracy.high);
      await saveImge();
      dynamic result = await _auth.registerWithEmailAndPassword(email, password,
          fullName, profile, telephone, positionChosen['lat'], positionChosen['lng'],urlImage);
      if (result == null) {
        setState(() {
          loading = false;
          error = 'Mettez un Email Valide';
        });
      }
    }
  }

  saveImge() async {
    if (_fichierSelectionE == null) {
      return;
    }
    //Enreigistrement avec l'image
    firebase_storage.Reference reference =
        firebase_storage.FirebaseStorage.instance.ref().child('$fullName.png');
    // firebase_storage.UploadTask uploadTask = reference.putFile(_fichierSelectionE);
    //
    //firebase_storage.TaskSnapshot taskSnapshot = await uploadTask..onComplete;
    // this.urlImage = await (await uploadTask).ref.getDownloadURL();
    //-------------------------------------------------------------------
    firebase_storage.UploadTask uploadTask =
        reference.putFile(_fichierSelectionE);
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    this.urlImage = imageUrl.toString();
  }

  _navigateAndGetLatLng(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChooseLocation(),settings: RouteSettings(
            arguments: {
              'fullName' : this.fullName
            }
          )),
    );
    this.positionChosen = result;
    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    // ScaffoldMessenger.of(context)
    //   ..removeCurrentSnackBar()
    //   ..showSnackBar(SnackBar(content: Text("${positionChosen['lat']}")));
  }

}
