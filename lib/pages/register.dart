// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, avoid_print, unused_local_variable, use_build_context_synchronously, avoid_single_cascade_in_expression_statements, non_constant_identifier_names

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app/pages/login.dart';
import 'package:flower_app/shared/colors.dart';
import 'package:flower_app/shared/contants.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isPassword8Char = false;
  bool ispasswordHas1num = false;
  bool hasubercase = false;
  bool haslowercase = false;
  bool hasspcialcaracter = false;

  onpasswordchanged(String password) {
    isPassword8Char = false;
    ispasswordHas1num = false;
    hasubercase = false;
    haslowercase = false;
    hasspcialcaracter = false;

    setState(() {
      if (password.contains(RegExp(r'.{8,}'))) {
        isPassword8Char = true;
      }
      if (password.contains(RegExp(r'[0-9]'))) {
        ispasswordHas1num = true;
      }
      if (password.contains(RegExp(r'[A-Z]'))) {
        hasubercase = true;
      }
      if (password.contains(RegExp(r'[a-z]'))) {
        haslowercase = true;
      }
      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        hasspcialcaracter = true;
      }
    });
  }

  bool isVisablty = true;
  bool isloading = false;
  final EmailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  register() async {
    setState(() {
      isloading = true;
    });
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: EmailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Error ',
          desc: 'The password  is too weak',
        )..show();
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Error ',
          desc: 'The account already exists for that email.',
        )..show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Error ',
          desc: ' peleas try again...🧐',
        )..show();
      }
    } catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error ',
        desc: (e).toString(),
      )..show();
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  void dispose() {
    EmailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
          elevation: 0,
          backgroundColor: appbarGreen,
        ),
        backgroundColor: Color.fromARGB(255, 247, 247, 247),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextField(
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: decorationTextfield.copyWith(
                            hintText: "Enter Your username : ",
                            suffixIcon: Icon(Icons.person))),
                    const SizedBox(
                      height: 33,
                    ),
                    TextFormField(
                        // we return "null" when something is valid
                        validator: (Email) {
                          return Email!.contains(RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                              ? null
                              : "Entr a valid Email...";
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: EmailController,
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        decoration: decorationTextfield.copyWith(
                            hintText: "Enter Your Email : ",
                            suffixIcon: Icon(Icons.email))),
                    const SizedBox(
                      height: 33,
                    ),
                    TextFormField(
                        onChanged: (password) {
                          onpasswordchanged(password);
                        },
                        // we return "null" when something is valid
                        validator: (value) {
                          return value!.length < 8
                              ? "Enter at least 6 characters"
                              : null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: isVisablty ? true : false,
                        decoration: decorationTextfield.copyWith(
                            hintText: "Enter Your Password : ",
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisablty = !isVisablty;
                                  });
                                },
                                icon: isVisablty
                                    ? Icon(Icons.visibility)
                                    : Icon(Icons.visibility_off)))),
                    const SizedBox(
                      height: 33,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                isPassword8Char ? Colors.green : Colors.white,
                            border: Border.all(
                                color: Color.fromARGB(255, 189, 189, 189)),
                          ),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text("At least 8 characters"),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                ispasswordHas1num ? Colors.green : Colors.white,
                            border: Border.all(
                                color: Color.fromARGB(255, 189, 189, 189)),
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text("At least 1 number"),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: hasubercase ? Colors.green : Colors.white,
                            border: Border.all(
                                color: Color.fromARGB(255, 189, 189, 189)),
                          ),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text("Has Uppercase"),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: haslowercase ? Colors.green : Colors.white,
                            border: Border.all(
                                color: Color.fromARGB(255, 189, 189, 189)),
                          ),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text("Has  Lowercase "),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                hasspcialcaracter ? Colors.green : Colors.white,
                            border: Border.all(
                                color: Color.fromARGB(255, 189, 189, 189)),
                          ),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text("Has  Special Characters "),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await register();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(days: 1),
                            content: Text("Done.."),
                            action: SnackBarAction(
                                label: "close", onPressed: () {}),
                          ));

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        } else {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error ',
                            desc: ' peleas try again...🧐',
                          )..show();
                        }
                      },
                      child: isloading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Register",
                              style: TextStyle(fontSize: 19),
                            ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(BTNgreen),
                        padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                      ),
                    ),
                    const SizedBox(
                      height: 33,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Do not have an account?",
                            style: TextStyle(fontSize: 18)),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            },
                            child: Text('sign in',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18))),
                    
                    
                      ],
                      
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
