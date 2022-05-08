import 'package:get/get.dart';
import 'package:wchange/data/repositories/firestore_database.dart';
import 'package:wchange/domain/controladores/password_auth.dart';
import 'package:wchange/domain/models/userModel.dart';

class AuthManagement {
  PasswordAuth auth = PasswordAuth();

  Future<UserModel?> getLoggedUser() async {
    return await auth.getLoggedUser();
  }

  Future<UserModel?> signIn(
      {required String email, required String password}) async {
    try {
      return await auth.signIn(email: email, password: password);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      var user = UserModel(
          name: name,
          email: email,
          password: password,
          pictureUrl:
              'https://media.admagazine.com/photos/618a6acbcc7069ed5077ca7f/master/w_1600%2Cc_limit/68704.jpg');
      auth.signUp(userModel: user);
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> signOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<UserModel>> extractAllUsers() async {
    try {
      List<UserModel> users = [];
      FirestoreDatabase database = Get.find();
      var doc = await database.readCollection(collectionPath: 'users');
      for (var user in doc) {
        users.add(UserModel.fromJson(user['data']));
      }
      return users;
    } catch (e) {
      return Future.error(e);
    }
  }
}
