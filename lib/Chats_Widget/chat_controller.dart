import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/Auth%20logic/auth_controller.dart';
import 'package:whatsapp/Chats_Widget/chat_repository.dart';
import 'package:whatsapp/Models/chat_Screen_model.dart';
import 'package:whatsapp/Models/message_Screen_model.dart';
import 'package:whatsapp/Models/user_models.dart';

final chatControllerProvider = Provider(
  (ref) {
    final chatRepository = ref.watch(chatRepositoryProvider);
    return ChatController(chatRepository: chatRepository, ref: ref);
  },
);

class ChatController {
  ChatRepository chatRepository;
  ProviderRef ref;

  ChatController({required this.chatRepository, required this.ref});

  Stream<List<ChatScreenModel>> chatScreenDisplay() {
    return chatRepository.chatScreenDisplay();
  }

  Stream<List<MessageScreenModel>> streamMessage(String receiverUserId) {
    return chatRepository.streamMessage(receiverUserId);
  }

  void sendTextMessage(BuildContext context, String text, String receiverId) {
    ref.read(userDataProvider).whenData((value) =>
        chatRepository.sendTextMessage(
            context: context,
            text: text,
            receiverId: receiverId,
            senderUserData: value!));
  }
}
