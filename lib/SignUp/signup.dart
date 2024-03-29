import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../User/homePage.dart';

class signUp extends StatefulWidget {
  FirebaseAuth _auth;
  signUp(this._auth); // constructor
  @override
  State<StatefulWidget> createState() => _MySignUpState(_auth);
}

class _MySignUpState extends State<signUp> {
  final myControllerEmail = TextEditingController();
  final myControllerUsername = TextEditingController();
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
              decoration: InputDecoration(labelText: 'Enter your email'),
              controller: myControllerEmail,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Enter your Username'),
              controller: myControllerUsername,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Enter your password'),
              controller: myControllerPassword,
              obscureText: true, // for password to be invisible
            ),
            FlatButton(
              child: Text("Create Account"),
              onPressed: () => _signUp(myControllerEmail, myControllerUsername,
                  myControllerPassword),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }


  _signUp(
      TextEditingController myControllerEmail,
      TextEditingController myControllerUsername,
      TextEditingController myControllerPassword) async {
    print("$myControllerEmail");
    String email = (myControllerEmail.text).toString();
    String pass = (myControllerPassword.text).toString();
    String userName = (myControllerUsername.text).toString();
    FirebaseUser user = await _auth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((user) async {
      print("Email : ${user.email}");
      if (user != null) {
        // Update data to server if new user
        Firestore.instance.collection('users').document(user.uid).setData({
          'username': userName, //user.displayName, // No display name here !
          'email': user.email,
          'id': user.uid
        });
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePage(user.uid)));
      }
//        else  // Not a new user ?
//          {
//
//        }
    });

//    return user;
  }


}
