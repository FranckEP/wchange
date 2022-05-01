import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wchange/domain/controladores/authController.dart';
import 'package:wchange/ui/pages/homepage.dart';
import 'package:wchange/ui/pages/register/register.dart';
import 'package:wchange/ui/pages/registro/mainregistro.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formkey = GlobalKey <FormState>();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  AuthController authController = Get.find();

  _login(theEmail, thePassword) async {
    print('_login $theEmail $thePassword');
    try {
      await authController.login(theEmail, thePassword);
    } catch (err) {
       Get.snackbar(
        "Login",
        err.toString(),
        icon: Icon (Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 400,
                    height: 400,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/W.png"),
                    ))),
                Form(
                  //key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                            Get.to(() => const MyHomePage());
                          },
                          /*onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          final form = _formKey.currentState;
                          form!.save();
                          if (_formKey.currentState!.validate()) {
                              await _login(
                              controllerEmail.text, controllerPassword.text);
                              await authenticationController.usuario(email: controllerEmail.text, password: controllerEmail.text);
                          }
                        },*/
                          child: const Text("Entrar"),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.red),
                            primary: Colors.red,
                          ),
                        ),
                      ]),
                ),
                SizedBox(height: 30),
                OutlinedButton(
                  onPressed: () {
                    Get.to(() => const Register());
                  },
                  child: const Text("Crear cuenta"),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red),
                    primary: Colors.red,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
