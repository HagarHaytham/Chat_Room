import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

class LoginSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up / Sign in"),
      ),
      body:Center(
        child : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // google sign in not working
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                child : Text("Google Sign in"),
                onPressed: ()=>_gSignIn(),
                color: Colors.red,
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton (
                child: Text("Create Account"),
                onPressed: ()=> _createUser(context),
                color: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton (
                child: Text("Log in"),
                onPressed: (){},// To Do
                color: Colors.deepPurple,
              ),
            ),

//          new Image.network(_imageUrl == null || _imageUrl.isEmpty ?
//            'https://picsum.photos/250?image=9' :_imageUrl),
          ],
        ),
      ),
    );
  }

  Future<FirebaseUser> _gSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = await _auth.signInWithCredential(credential);
    print("signed in " + user.displayName);

//    setState(() {
//      _imageUrl = user.photoUrl;
//    });
    return user;
  }

  _createUser(BuildContext context)  {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => signUp(_auth)),
    );
  }

}