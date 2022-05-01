import 'package:flutter/material.dart';
import 'package:wchange/ui/pages/Men%C3%BA/mainmenu.dart';
import 'package:wchange/ui/pages/Mensajes/mainmensajes.dart';
import 'package:wchange/ui/pages/publicaciones/mainpub.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.red.shade400,
          actions: [
            IconButton(
              icon:  Image(image: AssetImage("assets/ni.png")), iconSize: 100, 
              color: Colors.black, 
              onPressed: (){},
            ),
          ],
          bottom: TabBar(
            tabs: const [
              Tab(
                icon: Icon(Icons.public),
              ),
              Tab(
                icon: Icon(Icons.message_sharp),
              ),
              Tab(
                icon: Icon(Icons.menu),
              ),
            ],
            labelColor: Colors.red,
            unselectedLabelColor: Colors.grey,
          ),
          title: const Image(image: AssetImage("assets/no.png")),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
        ),
        body: const TabBarView(children: [
          Publicaciones(),
          Mensajes(),
          Menu(),
        ],),
      ),
    );
  }
}
