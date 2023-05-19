import 'package:flutter/material.dart';
import 'package:quiz_app/model/user_model.dart';
import 'package:quiz_app/view/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(
          user: UserModel(
              name: "Abdullah Mezied",
              email: "abdullah@gmail.com",
              profilePicture: "")),
    );
  }
}
