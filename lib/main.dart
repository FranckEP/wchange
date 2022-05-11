import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:wchange/data/repositories/firestore_database.dart';
import 'package:wchange/domain/controladores/authController.dart';
import 'package:wchange/domain/controladores/firestore_images.dart';
import 'package:wchange/domain/controladores/management_auth.dart';
import 'package:wchange/ui/myapp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );
  await Firebase.initializeApp();
  Get.put(AuthController());
  Get.put(ControllerFirestore());
  Get.put(AuthManagement());
  Get.put(FirestoreDatabase());
  runApp(staySession());
}

class staySession extends StatefulWidget {
  staySession({Key? key}) : super(key: key);

  @override
  State<staySession> createState() => _staySessionState();
}

class _staySessionState extends State<staySession> {
  late StreamSubscription<User?> user;
    void initState() {
      super.initState();
      user = FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
        }
      });
    }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyApp();
  }
}