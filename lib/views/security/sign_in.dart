import 'package:locate_resto/controllers/security/security-mgr.dart';
import 'package:locate_resto/views/shared/constants.dart';
import 'package:locate_resto/views/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final SecurityMgr _auth = SecurityMgr();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            //  backgroundColor: Colors.brown[100],
            appBar: AppBar(
              // backgroundColor: Colors.brown[400],
              // elevation: 0.0,
              title: Text('Connexion'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('S\'inscrir'),
                  onPressed: () => widget.toggleView(),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Image.asset('assets/logo.png',
                          height: 100.0, width: 100.0),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(labelText: 'Email'),
                        validator: (val) =>
                            val.isEmpty ? 'Mettez un email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        obscureText: true,
                        decoration:
                            textInputDecoration.copyWith(labelText: 'password'),
                        validator: (val) => val.length < 6
                            ? 'Entrez au moins 6 charactères'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                          color: Colors.orange,
                          child: Text(
                            'Connexion',
                            style: TextStyle(color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error = 'Login ou mot de passe incorrecte';
                                });
                              }
                            }
                          }),
                      OutlineButton(
                        onPressed: () => widget.toggleView(),
                        borderSide: BorderSide(width: 1.0, color: Colors.black),
                        child: Text('Créer un nouveau compte'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
