import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  late Rx<dynamic> _uid = "".obs;
  String get uid => _uid.value;
  //Futuro para el inicio de sesión
  Future<void> login(theEmail, thePassword) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: theEmail,
              password: thePassword,
          );
      _uid.value = theEmail!.id;
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Future.error('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return Future.error('Wrong password provided for that user.');
      }
    }
  }

  //Futuro para el registro
  Future<void> signUp(email, password, name) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Future.error('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return Future.error('The account already exists for that email.');
      }
    }
  }

  //Futuro para cerrar sesión
   Future<void> logOut() async {
     try {
        await FirebaseAuth.instance.signOut();
     } catch (e) {
       return Future.error(e.toString());
     }
   }

  String userEmail() {
    String email = FirebaseAuth.instance.currentUser!.email ?? "a@a.com";
    return email;
  }
}
