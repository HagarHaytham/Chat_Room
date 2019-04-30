import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Chat',
      home: CreateChatForm(),
    );
  }
}

class CreateChatForm extends StatefulWidget {
  @override
  CreateChatFormState createState() {
    return CreateChatFormState();
  }
}

class CreateChatFormState extends State<CreateChatForm> {
  @override
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            title: Text('Retrieve Text Input'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: myController,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // When the user presses the button, show an alert dialog with the
          // text the user has typed into our text field.
          onPressed: () {
            Firestore.instance.collection('chatrooms').add(
              {"name": myController.text, "admin": null},
            );
          },
          tooltip: 'Show me the value!',
          child: Icon(Icons.text_fields),
        ));
  }
}
