import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Define a custom Form widget.
class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  RegistrationFormState createState() {
    return RegistrationFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class RegistrationFormState extends State<RegistrationForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MRegistrationFormState>.
  final _formKey = GlobalKey<FormState>();
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
    // Build a Form widget using the _formKey created above.
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: "First Name"),
              validator: (value) {
                if (value == null || value.isEmpty  ) {
                  return 'Please enter your first Name';
                }
                return null;
              }
            ),
            TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: "Last Name"),
                validator: (value) {
                  if (value == null || value.isEmpty  ) {
                    return 'Please enter your Last Name';
                  }
                  return null;
                }
            ),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: "Email Address"),
                validator: (value) {
                  if ( RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value.toString()) ) {
                    return null;
                  }
                  return 'Please enter a valid email address';
                }
            ),
            TextFormField(
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: "Email Address"),
                validator: (value) {
                  if (value == null || value.isEmpty  ) {
                    return 'Please enter phone number';
                  }
                  return null;
                }
            ),
            TextFormField(
              controller: birthDayController,
              decoration: InputDecoration(labelText: "Birth Date"),
              onTap: () => _selectDate(context),

            ),
            TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
                validator: (value) {

                  bool numFound =  RegExp(r".*[0-9].*").hasMatch(value.toString());
                  bool letterFound =  RegExp(r".*[A-Za-z].*").hasMatch(value.toString());
                  print(numFound);
                  print(letterFound);
                  if ( numFound == false && letterFound == false  ) {
                    return "Password must contain at least one number and one letter";
                  }
                  return null;
                }
            ),
            ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),

            // Add TextFormFields and ElevatedButton here.
          ],
        ),
      ),
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
        birthDayController.text = DateFormat('MMM d, yyyy').format(birthDate);
        birthDate = pickedDate;
      });
  }
}