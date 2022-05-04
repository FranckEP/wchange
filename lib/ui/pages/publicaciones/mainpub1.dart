import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wchange/domain/controladores/authController.dart';
import 'package:wchange/domain/controladores/firestore_images.dart';

class ListaEstados extends StatefulWidget {
  @override
  _ListaEstadosState createState() => _ListaEstadosState();
}

class _ListaEstadosState extends State<ListaEstados> {
  ControllerFirestore controlp = Get.find();
  AuthController controluser = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getInfo(context, controlp.readItems(), controluser.uid),
    );
  }
}

@override
Widget getInfo(BuildContext context, Stream<QuerySnapshot> ct, String uid) {
  return StreamBuilder(
    stream: ct,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      print(snapshot.connectionState);
      switch (snapshot.connectionState) {

        //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el loader
        case ConnectionState.waiting:
          return Center(
            child: CircularProgressIndicator(),
          );

        case ConnectionState.active:
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          // print(snapshot.data);
          return snapshot.data != null
              ? VistaEstados(estados: snapshot.data!.docs, uid: uid)
              : Text('Sin Datos');

        default:
          return Text('Presiona el boton para recargar');
      }
    },
  );
}

class VistaEstados extends StatelessWidget {
  final List estados;
  final String uid;
  const VistaEstados({required this.estados, required this.uid});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: estados.length == 0 ? 0 : estados.length,
        itemBuilder: (context, posicion) {
          print(estados[posicion].id);
          return Card(
            elevation: 1,
            key: ValueKey(record.name),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.red.shade300, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.all(8.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://cdn-icons-png.flaticon.com/512/147/147144.png'),
                  backgroundColor: Colors.blue,
                ),
                title: Text(
                  '\n ${estados[posicion]['titulo']}\n',
                ),
                subtitle: Text(estados[posicion]['information']),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: Icon(Icons.public_outlined, color: Colors.red),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ]),
          );
        });
  }
}
