import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/Common/errorScreen.dart';
import 'package:whatsapp/Common/loader.dart';
import 'package:whatsapp/Auth%20logic/auth_controller.dart';
import 'package:whatsapp/Contacts%20logic/contact_screen.dart';
import 'package:whatsapp/Models/user_models.dart';
import 'package:whatsapp/Screens/calls_screen.dart';
import 'package:whatsapp/Screens/homeScreen.dart';
import 'package:whatsapp/Screens/landingScreen.dart';
import 'package:whatsapp/Screens/status_screeen.dart';
import 'package:whatsapp/Common/router.dart';
import 'Screens/camera_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        title: "V-Chat",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: const Color(0xff075E57)),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: ref.watch(userDataProvider).when(
            data: (user) {
              // ignore: unrelated_type_equality_checks
              if (user == false) {
                return const LandingScreen();
              }
              return const MyHomePage();
            },
            error: ((error, stackTrace) => const ErrorScreen()),
            loading: () => const Loader()));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabcontroller;
  

  @override
  void initState() {
    super.initState();

    _tabcontroller = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" V-Chat ",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
        backgroundColor: const Color(0xff075E54),
        bottom: TabBar(
          controller: _tabcontroller,
          isScrollable: true,
          tabs: [
            Container(
              width: 30,
              height: 50,
              alignment: Alignment.center,
              child: const Icon(
                Icons.camera_alt,
                size: 22,
              ),
            ),
            Container(
              width: 70,
              height: 50,
              alignment: Alignment.center,
              child: const Text(
                "Chats",
                style: TextStyle(fontSize: 15),
              ),
            ),
            Container(
              width: 70,
              height: 50,
              alignment: Alignment.center,
              child: const Text("Status"),
            ),
            Container(
              width: 70,
              height: 50,
              alignment: Alignment.center,
              child: const Text("Calls"),
            ),
          ],
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
        ),
      ),
      body: TabBarView(
        controller: _tabcontroller,
        children:  [
         const CameraScreen(),
          HomeScreen(),
          StatusScreeen(),
          CallsScreen()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, ContactScreen.routeName),
        backgroundColor: Colors.green.shade700,
        child: const Icon(Icons.message),
      ),
    );
  }
}
