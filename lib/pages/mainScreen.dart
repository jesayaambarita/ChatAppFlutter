import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:uber_clone/helper/helper_function.dart';
import 'package:uber_clone/pages/auth/loginScreen.dart';
import 'package:uber_clone/pages/profile_page.dart';
import 'package:uber_clone/pages/search_page.dart';
import 'package:uber_clone/services/auth_service.dart';
import 'package:uber_clone/services/database_service.dart';
import 'package:uber_clone/widgets/group_tile.dart';
import 'package:uber_clone/widgets/widgets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const String idScreen = "mainScreen";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String userName = "";
  String email = "";
  AuthService authService = AuthService();
  Stream? groups;
  bool _isLoading = false;
  TextEditingController _groupController = TextEditingController();
  String groupName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettingUserData();
  }

  //string manipulation
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    await HelperFunction.getUserEmailFromSF().then(
      (value) {
        setState(() {
          email = value!;
        });
      },
    );
    await HelperFunction.getUserNameFromSF().then(
      (value) {
        setState(() {
          userName = value!;
        });
      },
    );
    //getting the list of snapshot in our stream
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      setState(() {
        groups = snapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              nextScreen(
                context,
                const SearchPage(),
              );
            },
            icon: const Icon(FluentSystemIcons.ic_fluent_search_regular),
          ),
        ],
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 213, 223, 20),
        centerTitle: true,
        title: const Text(
          "Chatting",
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
              userName,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Gap(30),
            const Divider(
              height: 2,
            ),
            ListTile(
              onTap: () {},
              selectedColor: const Color.fromARGB(255, 213, 223, 20),
              selected: true,
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
              onTap: () {
                nextScreenReplace(
                  context,
                  ProfilePage(
                    userName: userName,
                    email: email,
                  ),
                );
              },
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
      body: groupList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          popUpDialog(context);
        },
        backgroundColor: const Color.fromARGB(255, 213, 223, 20),
        elevation: 0,
        child: const Icon(
          FluentSystemIcons.ic_fluent_add_regular,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  popUpDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: ((context, setState) {
              return AlertDialog(
                title: const Text(
                  "Buat Group Baru",
                  textAlign: TextAlign.left,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _isLoading == true
                        ? Center(
                            child: CircularProgressIndicator(
                              color: const Color.fromARGB(255, 213, 223, 20),
                            ),
                          )
                        : TextField(
                            controller: _groupController,
                            onChanged: (val) {
                              setState(() {
                                groupName = val;
                              });
                            },
                            decoration: textInputDecoration.copyWith(
                              labelText: "Nama Group",
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
                                Icons.group_add,
                                color: Color.fromRGBO(213, 223, 20, 1),
                              ),
                            ),
                          ),
                  ],
                ),
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
                      if (groupName != "") {
                        setState(() {
                          _isLoading = true;
                        });
                        DatabaseService(
                                uid: FirebaseAuth.instance.currentUser!.uid)
                            .createGroup(
                                _groupController.text,
                                FirebaseAuth.instance.currentUser!.uid,
                                groupName)
                            .whenComplete(
                          () {
                            _isLoading = false;
                          },
                        );
                        Navigator.of(context).pop();
                        showSnackbar(context, Color.fromRGBO(213, 223, 20, 1),
                            "Berhasil Membuat Group");
                      }
                    },
                    icon: const Icon(
                      Icons.done,
                      color: Color.fromARGB(255, 213, 223, 20),
                    ),
                  ),
                ],
              );
            }),
          );
        });
  }

  groupList() {
    return StreamBuilder(
      stream: groups,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //make some checks
        if (snapshot.hasData) {
          if (snapshot.data['groups'] != null) {
            if (snapshot.data['groups'].length != 0) {
              return ListView.builder(
                itemCount: snapshot.data['groups'].length,
                itemBuilder: (context, index) {
                  int reverseIndex = snapshot.data['groups'].length - index - 1;
                  return GroupTile(
                    userName: snapshot.data['fullName'],
                    groupId: getId(snapshot.data['groups'][reverseIndex]),
                    groupName: getName(
                      snapshot.data['groups'][reverseIndex],
                    ),
                  );
                },
              );
            } else {
              return noGroupWidget();
            }
          } else {
            return noGroupWidget();
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: const Color.fromARGB(255, 213, 223, 20),
            ),
          );
        }
      },
    );
  }

  noGroupWidget() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                popUpDialog(context);
              },
              child: Icon(
                Icons.add_circle,
                color: Colors.grey[700],
                size: 75,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Kamu belum masuk ke group manapun, Click tombol ini untuk membuat group atau click tombol cari",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
