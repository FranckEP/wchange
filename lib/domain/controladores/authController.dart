import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:wchange/domain/controladores/management_auth.dart';
import 'package:wchange/domain/models/userModel.dart';

class AuthController extends GetxController {
  // Observables
  final _authenticated = false.obs;
  final _currentUser = Rx<UserModel?>(null);
  final _nameUser = "".obs;
  late AuthManagement _manager = Get.find();
  var isLogged = false.obs;
  late Rx<dynamic> _uid = "".obs;
  late Rx<dynamic> _photo = "".obs;

  String get uid => _uid.value;
  String get photo => _photo.value;
  String get nameUser => _nameUser.value;

  AuthController() {
    getLoggedUser();
  }

  Future<void> usuario(
      {required String email, required String password}) async {
    var userCredential = FirebaseAuth.instance.currentUser!.displayName.toString();
    print(userCredential);
    guardarUser(userCredential);
  }

  guardarUser(String usuario) {
    _nameUser.value = usuario;
  }

  getLoggedUser() async {
    try {
      _currentUser.value = await _manager.getLoggedUser();
      isLogged.value = true;
      print(_currentUser.value!.toJson());
    } catch (e) {
      isLogged.value = false;
    }
  }

  Future<List<UserModel>> extractAllUser() async {
    try {
      return await _manager.extractAllUsers();
    } catch (e) {
      return Future.error(e);
    }
  }

  set currentUser(UserModel? userAuth) {
    _currentUser.value = userAuth;
    _authenticated.value = userAuth != null;
  }

  set authManagement(AuthManagement manager) {
    _manager = manager;
  }

  // Reactive Getters
  RxBool get reactiveAuth => _authenticated;
  Rx<UserModel?> get reactiveUser => _currentUser;

  // Getters
  bool get authenticated => _authenticated.value;
  UserModel? get currentUser => _currentUser.value;

  AuthManagement get manager => _manager;

  Future<void> login(email, password) async {
    try {
      _currentUser.value =
          await _manager.signIn(email: email, password: password);
      print('OK');
      isLogged.value = true;
      _uid.value = currentUser!.id;
      _photo.value =
          'https://cdn-icons-png.flaticon.com/512/147/147140.png';
      print(_currentUser.value!.toJson());
    } catch (e) {
      isLogged.value = false;
      return Future.error(e);
    }
    printInfo(info: 'Ok');
  }

  Future<void> signUp({name, email, password}) async {
    try {
      await _manager.signUp(name: name, email: email, password: password);
      _uid.value = currentUser!.id;
      _photo.value =
          'https://cdn-icons-png.flaticon.com/512/147/147140.png';
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> logOut() async {
    try {
      await manager.signOut();
      isLogged.value = false;
    } catch (e) {
      return Future.error(e);
    }
  }

  String userEmail() {
    String email = FirebaseAuth.instance.currentUser!.email ?? "a@a.com";
    return email;
  }
}
