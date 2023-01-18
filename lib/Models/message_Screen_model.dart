import 'package:whatsapp/Common/enums.dart';

class MessageScreenModel {
  final String senderId;
  final String receiverId;
  final String text;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;
  final MessageEnums type;

  MessageScreenModel(
      {required this.senderId,
      required this.receiverId,
      required this.text,
      required this.timeSent,
      required this.messageId,
      required this.isSeen,
      required this.type});

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'timeSent': timeSent,
      'messgeId': messageId,
      'isSeen': isSeen,
      'type': type.type
    };
  }

  factory MessageScreenModel.fromMap(Map<String, dynamic> map) {
    return MessageScreenModel(
        isSeen: map['isSeen'] ?? false,
        messageId: map['messageId'] ?? '',
        receiverId: map['receiverId'] ?? '',
        senderId: map['senderId'] ?? '',
        text: map['text'] ?? '',
        timeSent: map['temeSent'] ?? '',
        type: (map['type'] as String).toEnum());
  }
}
