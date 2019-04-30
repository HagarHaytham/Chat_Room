import 'package:flutter/material.dart';
import './SignUp/loginsignup.dart';
import 'User/homePage.dart';


void main() => runApp(MyApp());

//Haneen main
/*class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new MaterialApp(title: 'HomePage', home: new HomePage());
  }
}*/


//Mary main
// class MyApp extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(title: "Chat App", home: new HomePage());

//   }

// }

//Hagar main
class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Room App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginSignUpPage(),//MyHomePage(),
    );
  }
}