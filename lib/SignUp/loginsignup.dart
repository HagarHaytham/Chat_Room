import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'signup.dart';
import 'login.dart';
import '../User/homePage.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();
//final DocumentReference documentReference = Firestore.instance.document("users/Email");

class LoginSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up / Sign in"),
          automaticallyImplyLeading: false, // To avoid showing  back button
      ),
      body:Center(
        child : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // google sign in not working
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: FlatButton(
                child : Text("Google Sign in"),
                onPressed: ()=>_gSignIn(context),
                color: Colors.red,
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(12.0),
              child: FlatButton (
                child: Text("Create Account"),
                onPressed: ()=> _createUser(context),
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: FlatButton (
                child: Text("Log in"),
                onPressed: ()=>_login(context),// To Do
                color: Colors.amberAccent,
              ),
            ),


//          new Image.network(_imageUrl == null || _imageUrl.isEmpty ?
//            'https://picsum.photos/250?image=9' :_imageUrl),
          ],
        ),
      ),
    );
  }

  _gSignIn(BuildContext context) async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print("GOOGLE SIGN IN 2 !!!!");
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    if (user != null) {
      // Check is already sign up
      final QuerySnapshot result =
      await Firestore.instance.collection('users').where(
          'id', isEqualTo: user.uid).getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        // Update data to server if new user
        Firestore.instance.collection('users').document(user.uid).setData(
            {
              'username': user.displayName,
              'email' : user.email,
//              'photoUrl': user.photoUrl,
              'id': user.uid
            });
      }
    }
    
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage(user.uid)));
  }

  _createUser(BuildContext context)  {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => signUp(_auth)),
    );
  }

  _login(BuildContext context)  {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LogIn(_auth,false)),
    );
  }

}