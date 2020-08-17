import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = Firestore.instance;
FirebaseUser currentUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String textToSend;
  final TextEditingController textController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        currentUser = user;
        print(currentUser);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStreamer(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textController,
                      onChanged: (value) {
                        textToSend = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      try {
                        print(textToSend);
                        textController.clear();
                        firestore.collection(kCollection_id).add({
                          kTextField: textToSend,
                          kSenderField: currentUser.email,
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStreamer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: firestore.collection(kCollection_id).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return CircularProgressIndicator(
              backgroundColor: Colors.lightBlue,
            );
          else {
            List<MessageBubber> snaps = [];
            final messages = snapshot.data.documents.reversed;

            for (var message in messages) {
              final messageText = message.data[kTextField];
              final messageSender = message.data[kSenderField];
              snaps.add(MessageBubber(
                  message: messageText,
                  sender: messageSender,
                  isMe: currentUser.email == messageSender));
            }
            return Expanded(child: ListView(reverse: true, children: snaps));
          }
        });
  }
}

class MessageBubber extends StatelessWidget {
  MessageBubber(
      {@required this.sender, @required this.message, @required this.isMe});
  final String sender;
  final String message;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text('$sender',
              style: TextStyle(color: Colors.black54, fontSize: 12)),
          Material(
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            elevation: 5,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
                topLeft: isMe ? Radius.circular(30) : Radius.circular(0),
                topRight: isMe ? Radius.circular(0) : Radius.circular(30)),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Text('$message',
                    style: TextStyle(
                        color: isMe ? Colors.white : Colors.black54,
                        fontSize: 15))),
          ),
        ],
      ),
    );
  }
}
