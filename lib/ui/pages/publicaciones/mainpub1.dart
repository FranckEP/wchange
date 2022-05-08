import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
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
      backgroundColor: Colors.white,
      body: getInfo(context, controlp.readItems(), controluser.uid),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => _buildPopupDialog(context),
          );
        },
      ),
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
    ControllerFirestore controlp = Get.find();
    AuthController authController = Get.find();
    
    return ListView.builder(
        itemCount: estados.length == 0 ? 0 : estados.length,
        itemBuilder: (context, posicion) {
          print(estados[posicion].id);
          return Card(
            elevation: 1,
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
                  '\n${authController.nameUser}\n',
                ),
                subtitle: Text(estados[posicion]['information']),
                //onLongPress: controlp.eliminarestados(estados[posicion].id),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: Icon(Icons.public_outlined, color: Colors.red),
                    onPressed: () {
                      launchUrlString(estados[posicion]['link']);
                    },
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ]),
          );
        });
  }
}

Widget _buildPopupDialog(BuildContext context) {

  TextEditingController controlinformation = TextEditingController();
  TextEditingController controllink = TextEditingController();
  TextEditingController controlApodo = TextEditingController();
  ControllerFirestore controlestados = Get.find();

  return AlertDialog(
    title: const Text('Nueva oferta'),
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
              maxLines: null,
              keyboardType: TextInputType.text,
              controller: controlApodo,
              decoration: InputDecoration(
                labelText: "Ingrese su apodo",
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
              )),
          SizedBox(height: 10),
          TextFormField(
              maxLines: null,
              keyboardType: TextInputType.text,
              controller: controlinformation,
              decoration: InputDecoration(
                labelText: "Ingrese su nueva oferta",
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
              )),
          SizedBox(height: 10),
          TextFormField(
              maxLines: null,
              keyboardType: TextInputType.url,
              controller: controllink,
              decoration: InputDecoration(
                labelText: "Link para más información",
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
              )),
        ],
      ),
    ),
    actions: <Widget>[
      OutlinedButton(
        onPressed: () {
          var estados = <String, dynamic>{
            'information': controlinformation.text,
            'link': controllink.text,
            'name': controlApodo.text,
            //'uid': controluser.uid,
          };
          controlestados.crearestado(estados);
          Navigator.of(context).pop();
        },
        child: Text(
          'Publicar',
          style: TextStyle(color: Colors.red.shade300),
        ),
      ),
    ],
  );
}