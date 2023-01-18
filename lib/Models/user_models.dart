class UserModels {
  final String name;
  final String uid;
  final String profilePic;
  final String phoneNumber;
  final bool isOnline;

  UserModels(
      {required this.name,
      required this.uid,
      required this.profilePic,
      required this.phoneNumber,
      required this.isOnline});

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "uid": uid,
      "profilePic": profilePic,
      "phoneNumber": phoneNumber,
      "isOnline": isOnline
    };
  }

  factory UserModels.fromMap(Map<String, dynamic> map) {
    return UserModels(
        name: map ["name"] ?? "",
        uid: map ["uid"] ?? "",
        profilePic: map ["profilePic"] ?? "",
        phoneNumber: map ["phoneNumber"] ?? "",
        isOnline: map ["isOnline"] ?? false);
  }
}
