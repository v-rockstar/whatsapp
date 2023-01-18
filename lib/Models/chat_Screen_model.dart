
class ChatScreenModel {
  final String name;
  final String lastMessage;
  final String profilePic;
  final DateTime? timeSent;
  final String contactId;

  ChatScreenModel(
      {required this.name,
      required this.lastMessage,
      required this.profilePic,
       this.timeSent,
      required this.contactId});

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "lastMessage": lastMessage,
      "profilePic": profilePic,
      "DateTime": timeSent,
      "conatctId": contactId
    };
  }

  factory ChatScreenModel.fromMap(Map<String, dynamic> map) {
    return ChatScreenModel(
        name: map["name"] ?? "",
        lastMessage: map["lastMessage"] ?? "",
        profilePic: map["profilePic"] ?? "",
       
        contactId: map["contactId"] ?? "");
  }
}
