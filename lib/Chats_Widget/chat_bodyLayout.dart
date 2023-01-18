import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/Chats_Widget/chat_controller.dart';
import 'package:whatsapp/Chats_Widget/chat_textfield.dart';
import 'package:whatsapp/Chats_Widget/sender_card.dart';
import 'package:whatsapp/Models/message_Screen_model.dart';
import '../Common/dummydata.dart';
import '../Common/loader.dart';
import 'my_card.dart';

class ChatBodyLayout extends ConsumerWidget {
  final String uid;
  final String receiverUserId;
  const ChatBodyLayout({required this.uid,required this.receiverUserId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/image.png'), fit: BoxFit.cover)),
      child: Column(
        children: [
          Expanded(
              child: StreamBuilder<List<MessageScreenModel>>(
                stream: ref.watch(chatControllerProvider).streamMessage(receiverUserId),
                builder: (context,AsyncSnapshot<List<MessageScreenModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loader();
                    }
                  return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
                  var messageData = snapshot.data![index];
                  if (messages[index]["isMe"] == true) {
                    return MyCard(
                        message: messageData.text.trim(),
                        time: messages[index]["time"].toString());
                  } else {
                    return SenderCard(
                        message: messageData.text.trim(),
                        time: messages[index]["time"].toString());
                  }
            },
          );
                }
              )),
          ChatTextField(receiverId: uid),
        ],
      ),
    );
  }
}
