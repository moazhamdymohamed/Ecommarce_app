// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, avoid_print, unused_local_variable, use_build_context_synchronously, avoid_single_cascade_in_expression_statements, deprecated_member_use
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app/pages/forgotpassword.dart';
import 'package:flower_app/pages/register.dart';
import 'package:flower_app/provider/Google.sigin.dart';
import 'package:flower_app/shared/colors.dart';
import 'package:flower_app/shared/contants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final EmailController = TextEditingController();
  final passwordController = TextEditingController();

  login() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: EmailController.text, password: passwordController.text);
      print("Done=============");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(days: 1),
        content: Text("done."),
        action: SnackBarAction(label: "close", onPressed: () {}),
      ));
    } catch (e) {
      AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Error ',
          desc: 'The password or email is Erorr')
        ..show();
    }
  }

  @override
  void dispose() {
    EmailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: appbarGreen,
          title: Text(
            "log in",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(33.0),
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                const SizedBox(
                  height: 64,
                ),
                TextField(
                    controller: EmailController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    decoration: decorationTextfield.copyWith(
                      hintText: "Enter Your Email : ",
                    )),
                const SizedBox(
                  height: 33,
                ),
                TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: decorationTextfield.copyWith(
                      hintText: "Enter Your Password : ",
                    )),
                const SizedBox(
                  height: 29,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await login();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(days: 1),
                      content: Text("done."),
                      action: SnackBarAction(label: "close", onPressed: () {}),
                    ));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(BTNgreen),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 35, vertical: 14)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                  ),
                  child: Text(
                    "login",
                    style: TextStyle(fontSize: 19),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Forgotpassword()),
                      );
                    },
                    child: Text('forgot password',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline))),
                SizedBox(
                  height: 10,
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
                                builder: (context) => const Register()),
                          );
                        },
                        child: Text('sign up',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline))),
                  ],
                ),
                SizedBox(
                  height: 20,
                  width: 299,
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: 0.6,
                      )),
                      Text(
                        "OR",
                        style: TextStyle(),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 0.6,
                      )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 27),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          googleSignInProvider.googlelogin();
                        },
                        child: Container(
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.red, width: 1)),
                          child: SvgPicture.asset(
                            "assets/icons/icons8-google.svg",
                            color: Colors.red,
                            height: 27,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ])),
        )));
  }
}
