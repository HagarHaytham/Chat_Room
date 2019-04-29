import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
String _imageUrl;

  @override
  Widget build(BuildContext context) {

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
            child: FlatButton(
              child: Text("Sign in with Email"),
              onPressed: (){}, // To Do
              color: Colors.blue,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton (
              child: Text("Create Account"),
              onPressed: (){},
              color: Colors.white,
            ),
          ),
          new Image.network(_imageUrl == null || _imageUrl.isEmpty ?
            'https://picsum.photos/250?image=9' :_imageUrl),
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

    setState(() {
      _imageUrl = user.photoUrl;
    });
    return user;
  }
}
