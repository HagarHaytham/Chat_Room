import 'package:flutter/material.dart';
import 'chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Room',
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget{
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen>{
  final TextEditingController _textController = new TextEditingController();
  final List<ChatMessage> _messages=<ChatMessage> [];

  void _handleSubmitted(String text){
    _textController.clear();
    ChatMessage message =new ChatMessage(
      text: text,
    );
    setState(() {
      _messages.insert(0, message) ;
    });
    Firestore.instance.collection('chatrooms').document('-LdeA9MXmmNkvU40qFEV').collection('message').document('IzWdkPgf3sBTq3V5ua5r').setData({
      'Content': text, //user.displayName, // No display name here !
      'Owner' : 'anaa'
    });
  }

  Widget _textComposerWidget(){
    return new IconTheme(
        data: IconThemeData(color: Colors.blue),
        child: new Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: new Row(
              children: <Widget>[
                new Flexible(
                  child: new TextField(
                    decoration: new InputDecoration.collapsed(hintText: "Send a message"),
                    controller: _textController,
                    onSubmitted: _handleSubmitted,
                  ),

                ),
                new Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: new IconButton(
                    icon: new Icon(Icons.send),
                    onPressed: () =>_handleSubmitted(_textController.text),
                  ),
                )
              ],)
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    return  new Column(
      children: <Widget>[
        new Flexible(
          child: new ListView.builder(
            padding: new EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_,int index) => _messages[index],
            itemCount: _messages.length,
          ),
        ),
        new Divider(height: 1.0,),
        new Container(
          decoration: new BoxDecoration(
              color: Theme.of(context).cardColor
          ),
          child: _textComposerWidget(),
        )
      ],
    );
  }
}