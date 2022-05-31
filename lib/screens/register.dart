import 'package:flutter/material.dart';
import '../widgets/registrationForm.dart';


class Register_Screen extends StatefulWidget {
  const Register_Screen({Key? key}) : super(key: key);
  static const id = "Register_Screen";

  @override
  State<Register_Screen> createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final birthDayController = TextEditingController();
  DateTime birthDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: const RegistrationForm(),

      ),
    );
  }
}


