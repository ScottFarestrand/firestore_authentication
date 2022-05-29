
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/register.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    emailController.text = "scottfarestrand@gmail.com";
    passwordController.text = "LI062023";
    return Container(
      color: Theme.of(context).colorScheme.primary,

      // decoration: new BoxDecoration(
      //   // color: Theme.of(context).colorScheme.secondary,
      //   // color: Colors.lightBlue,
      // ),

      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            TextField(
              style: Theme.of(context).textTheme.bodyText2,
              controller: emailController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  labelText: "Enter your Email"
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: passwordController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                  labelText: "Enter your Password"
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  maximumSize: const Size.fromHeight(50),
                ),
                icon: const Icon(Icons.lock_open, size: 32),
                label: const Text("Log in",
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: (){
                  login(emailController.text.trim(), passwordController.text.trim());
                } ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  maximumSize: const Size.fromHeight(50),
                ),
                icon: const Icon(Icons.lock_open, size: 32, color:  Colors.black,),
                label: const Text("Log out",
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
                onPressed: (){
                  logout();
                } ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  maximumSize: const Size.fromHeight(50),
                ),
                icon: const Icon(Icons.app_registration, size: 32, color: Colors.black,),
                label: const Text("Register",
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
                onPressed: (){
                  Navigator.pushNamed(context, Register_Screen.id);
                } ),
          ],
        ),
      ),
    );


  }
}
Future login(email, password) async {
  try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password).then((value) {
      print(value);
      // Navigator.pushNamed(context, UserScreen());
    });
  }catch(e){
    print(e);
  }
}
Future logout() async{
  await FirebaseAuth.instance.signOut();
  print("Logout");
}


// Future register(email, password )async {
//   try{
//     await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email, password: password).then((value) {
//       print(value);
//     });
//   }catch(e){
//     print(e);
//   }
// }
