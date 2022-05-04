import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wchange/domain/controladores/authController.dart';
import 'package:wchange/ui/pages/login/login.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _Menu();
}

class _Menu extends State<Menu> {
  AuthController authController = Get.find();

  _logout() async {
    try {
      await authController.logOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
      const SizedBox(height: 20),
      Container(
          width: 400,
          height: 400,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/W.png"),
          ))),
      const SizedBox(height: 50),
      OutlinedButton(
        onPressed: () {},
        child: const Text("Mi Perfíl"),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.red),
          primary: Colors.red,
        ),
      ),
      const SizedBox(height: 20),
      OutlinedButton(
        onPressed: () {
          _logout();
        },
        child: const Text("Cerrar sesión"),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.red),
          primary: Colors.red,
        ),
      )
    ])));
  }
}
