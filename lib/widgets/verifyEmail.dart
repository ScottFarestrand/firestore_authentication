import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          Text('Verify ME!'),
          ElevatedButton(onPressed: () {
            sendVerificationEmail();
          }, child: Text('Send Verification Email'),)
        ],
      ),);
  }
  Future sendVerificationEmail() async{
    try {
      final user = FirebaseAuth.instance.currentUser!;
      user.sendEmailVerification().then((value) {
        print(user.email);
        print("Success");


      });
    } catch(err){
      print("Error");
      print(err);
    }

  }
}
