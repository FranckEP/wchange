import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wchange/ui/pages/Mensajes/mensajepriv.dart/menpriv.dart';

class Publicaciones extends StatefulWidget {
  const Publicaciones({Key? key}) : super(key: key);

  @override
  State<Publicaciones> createState() => _Publicaciones();
}

class _Publicaciones extends State<Publicaciones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: 50,
        itemBuilder: (BuildContext context, int index) {
          return Card(
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
                      'https://cdn-icons-png.flaticon.com/512/147/147144.png'),
                  backgroundColor: Colors.blue,
                ),
                title: Text('\nName of the coach\n',),
                subtitle: Text(
                    'Here will be the text in which the coach will write about a new job in which the users will be able to apply.'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: Icon(Icons.public_outlined, color: Colors.red),
                    onPressed: () {
                      Get.to(() => const Priv());
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        onPressed: () {},
      ),
    );
  }
}
