import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:uber_clone/helper/helper_function.dart';
import 'package:uber_clone/pages/auth/registrationScreen.dart';
import 'package:uber_clone/pages/mainScreen.dart';
import 'package:uber_clone/services/auth_service.dart';
import 'package:uber_clone/services/database_service.dart';
import 'package:uber_clone/utils/app_layout.dart';
import 'package:uber_clone/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String idScreen = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController =
      TextEditingController();
  String email = "";
  String password = "";
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
                      const SizedBox(
                        height: 35.0,
                      ),
                      const Image(
                        image: AssetImage("images/logo.png"),
                        width: 300.0,
                        height: 250.0,
                        alignment: Alignment.center,
                      ),
                      const SizedBox(
                        height: 1.0,
                      ),
                      Center(
                        child: Text(
                          "Masuk ChatApp",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontFamily: "Brand Bold",
                            color: Color.fromARGB(255, 213, 223, 20),
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
                              controller: _emailTextEditingController,
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
                              onChanged: (val) {
                                setState(() {
                                  email = val;
                                });
                              },
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
                              controller: _passwordTextEditingController,
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
                                  login();
                                },
                                splashColor: Colors.blue,
                                borderRadius: BorderRadius.circular(14),
                                child: Center(
                                  child: Text(
                                    "Masuk",
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
                            RegistrationScreen(),
                          );
                        },
                        splashColor: Colors.white,
                        child: Text("Belum Punya Akun ? Daftar"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .loginWithUserNameandPassword(_emailTextEditingController.text,
              _passwordTextEditingController.text)
          .then(
        (value) async {
          if (value == true) {
            //saving the shared preferences state
            QuerySnapshot snapshot = await DatabaseService(
                    uid: FirebaseAuth.instance.currentUser!.uid)
                .gettingUserData(_emailTextEditingController.text);
            nextScreenReplace(context, const MainScreen());
            //saving the value to our sharedPreferences
            await HelperFunction.saveUserLoggedInStatus(true);
            await HelperFunction.saveUserEmailSF(
                _emailTextEditingController.text);
            await HelperFunction.saveUserNameSF(snapshot.docs[0]['fullName']);
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
