import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/Common/colors.dart';
import 'package:whatsapp/Common/errorScreen.dart';
import 'package:whatsapp/Common/loader.dart';
import 'package:whatsapp/Contacts%20logic/contact_controller.dart';

class ContactScreen extends ConsumerWidget {
  const ContactScreen({super.key});
  static const String routeName = "/contactScreen";

  void selectcontact(WidgetRef ref,BuildContext context,Contact selectedContact) {
    ref.read(selectContactContollerProvider).selectcontact(context, selectedContact);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contact list'),
          backgroundColor: appBarColor,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        body: ref.read(contactControllerProvider).when(
              data: (contactList) {
                return ListView.builder(
                    itemCount: contactList.length,
                    itemBuilder: (context, index) {
                      final contact = contactList[index];
                      return InkWell(
                        onTap: () => selectcontact(ref,context,contact),
                        child: ListTile(
                          leading: contact.photo == null
                              ? const CircleAvatar(
                                  backgroundImage: AssetImage("assets/wp.png"),
                                )
                              : CircleAvatar(
                                  backgroundImage: MemoryImage(contact.photo!),
                                ),
                          title: Text(contact.displayName),
                        ),
                      );
                    });
              },
              error: (error, stackTrace) => const ErrorScreen(),
              loading: () => const Loader(),
            ));
  }
}
