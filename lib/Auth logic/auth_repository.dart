import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/Common/firebaseDataStorage.dart';
import 'package:whatsapp/Models/user_models.dart';
import 'package:whatsapp/Auth%20logic/otp_screen.dart';
import 'package:whatsapp/Auth%20logic/userInfoScreen.dart';
import 'package:whatsapp/Common/commonFunctions.dart';
import 'package:whatsapp/main.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
      firebaseAuth: FirebaseAuth.instance,
      firebaseFirestore: FirebaseFirestore.instance),
);

class AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AuthRepository({required this.firebaseAuth, required this.firebaseFirestore});

  Future<UserModels?> getCurrentUserData() async {
    var userdata = await firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser?.uid)
        .get();
    UserModels? user;
    if (userdata.data() != null) {
      user = UserModels.fromMap(userdata.data()!);
    }
    return user;
  }

  void singInWithPhoneNumber(BuildContext context, String phoneNumber) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          throw Exception(e.message);
        },
        codeSent: (verificationId, forceResendingToken) async {
          await Navigator.pushNamed(context, OtpScreen.routeName,
              arguments: verificationId);
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message);
    }
  }

  void verifyOTP(
      {required BuildContext context,
      required String otp,
      required String verificationId}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      await firebaseAuth.signInWithCredential(credential);
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
          context, UserInfoScreen.routeName, (route) => false);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message);
    }
  }

  void saveUserDataToFirebase(
      {required BuildContext context,
      required ProviderRef ref,
      required String name,
      required File? profilePic}) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      String photoUrl = "assets/profilee.png";
      if (profilePic != null) {
        photoUrl = await ref
            .read(firebaseDataStorageProvider)
            .saveUserDataToFirebase("profilePics/$uid", profilePic);
      }

      var user = UserModels(
          name: name,
          uid: uid,
          profilePic: photoUrl,
          phoneNumber: firebaseAuth.currentUser!.phoneNumber!,
          isOnline: true);

      await firebaseFirestore.collection("users").doc(uid).set(user.toMap());

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHomePage(),
          ),
          (route) => false);
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
