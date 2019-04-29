import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class signUp extends StatefulWidget {
  FirebaseAuth _auth;
  signUp(this._auth); // constructor
  @override
  State<StatefulWidget> createState() => _MySignUpState(_auth);
}

class _MySignUpState extends State<signUp> {
  final myControllerEmail = TextEditingController();
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
              decoration: InputDecoration(labelText: 'Enter your password'),
              controller: myControllerPassword,
               obscureText: true, // for password to be invisible
            ),
            FlatButton(
              child: Text("Create Account"),
              onPressed: ()=> _signUp(myControllerEmail,myControllerPassword),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  _signUp(TextEditingController myControllerUserName,TextEditingController myControllerPassword) async {
    print("$myControllerUserName");
    String email1 = (myControllerUserName.text).toString();
    String pass1 = (myControllerPassword.text).toString();
    FirebaseUser user = await _auth
        .createUserWithEmailAndPassword(
            email: email1, password: pass1).then((user) async {
      print("Email : ${user.email}");
      if (user != null) {
        // Check is already sign up
        final QuerySnapshot result = await Firestore.instance.collection(
            'users').where(
            'id', isEqualTo: user.uid).getDocuments();
        final List<DocumentSnapshot> documents = result.documents;
        if (documents.length == 0) {
          // Update data to server if new user
          Firestore.instance.collection('users').document(user.uid).setData(
              {
                'username': user.displayName,
                'email': user.email,
                'id': user.uid
              });
        }
//        else  // Not a new user ?
//          {
//
//        }
      }
    });
    }
//    return user;

  }


