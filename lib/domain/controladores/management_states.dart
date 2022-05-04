import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wchange/data/repositories/firestore_database.dart';
import 'package:wchange/domain/models/estados_model.dart';

class StatusManager {
  final _database = FirestoreDatabase();

  Future<void> sendStatus(Estados status) async {
    await _database.add(collectionPath: "state", data: status.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getstateStream() {
    return _database.listenCollection(collectionPath: "state");
  }

  Future<List<Estados>> getstateOnce() async {
    final stateData = await _database.readCollection(collectionPath: "state");
    return _extractInstances(stateData);
  }

  List<Estados> extractstate(QuerySnapshot<Map<String, dynamic>> snapshot) {
    final stateData = _database.extractDocs(snapshot);
    return _extractInstances(stateData);
  }

  // Future<void> removeStatus(Estados status) async {
  //   await _database.deleteDoc(documentPath: status.dbRef!);
  // }

  List<Estados> _extractInstances(List<Map<String, dynamic>> data) {
    List<Estados> state = [];
    for (var statusJson in data) {
      state.add(Estados.fromJson(statusJson));
    }
    return state;
  }
}