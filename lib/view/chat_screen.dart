import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

late User signedInUser; //هاد يلي بدو يعطيني الايميل

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance; //للمصداقية
  final _firestor = FirebaseFirestore.instance;
  TextEditingController messagecontroller = TextEditingController();
  //late User signedInUser; //هاد يلي بدو يعطيني الايميل
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        // print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async {
  //   final messages = await _firestor.collection("messages").get();
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }
  // void getmessagesStreams() async {
  //   await for (var snapshot in _firestor.collection("messages").snapshots()) {
  //     //
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  "assets/images/download1.png",
                  height: 40,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text('MessageMe'),
          ],
        ),
        backgroundColor: Colors.blue,
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: IconButton(
                onPressed: () {
                  ();
                  _auth.signOut();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close)),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MessageStreamBuilder(firestor: _firestor),
            Container(
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.blue, width: 2))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messagecontroller,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          hintText: "Write your message here....",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          // final messageText = messagecontroller.text.trim();
                          // if (messageText.isNotEmpty &&
                          //     signedInUser.email != null)
                          _firestor.collection("messages").add({
                            "text": messagecontroller.text,
                            "sender": signedInUser.email,
                            'time': FieldValue.serverTimestamp(),
                          });
                          messagecontroller.clear();
                        },
                        child: Text(
                          "Send",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 2, 58, 104),
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({
    super.key,
    required FirebaseFirestore firestor,
  }) : _firestor = firestor;

  final FirebaseFirestore _firestor;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestor.collection("messages").orderBy('time').snapshots(),
        builder: (context, snapshot) {
          List<Widget> messagewidgets = [];
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blueAccent,
              ),
            );
          }
          final messages = snapshot.data!.docs.reversed;
          for (var message in messages) {
            final messageText = message.get("text");
            final messageSender = message.get('sender');
            final curentUser = signedInUser.email;

            final messageWidget = MessageWidget(
              messageText: messageText,
              messageSender: messageSender,
              isMe: messageSender == curentUser,
            );

            messagewidgets.add(messageWidget);
          }
          return Expanded(
              child: ListView(
                  reverse: true,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  children: messagewidgets));
        });
  }
}

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.messageText,
    required this.messageSender,
    required this.isMe,
  });

  final dynamic messageText;
  final dynamic messageSender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            "$messageSender",
            style: TextStyle(fontSize: 12, color: Colors.blue),
          ),
          Material(
            elevation: 5,
            //decoration: BoxDecoration(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
            color: isMe ? Colors.blue : Colors.yellow,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Text(
                '$messageText',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
