import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/Chats_Widget/chat_layout.dart';
import 'package:whatsapp/Common/commonFunctions.dart';
import 'package:whatsapp/Models/user_models.dart';

final contactRepositoryProvider = Provider(
    (ref) => ContactRepository(firebaseFirestore: FirebaseFirestore.instance));

class ContactRepository {
  FirebaseFirestore firebaseFirestore;

  ContactRepository({required this.firebaseFirestore});

  Future<List<Contact>> getContact() async {
    List<Contact> contacts = [];

    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(withProperties: true);
    }

    return contacts;
  }

  void selectcontact(BuildContext context, Contact selectedContact) async {
    try {
      var userCollection = await firebaseFirestore.collection('users').get();
      bool isFound = false;

      for (var element in userCollection.docs) {
        var userdata = UserModels.fromMap(element.data());
        String selectedPhoneNumber =
            selectedContact.phones[0].number.replaceAll(" ", "");

        if (selectedPhoneNumber == userdata.phoneNumber) {
          isFound = true;
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, ChatLayout.routeName,
              arguments: {'name': userdata.name, 'uid': userdata.uid, 'profilePic': userdata.profilePic});
        }
      }
      if (isFound == false) {
        showSnackBar(
            context: context,
            content: 'This number is not registered with this app');
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
