import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseDataStorageProvider = Provider((ref) =>
  FirebaseDataStorageRepository(firebaseStorage: FirebaseStorage.instance)
);

class FirebaseDataStorageRepository {
  final FirebaseStorage firebaseStorage;

  FirebaseDataStorageRepository({required this.firebaseStorage});

  Future<String> saveUserDataToFirebase(String ref, File? file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }
}
