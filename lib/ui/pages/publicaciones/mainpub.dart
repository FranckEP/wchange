import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wchange/domain/controladores/firestoreController.dart';
import 'package:wchange/domain/models/statesModel.dart';
import 'package:wchange/ui/pages/Mensajes/mensajepriv.dart/menpriv.dart';
import 'package:wchange/ui/pages/publicaciones/widgetinside.dart';

class Publicaciones extends StatefulWidget {
  const Publicaciones({Key? key}) : super(key: key);

  @override
  State<Publicaciones> createState() => _Publicaciones();
}

class _Publicaciones extends State<Publicaciones> {
  final FirebaseController firebaseController = Get.find();

  @override
  void initState() {
    firebaseController.suscribeUpdates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => ListView.builder(
            itemCount: firebaseController.entries.length,
            padding: EdgeInsets.only(top: 20.0),
            itemBuilder: (BuildContext context, int index) {
              return _buildItem(context, firebaseController.entries[index]);
            }),
      ),
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

  Widget _buildItem(BuildContext context, Record record) {
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
            '\n ${record.name}\n',
          ),
          subtitle: Text(record.information),
          onTap: () => firebaseController.updateEntry(record),
          onLongPress: () => firebaseController.deleteEntry(record),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              child: Icon(Icons.public_outlined, color: Colors.red),
              onPressed: () {
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
      ]),
    );
  }

  Future<void> addEstado(BuildContext context) async {
    getName(context).then((value) {
      firebaseController.addEntry(value);
    });
  }

  Future<String> getName(BuildContext context) async {
    String? result = await prompt(
      context,
      title: Text('Adding a baby'),
      initialValue: '',
      textOK: Text('Ok'),
      textCancel: Text('Cancel'),
      hintText: 'Baby name',
      minLines: 1,
      autoFocus: true,
      obscureText: false,
      textCapitalization: TextCapitalization.words,
    );
    if (result != null) {
      return Future.value(result);
    }
    return Future.error('cancel');
  }
}

Widget _buildPopupDialog(BuildContext context) {
  TextEditingController controlinformation = TextEditingController();
  TextEditingController controllink = TextEditingController();
  //AuthController controluser = Get.find();
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
            //'name': controluser.nameUser,
            //'uid': controluser.uid,
          };
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
