import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'dart:async';


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
      // color: Theme.of(context).colorScheme.primary,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
          const SizedBox(height: 40),
          TextField(
            controller: firstNameController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
                labelText: "Enter your First Name"
            ),
          ),
          TextField(
            controller: lastNameController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
                labelText: "Enter your Last Name"
            ),
          ),
          TextField(
            controller: emailController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
                labelText: "Enter your Email"
            ),
          ),
          TextField(
            controller: phoneNumberController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
                labelText: "Enter your Phone Number"
            ),
          ),
            TextField(
            controller: passwordController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
                labelText: "Enter your Password"
            ),
          ),
          TextField(
            controller: passwordConfirmController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
                labelText: "Confirm your Password"
            ),
          ),
          ElevatedButton(
            onPressed: () => _selectDate(context),//=> _selectDate(context),
            child:  Text("Birth Date : $DateFormat('MMM d, yyyy').format(birthDate)"),
          ),
          ElevatedButton(onPressed: (){
            bool validEntry = _editRegistration();
            if (validEntry) {};
          }, child: Text("Register"))
      ],),
        ),),
    );
  }
  Future<void> _selectDate(BuildContext context) async {
    final mydate = DateTime.now().year + 0;
    print(mydate);
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: birthDate,
      firstDate: DateTime((DateTime.now().year - 125)),
      // lastDate: DateTime((DateTime.now().year - 0)),
      lastDate: DateTime(DateTime.now().year + 1),
// firstDate: DateTime(DateTime.now().year - 125),
        // lastDate: DateTime(DateTime.now().year),
    );
    if (pickedDate != null && pickedDate != birthDate && pickedDate.compareTo(DateTime.now())<0)
      setState(() {
        birthDate = pickedDate;
      });
  }
  bool _editRegistration(){
    return false;
  }
}


