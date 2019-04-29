import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class signUp extends StatefulWidget {
  FirebaseAuth _auth;
  signUp(this._auth); // constructor
  @override
  State<StatefulWidget> createState() => _MySignUpState(_auth);
}

class _MySignUpState extends State<signUp> {
  final myControllerUserName = TextEditingController();
  final myControllerPassword = TextEditingController();
  FirebaseAuth _auth;
  _MySignUpState(this._auth);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign in with Email :)"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Enter your username'),
              controller: myControllerUserName,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Enter your password'),
              controller: myControllerPassword,
               obscureText: true, // for password to be invisible
            ),
            FlatButton(
              child: Text("Create Account"),
              onPressed: ()=> _signUp(myControllerUserName,myControllerPassword),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Future<FirebaseUser> _signUp(TextEditingController myControllerUserName,TextEditingController myControllerPassword) async {
    print("$myControllerUserName");
    String email1 = (myControllerUserName.text).toString();
    String pass1 = (myControllerPassword.text).toString();
    FirebaseUser user = await _auth
        .createUserWithEmailAndPassword(
            email: email1, password: pass1)
        .then((user) {
      print("User Created ${user.displayName}");
      print("Email : ${user.email}");
    });
    print("User Created2 ${user.displayName}");
    print("Email2 : ${user.email}");
    return user;
  }
}
