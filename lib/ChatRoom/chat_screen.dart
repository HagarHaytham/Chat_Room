import 'package:flutter/material.dart';
import 'chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//class CreateChatScreen extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Chat Room',
//      home: ChatScreen(),
//    );
//  }
//}

class ChatScreen extends StatefulWidget{
  String userId;
  String chatRoomId;
  ChatScreen(this.userId,this.chatRoomId);
  State createState() => new ChatScreenState(userId,chatRoomId);
}

class ChatScreenState extends State<ChatScreen>{
  String userId;
  String chatRoomId;
  ChatScreenState(this.userId,this.chatRoomId);
  final TextEditingController _textController = new TextEditingController();
  final List<ChatMessage> _messages=<ChatMessage> [];

  void _handleSubmitted(String text){
    _textController.clear();
    ChatMessage message =new ChatMessage(
      text: text,
    );
    setState(() {
      //_messages =  Firestore.instance.collection('chatrooms').document(chatRoomId).snapshots();
    });

    // Send to database
    Firestore.instance.collection('chatrooms').document(chatRoomId).collection('message').document(DateTime.now().millisecondsSinceEpoch.toString())
        .setData({
      'Content': text, //user.displayName, // No display name here !
      'Owner' : userId,
      'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
    });

    //ChatMessage receive = new ChatMessage(
      //text: Firestore.instance.collection('chatrooms').document(chatRoomId).snapshots(),
    //)
    //_messages.insert(0, element)
    // Recieve ?!!
    /*Firestore.instance.collection('chatrooms')
        .document(chatRoomId)
        .collection('message')
        .orderBy('timestamp', descending: true)
        .limit(20)
        .snapshots();
        */
    //TODO
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
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('chatrooms').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

    Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot){

    return  new Column(
      children: <Widget>[
        new ListView(
          padding: new EdgeInsets.all(8.0),
          children: snapshot.map((data) => _buildListItem(context, data)),
        ),
        /*new Flexible(
          child: new ListView.builder(
            padding: new EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_,int index) => record,//_messages[index],
            itemCount: _messages.length,

          ),
        ),*/
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

Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  final record = Record.fromSnapshot(data);
}

class Record {
  final String name;
  final String admin;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['admin'] != null),
        assert(map['name'] != null),
        name = map['name'],
        admin = map['admin'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}