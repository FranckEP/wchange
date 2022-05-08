import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:wchange/data/repositories/auth.dart';
import 'package:wchange/data/repositories/firestore_database.dart';
import 'package:wchange/domain/models/userModel.dart';

class PasswordAuth implements AuthInterface {

  Future<UserModel?> getLoggedUser()async{
    var fUser = FirebaseAuth.instance.currentUser;
    if (fUser != null) {
      FirestoreDatabase firestoreDatabase = Get.find();
          var doc = await firestoreDatabase.getDocWithId(colletionName: 'users', idDoc: fUser.uid);
          return UserModel.fromJson(doc!);
    }else{
      return null;
    }
  }
  @override
  Future<UserModel?> signIn({required String email, required String password}) async {
    try {
      var userCredential = 
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
          FirestoreDatabase firestoreDatabase = Get.find();
           var doc = await firestoreDatabase.getDocWithId(colletionName: 'users', idDoc: userCredential.user!.uid);
          return UserModel.fromJson(doc!);
    } on FirebaseAuthException catch (e) {
      return Future.error(e.code);
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<bool> signUp(
      {required userModel}) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: userModel.email, password: userModel.password);
      userCredential.user!.updateDisplayName(userModel.name);
      FirestoreDatabase firestoreDatabase = Get.find();
      Map<String, dynamic> doc = userModel.toJson();
      doc.addAll({
        'id': userCredential.user?.uid
      });
      firestoreDatabase.add(collectionPath: 'users', data: doc);
      return true;
    } on FirebaseAuthException catch (e) {
      return Future.error(e.code);
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  // We throw an error if someone calls SignInWithGoogle, member of AuthInterface
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}