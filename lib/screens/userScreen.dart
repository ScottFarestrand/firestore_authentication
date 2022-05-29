import 'package:flutter/material.dart';
class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);
  static const id = "User_Screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("User SCreen", style: TextStyle(fontSize: 30),),
    );
  }
}

