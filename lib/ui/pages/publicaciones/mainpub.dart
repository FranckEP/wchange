import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wchange/ui/pages/Mensajes/mensajepriv.dart/menpriv.dart';
import 'package:wchange/ui/pages/publicaciones/widgetinside.dart';

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
                title: Text(
                  '\nName of the coach\n',
                ),
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

Widget _buildPopupDialog(BuildContext context) {
  TextEditingController controlnew = TextEditingController();
  TextEditingController controllink = TextEditingController();
  //AuthController controluser = Get.find();
  return AlertDialog(
    title: const Text('Nueva oferta'),
    content: SingleChildScrollView(child: newPublication()),
    actions: <Widget>[
      OutlinedButton(
        onPressed: () {
          var estados = <String, dynamic>{
                    'aviso': controlnew.text,
                    'detalle': controllink.text,
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

Column newPublication() {
  TextEditingController controlnew = TextEditingController();
  TextEditingController controllink = TextEditingController();
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      TextFormField(
          maxLines: null,
          keyboardType: TextInputType.text,
          controller: controlnew,
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
  );
}
