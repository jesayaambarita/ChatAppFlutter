import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:uber_clone/helper/helper_function.dart';
import 'package:uber_clone/pages/auth/loginScreen.dart';
import 'package:uber_clone/pages/auth/loginScreen.dart';
import 'package:uber_clone/pages/mainScreen.dart';
import 'package:uber_clone/services/auth_service.dart';
import 'package:uber_clone/utils/app_layout.dart';
import 'package:uber_clone/widgets/widgets.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  static const String idScreen = "register";

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _isLoading = false;
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullName = "";
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(213, 223, 20, 1),
              ),
            )
          : ListView(
              children: <Widget>[
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 35.0,
                      ),
                      Image(
                        image: AssetImage("images/logo.png"),
                        width: 300.0,
                        height: 250.0,
                        alignment: Alignment.center,
                      ),
                      SizedBox(
                        height: 1.0,
                      ),
                      Center(
                        child: Text(
                          "Daftar ChatApp",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontFamily: "Brand Bold",
                            color: Color.fromRGBO(213, 223, 20, 1),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 1.0,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20.0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: nameTextEditingController,
                              keyboardType: TextInputType.name,
                              decoration: textInputDecoration.copyWith(
                                labelText: "Nama",
                                labelStyle: TextStyle(
                                  fontSize: 17.0,
                                  color: Color.fromRGBO(213, 223, 20, 1),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromRGBO(213, 223, 20, 1),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromRGBO(213, 223, 20, 1),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Color.fromRGBO(213, 223, 20, 1),
                                ),
                              ),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Nama Anda Tidak Boleh Kosong";
                                } else {}
                              },
                            ),
                            Gap(10),
                            TextFormField(
                              controller: emailTextEditingController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: textInputDecoration.copyWith(
                                labelText: "Email",
                                labelStyle: TextStyle(
                                  fontSize: 17.0,
                                  color: Color.fromRGBO(213, 223, 20, 1),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromRGBO(213, 223, 20, 1),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromRGBO(213, 223, 20, 1),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Color.fromRGBO(213, 223, 20, 1),
                                ),
                              ),
                              validator: (val) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)+")
                                        .hasMatch(val!)
                                    ? null
                                    : "Tolong Isi Email Yang Valid";
                              },
                            ),
                            Gap(10),
                            TextFormField(
                              controller: passwordTextEditingController,
                              obscureText: true,
                              decoration: textInputDecoration.copyWith(
                                labelText: "Password",
                                labelStyle: TextStyle(
                                  fontSize: 17.0,
                                  color: Color.fromRGBO(213, 223, 20, 1),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromRGBO(213, 223, 20, 1),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromRGBO(213, 223, 20, 1),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Color.fromRGBO(213, 223, 20, 1),
                                ),
                              ),
                              validator: (val) {
                                if (val!.length < 6) {
                                  return "Password Anda Kurang Dari 6 ";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: Material(
                          borderRadius: BorderRadius.circular(14),
                          elevation: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 213, 223, 20),
                                borderRadius: BorderRadius.circular(14)),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  register();
                                },
                                splashColor: Colors.blue,
                                borderRadius: BorderRadius.circular(14),
                                child: Center(
                                  child: Text(
                                    "Daftar",
                                    style: Styles.headLineStyle3
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          nextScreen(
                            context,
                            LoginScreen(),
                          );
                        },
                        splashColor: Colors.white,
                        child: Text("Sudah Punya Akun ? Masuk"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailandPassword(
              nameTextEditingController.text,
              emailTextEditingController.text,
              passwordTextEditingController.text)
          .then(
        (value) async {
          if (value == true) {
            //saving the shared preferences state
            await HelperFunction.saveUserLoggedInStatus(true);
            await HelperFunction.saveUserEmailSF(
                emailTextEditingController.text);
            await HelperFunction.saveUserNameSF(nameTextEditingController.text);
            nextScreenReplace(context, const MainScreen());
          } else {
            // showSnackbar(context, Color.fromARGB(255, 213, 223, 20), value);
            setState(() {
              _isLoading = false;
            });
          }
        },
      );
    }
  }
}
