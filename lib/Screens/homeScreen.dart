import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'package:whatsapp/Chats_Widget/chat_controller.dart';
import 'package:whatsapp/Chats_Widget/chat_layout.dart';
import 'package:whatsapp/Common/dummydata.dart';
import 'package:whatsapp/Common/loader.dart';
import 'package:whatsapp/Models/user_models.dart';

import '../Models/chat_Screen_model.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  // final StreamController<List<ChatScreenModel>> streamController =
  //     StreamController<List<ChatScreenModel>>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<ChatScreenModel>>(
        stream: ref.watch(chatControllerProvider).chatScreenDisplay(),
        builder: (context, snapshot) {

                if(snapshot==null){
                  return Center(child: Text('Null snapshot'));
                }

          if (snapshot.connectionState == ConnectionState.waiting) {
           
            return const Loader();
          }
          if(snapshot.data==null){
            return Text("Null data");
          }
print('Length: ${snapshot.data!.length}');
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                print('Index: $index');
                var contactData = snapshot.data![index];
                return InkWell(
                  splashColor: const Color(0xff075E57),
                  onTap: () {
                    Navigator.pushNamed(context, ChatLayout.routeName,
                        arguments: {
                          'name': contactData.name,
                          'uid': contactData.contactId
                        });
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage(contactData.profilePic)),
                    title: Text(
                      contactData.name,
                      style: const TextStyle(fontSize: 17),
                    ),
                    subtitle: Text(contactData.lastMessage),
                    // trailing: Text(
                    //   DateFormat.Hm().format(contactData.timeSent),
                    //   // dummydata[index].time
                    // ),
                  ),
                );
              });
        });
  }
}
