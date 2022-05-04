import 'package:get/get.dart';
import 'package:wchange/domain/controladores/management_states.dart';
import 'package:wchange/domain/models/estados_model.dart';

class StateController extends GetxController {
  StateController() {
    getStatus();
  }
  getStatus() async {
    listState.value = await statusManager.getstateOnce();
  }

  StatusManager statusManager = Get.find();
  var listState = [].obs; //lista vacia observable
  Future<void> addState({uid, title, information, link}) async {
    var stateModel = Estados(
      title: title,
      uid: uid,
      information: information,
      link: link);
    try {
      await statusManager.sendStatus(stateModel);
      listState.add(stateModel);
    } catch (e) {
      return Future.error(e);
    }
  }
}