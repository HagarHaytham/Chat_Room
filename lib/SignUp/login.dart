import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../User/homePage.dart';

class logIn extends StatefulWidget {
  FirebaseAuth _auth;
  bool loginFailed ;//= false;
  logIn(this._auth,this.loginFailed); // constructor
  @override
  State<StatefulWidget> createState() => _MyLogInState(_auth,loginFailed);
}
class _MyLogInState extends State<logIn> {
  final myControllerEmail = TextEditingController();
  final myControllerPassword = TextEditingController();
  bool loginFailed ;//= false;
  FirebaseAuth _auth;
  _MyLogInState(this._auth,this.loginFailed);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log in Page"),
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

            Visibility(
              child: Text("invalid Email or password, Please Try again",
                style: new TextStyle(color: Colors.red ),
              ),
              visible: loginFailed,
            ),
            FlatButton(
              child: Text("Log in"),
              onPressed: () => _logIn(myControllerEmail,
                  myControllerPassword),
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  _logIn(
      TextEditingController myControllerEmail,
      TextEditingController myControllerPassword) async {
    String email = (myControllerEmail.text).toString();
    String pass = (myControllerPassword.text).toString();
    FirebaseUser user;
    try {
      user =
      await _auth.signInWithEmailAndPassword(email: email, password: pass);
    } catch (e) {
      print(e.toString());
    } finally {
      if (user != null) {
        // log in successful!
        // ex: bring the user to the home page
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePage(user.uid)));
      } else {
        // sign in unsuccessful
        // ex: prompt the user to try again
        loginFailed = true;
        print("Not Logged in");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => logIn(_auth,true)));
      }
    }
  }
}
