import 'package:flutter/material.dart';
import 'package:whatsapp/Chats_Widget/chat_bodyLayout.dart';

class ChatLayout extends StatelessWidget {
  final String name;
  final String uid;
  final String profilePic;
  const ChatLayout({required this.name, required this.uid,required this.profilePic, super.key});
  static const String routeName = "/ChatLayout";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: const Color(0xff075E57),
      leading:  Padding(
        padding: const EdgeInsets.only(right: 1, top: 5, bottom: 5, left: 10),
        child: CircleAvatar(
          backgroundImage: NetworkImage(
               profilePic),
        ),
      ),
      title: Text(name),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.video_call),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.call),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert),
        ),
      ],
    ),
    body:  ChatBodyLayout(uid: uid,receiverUserId: uid),
    );
  }
}
