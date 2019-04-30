import 'package:flutter/material.dart';
import '../ChatRoom/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../ChatRoom/create_chatRoom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../SignUp/loginsignup.dart';
//import "dart.io";
//import 'package:web_socket_channel/web_socket_channel.dart';
//import 'package:web_socket_channel/io.dart';
//import 'package:web_socket';

class ChatHomePage extends StatelessWidget{
  final String userId ;
  final String chatId;
  ChatHomePage(this.userId, this.chatId);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(appBar: new AppBar(
      title: new Text("Frenzy Chat"),
    ),
        body: new ChatScreen(userId,chatId)
    );

  }
}
