import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

// Controlador que maneja todas las instancias de FirebaseStorage
class ControllerFirestore extends GetxController {
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> readItems() {
    CollectionReference listado = _db.collection('estados');

    return listado.snapshots();
  }

  Future<void> crearestado(Map<String, dynamic> estados) async {
    await _db.collection('estados').doc().set(estados).catchError((e) {
      print(e);
    });
    //return true;
  }

  Future<void> actualizarestado(String id, Map<String, dynamic> estados) async {
    await _db.collection('estados').doc(id).update(estados).catchError((e) {
      print(e);
    });
    //return true;
  }

  eliminarestados(String id) async {
    await _db.collection('estados').doc(id).delete().catchError((e) {
      print(e);
    });
    return true;
  }

}
