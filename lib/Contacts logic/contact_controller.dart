import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/Contacts%20logic/contact_repository.dart';

final contactControllerProvider = FutureProvider(
  (ref) {
    final contactRepository = ref.watch(contactRepositoryProvider);
    return contactRepository.getContact();
  },
);

final selectContactContollerProvider = Provider(
  (ref) {
    final contactRepository = ref.watch(contactRepositoryProvider);
    return SelectContactContoller(
         contactRepository: contactRepository);
  },
);

class SelectContactContoller {
  // ProviderRef ref;
  ContactRepository contactRepository;

  SelectContactContoller({ required this.contactRepository});

  void selectcontact(BuildContext context, Contact selectedContact) {
    contactRepository.selectcontact(context, selectedContact);
  }
}
