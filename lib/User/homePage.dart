import 'package:flutter/material.dart';
//import '../ChatRoom/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../ChatRoom/create_chatRoom.dart';
//import "dart.io";
//import 'package:web_socket_channel/web_socket_channel.dart';
//import 'package:web_socket_channel/io.dart';
//import 'package:web_socket';

/*class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(appBar: new AppBar(
      title: new Text("Frenzy Chat"),
    ),
        body: new ChatScreen()
    );

  }
}*/

//Haneen
class HomePage extends StatelessWidget{
  String userId ;
  HomePage(this.userId);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('HomePage'),
        ),
        body: new ChatRoomsList(),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Chatty'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),

              ListTile(
                title: Text('Create Chat Room'),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateChat()),
                  );
                },
              ),

              ListTile(
                title: Text('Join Chat Room'),
                onTap: (){

                  Navigator.pop(context);
                },
              ),

              ListTile(
                title: Text('Profile'),
                onTap: (){

                  Navigator.pop(context);
                },
              )
            ],
          ),),
    );

  }
}

class ChatRoomsList extends StatefulWidget{
  @override

  _ChatRoomsListState createState(){
    return _ChatRoomsListState();
  }
}

class _ChatRoomsListState extends State<ChatRoomsList>{
  @override

  Widget build(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('chatrooms').snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot){

    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          trailing: Text(record.admin),
          onTap: () => print(record),
        ),
      ),
    );
  }
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

