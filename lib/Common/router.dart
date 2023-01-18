import 'package:flutter/material.dart';
import 'package:whatsapp/Auth%20logic/login_screen.dart';
import 'package:whatsapp/Auth%20logic/otp_screen.dart';
import 'package:whatsapp/Auth%20logic/userInfoScreen.dart';
import 'package:whatsapp/Chats_Widget/chat_layout.dart';
import 'package:whatsapp/Contacts%20logic/contact_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case OtpScreen.routeName:
      final verificationId = settings.arguments.toString();
      return MaterialPageRoute(
          builder: (context) => OtpScreen(verificationId: verificationId));
          case UserInfoScreen.routeName:
      return MaterialPageRoute(builder: (context) => const UserInfoScreen());
       case ContactScreen.routeName:
      return MaterialPageRoute(builder: (context) => const ContactScreen());
      case ChatLayout.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      final profilePic = arguments['profilePic'];
      return MaterialPageRoute(builder: (context) =>  ChatLayout(name: name, uid: uid, profilePic: profilePic));
    default:
      return MaterialPageRoute(
          builder: (context) => const Scaffold(
                body: Center(child: Text('Error')),
              ));
  }
}
