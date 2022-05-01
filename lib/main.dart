import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wchange/ui/pages/homepage.dart';
import 'package:wchange/ui/pages/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}