import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'mensajepriv.dart/menpriv.dart';

class Mensajes extends StatefulWidget {
  const Mensajes({Key? key}) : super(key: key);

  @override
  State<Mensajes> createState() => _Mensajes();
}

class _Mensajes extends State<Mensajes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.red.shade100,
        child: ListView.builder(
          itemCount: 9,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => {
                Get.to(() => const Priv())
              },
              child: Card(
                elevation: 1,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.red.shade300, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.all(8.0),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                const ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/147/147140.png'),
                    backgroundColor: Colors.blue,
                  ),
                  title: Text('Jorge coach'),
                  subtitle: Text(
                      'Hi men, how are you?'),
                ),]
                ),
              )
            );
          }
        )
      ),
    );
  }

}
