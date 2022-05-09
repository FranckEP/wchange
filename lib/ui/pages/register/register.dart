import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wchange/domain/controladores/authController.dart';
import 'package:wchange/ui/pages/login/login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController();
  final controllerName = TextEditingController();
  final controllerPassword = TextEditingController();
  AuthController authController = Get.find();

  _signup(email, password, name) async {
    try {
      await authController.signUp(email: email, password: password, name: name);
      Get.snackbar(
        "Sign Up",
        'OK',
        icon: Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (err) {
      Get.snackbar(
        "Sign Up",
        err.toString(),
        icon: Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.red,
        shadowColor: Colors.transparent,
        title: Text('Nuevo Registro'),
        backgroundColor: Colors.white,
      ),
      body: ListView(children: [
        Container(
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 300,
                      height: 300,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("assets/W.png"),
                      ))),
                  Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              controller: controllerName,
                              decoration: InputDecoration(
                                labelText: "Nombre completo",
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
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter user";
                                } else if (value.length < 6) {
                                  return "Enter valid user";
                                }
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: controllerEmail,
                              decoration: InputDecoration(
                                labelText: "Email",
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
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Ingrese el email";
                                } else if (!value.contains('@')) {
                                  return "Ingrese un email válido";
                                }
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: controllerPassword,
                              decoration: InputDecoration(
                                labelText: "Contraseña",
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
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Ingrese la contraseña";
                                } else if (value.length < 6) {
                                  return "La contraseña debería tener como mínimo 6 carácteres";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            OutlinedButton(
                              onPressed: () {
                                final form = _formKey.currentState;
                                form!.save();
                                // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                if (_formKey.currentState!.validate()) {
                                  _signup(
                                      controllerEmail.text,
                                      controllerPassword.text,
                                      controllerName.text);
                                  Get.to(() => const LoginWidget());
                                }
                              },
                              child: const Text("Registrarse"),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.red),
                                primary: Colors.red,
                              ),
                            ),
                          ]))
                ])),
      ]),
    );
  }
}
