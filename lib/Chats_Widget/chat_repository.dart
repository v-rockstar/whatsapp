import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp/Common/commonFunctions.dart';
import 'package:whatsapp/Common/enums.dart';
import 'package:whatsapp/Models/chat_Screen_model.dart';
import 'package:whatsapp/Models/message_Screen_model.dart';
import 'package:whatsapp/Models/user_models.dart';

final chatRepositoryProvider = Provider(
  (ref) => ChatRepository(
      firebaseAuth: FirebaseAuth.instance,
      firebaseFirestore: FirebaseFirestore.instance),
);

class ChatRepository {
  FirebaseAuth firebaseAuth;
  FirebaseFirestore firebaseFirestore;

  ChatRepository({required this.firebaseAuth, required this.firebaseFirestore});

  Stream<List<ChatScreenModel>> chatScreenDisplay() {
    return firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap((event) async {
      List<ChatScreenModel> chatScreen = [];
      var abc=event.docs;
      for (var document in event.docs) {
        var chatScreenDisplay = ChatScreenModel.fromMap(document.data());
        var userData = await firebaseFirestore
            .collection('users')
            .doc(chatScreenDisplay.contactId)
            .get();
        var user = UserModels.fromMap(userData.data()!);

        chatScreen.add(ChatScreenModel(
            name: user.name,
            lastMessage: chatScreenDisplay.lastMessage,
            profilePic: user.profilePic,
            timeSent: chatScreenDisplay.timeSent,
            contactId: chatScreenDisplay.contactId));
      }
      print('CHat screen lenght: ${chatScreen.length}');
      return chatScreen;
    });
    print("hello");
  }

  Stream<List<MessageScreenModel>> streamMessage(receiverUserId) {
    return firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('chats')
        .doc(receiverUserId)
        .collection('messages')
        .snapshots()
        .map((event) {
      List<MessageScreenModel> messages = [];
      for (var element in event.docs) {
        messages.add(MessageScreenModel.fromMap(element.data()));
      }
      return messages;
    });
  }

  void _saveMessageToChatScreen(UserModels senderUserData,
      UserModels receiverUserData, String text, DateTime timeSent) async {
    var senderChatContact = ChatScreenModel(
        name: receiverUserData.name,
        lastMessage: text,
        profilePic: receiverUserData.profilePic,
        timeSent: timeSent,
        contactId: receiverUserData.uid);

    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('chats')
        .doc(receiverUserData.uid)
        .set(senderChatContact.toMap());

    var receiverChatScreen = ChatScreenModel(
        name: senderUserData.name,
        lastMessage: text,
        profilePic: senderUserData.profilePic,
        timeSent: timeSent,
        contactId: senderUserData.uid);

    await firebaseFirestore
        .collection('users')
        .doc(receiverUserData.uid)
        .collection('chats')
        .doc(firebaseAuth.currentUser!.uid)
        .set(receiverChatScreen.toMap());
  }

  void _saveMessageToMessageScreen(
      {required receiverUsername,
      required String username,
      required String receiverUserId,
      required String text,
      required String messageId,
      required DateTime timeSent,
      required bool isSeen,
      required MessageEnums type}) async {
    final messageDisplay = MessageScreenModel(
        senderId: firebaseAuth.currentUser!.uid,
        receiverId: receiverUserId,
        text: text,
        timeSent: timeSent,
        messageId: messageId,
        isSeen: false,
        type: type);

    await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('chats')
        .doc(receiverUserId)
        .collection('messages')
        .doc(messageId)
        .set(messageDisplay.toMap());

    await firebaseFirestore
        .collection('users')
        .doc(receiverUserId)
        .collection('chats')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .set(messageDisplay.toMap());
  }

  void sendTextMessage(
      {required BuildContext context,
      required String text,
      required String receiverId,
      required UserModels senderUserData}) async {
    var messageId = const Uuid().v1();
    var timeSent = DateTime.now();
    try {
      UserModels receiverUserData;

      final userDataMap =
          await firebaseFirestore.collection('users').doc(receiverId).get();

      receiverUserData = UserModels.fromMap(userDataMap.data()!);

      _saveMessageToChatScreen(
          senderUserData, receiverUserData, text, timeSent);

      _saveMessageToMessageScreen(
          username: senderUserData.name,
          receiverUsername: receiverUserData.name,
          receiverUserId: receiverId,
          text: text,
          messageId: messageId,
          timeSent: timeSent,
          isSeen: false,
          type: MessageEnums.text);
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
