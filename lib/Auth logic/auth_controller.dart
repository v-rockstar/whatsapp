import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/Models/user_models.dart';
import 'package:whatsapp/Auth%20logic/auth_repository.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

final userDataProvider = FutureProvider(
  (ref) {
    final authController = ref.watch(authControllerProvider);
    return authController.getUserData();
  },
);

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthController({required this.authRepository, required this.ref});

  Future<UserModels?> getUserData() async {
    UserModels? user = await authRepository.getCurrentUserData();
    return user;
  }

  void signInWithPhone(BuildContext context, String phoneNumber) {
    authRepository.singInWithPhoneNumber(context, phoneNumber);
  }

  void verifyingOTP(
      BuildContext context, String verificationId, String userOTP) {
    authRepository.verifyOTP(
        context: context, otp: userOTP, verificationId: verificationId);
  }

  void saveUserDataToFirebase(
      BuildContext context, String name, File? profilePic) {
    authRepository.saveUserDataToFirebase(
        context: context, ref: ref, name: name, profilePic: profilePic);
  }
}
