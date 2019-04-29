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
//      print("User Created ${user.displayName}");
      print("Email : ${user.email}");
//      Map <String,String> data = <String,String>{
//        "email" : email1,
////        "Email": "${user.email}",
////      "Name" : "${user.displayName}",
//      };
      Firestore.instance.collection('users').document()
          .setData({ 'email': '$email1'});
//      final DocumentReference documentReference = Firestore.instance.document("users");
//      documentReference.setData(data).whenComplete((){
//        print("Document Added");
//      }).catchError((e)=> print(e));
    });
//    print("User Created2 ${user.displayName}");
//    print("Email2 : ${user.email}");



//    print("signed in " + user.displayName);
    return user;
  }

}
