import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:uber_clone/pages/auth/loginScreen.dart';
import 'package:uber_clone/pages/mainScreen.dart';
import 'package:uber_clone/services/auth_service.dart';
import 'package:uber_clone/widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  String userName;
  String email;
  ProfilePage({Key? key, required this.userName, required this.email})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 213, 223, 20),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: <Widget>[
            Icon(
              Icons.account_circle,
              size: 150,
              color: Colors.grey[700],
            ),
            Gap(15),
            Text(
              widget.userName,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Gap(30),
            const Divider(
              height: 2,
            ),
            ListTile(
              onTap: () {
                nextScreen(
                  context,
                  const MainScreen(),
                );
              },
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 7,
              ),
              leading: const Icon(Icons.group),
              title: const Text(
                "Groups",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () {},
              selectedColor: const Color.fromARGB(255, 213, 223, 20),
              selected: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 7,
              ),
              leading: const Icon(
                  FluentSystemIcons.ic_fluent_person_accounts_regular),
              title: const Text(
                "Profile",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () async {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Keluar"),
                      content: const Text(
                          "Apakah Anda Yakin Untuk Keluar Aplikasi?"),
                      actions: <Widget>[
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            authService.signOut().whenComplete(
                              () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                    (route) => false);
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.done,
                            color: Color.fromARGB(255, 213, 223, 20),
                          ),
                        ),
                      ],
                    );
                  },
                );
                // authService.signOut().whenComplete(
                //   () {
                //     nextScreenReplace(
                //       context,
                //       const LoginScreen(),
                //     );
                //   },
                // );
              },
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 7,
              ),
              leading: const Icon(Icons.exit_to_app_rounded),
              title: const Text(
                "Keluar",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.account_circle,
                size: 200,
                color: Colors.grey[700],
              ),
              Gap(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    FluentSystemIcons.ic_fluent_person_regular,
                    size: 30,
                  ),
                  Gap(15),
                  Text(
                    widget.userName,
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              Gap(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    FluentSystemIcons.ic_fluent_mail_regular,
                    size: 30,
                  ),
                  Gap(15),
                  Text(
                    widget.email,
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
