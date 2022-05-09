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
  runApp(MyApp());
}
