import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  prefixIcon: Icon(Icons.email),
  labelText: "Email",
  labelStyle: TextStyle(
    fontSize: 17.0,
    color: Color.fromARGB(255, 213, 223, 20),
  ),
  prefixIconColor: Color.fromARGB(255, 213, 223, 20),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      width: 1,
      color: Color.fromARGB(255, 213, 223, 20),
    ),
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(
      width: 1,
      color: Color.fromARGB(255, 213, 223, 20),
    ),
  ),
);

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplace(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 14.0),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
        textColor: Colors.white,
      ),
    ),
  );
}

// InputDecoration(
//                         prefixIcon: Icon(Icons.email),
//                         labelText: "Email",
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             width: 1,
//                             color: Color.fromARGB(255, 213, 223, 20),
//                           ),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         labelStyle: TextStyle(
//                           fontSize: 14.0,
//                         ),
//                         hintStyle:
//                             TextStyle(color: Colors.grey, fontSize: 10.0),
//                       ),


// InputDecoration(
//                         prefixIcon: Icon(Icons.lock),
//                         labelText: "Password",
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             width: 1,
//                             color: Color.fromARGB(255, 213, 223, 20),
//                           ),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         labelStyle: TextStyle(
//                           fontSize: 14.0,
//                         ),
//                         hintStyle:
//                             TextStyle(color: Colors.grey, fontSize: 10.0),
//                       ),