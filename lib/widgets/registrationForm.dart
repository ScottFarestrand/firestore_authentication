import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  var phoneFormatter = new MaskTextInputFormatter(mask: '###.###.####');

  @override
  Widget build(BuildContext context) {
    emailController.text = "ScottFarestrand@gmail.com";
    firstNameController.text = "Scott";
    lastNameController.text = "Farestrand";
    passwordController.text = "Jlj#980507";
    passwordConfirmController.text = passwordController.text;
    phoneNumberController.text = "503.475.8281";
    birthDayController.text = DateTime.now().toString();

    // Build a Form widget using the _formKey created above.
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Registration"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 40),
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
                  controller: lastNameController,
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
                  inputFormatters: [phoneFormatter],
                  validator: (value) {
                    print("len");
                    print(value!.length);
                    if (value == null || value.isEmpty  ) {
                      return 'Please enter phone number';
                    }

                    if ( value.length < 12 ){
                      return "Enter full phone number including area code";
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
                    bool spaceFound = RegExp(r".*[ ].*").hasMatch(value.toString());
                    bool specCharFound = RegExp(r".*[\!\~\`\@\#\$\%\^\&\*\(\-\_\+\=\:\;\,\<\.\>\/\?].*").hasMatch(value.toString());
                    if ( numFound == false || letterFound == false || specCharFound == false ) {
                      return "Password must contain at least one number, one letter, and one special character";
                    }
                    if (spaceFound) {
                      return "Password cannot have a space";
                    }
                    int v = value!.length;
                    if ( v < 10 ){
                      return "password should be at least 10 characters";
                    }
                    return null;
                  }
              ),
              TextFormField(
                  controller: passwordConfirmController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password"),
                  validator: (value) {
                    if (value != passwordController.text) {
                      return "Passwords do not match";
                    }

                    return null;
                  }
              ),
              ElevatedButton(
                onPressed: () {
                  print("pressed");
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()){
                    print("valid");
                  }else{
                    print("Not Valid");
                  }

                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Creating User")),
                    );
                    try{

                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim()).
                        then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Created")),
                        );
                          print(value);
                          print(value.user);
                          print(value.credential);
                      });
                    }catch(err){
                      sendVerificationEmail();
                      print(err);

                    }
                  }
                },
                child: const Text('Submit'),
              ),

              // Add TextFormFields and ElevatedButton here.
            ],
          ),
        ),
      ),
    );
  }
  Future sendVerificationEmail() async {
    print("Sending");
    final newUser = FirebaseAuth.instance.currentUser!;
    print(newUser.emailVerified);
    newUser.sendEmailVerification();
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