// ignore_for_file: non_constant_identifier_names, must_be_immutable, use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app/pages/login.dart';
import 'package:flower_app/shared/colors.dart';
import 'package:flower_app/shared/contants.dart';
import 'package:flutter/material.dart';

class Forgotpassword extends StatelessWidget {
  Forgotpassword({super.key});
  final _formKey = GlobalKey<FormState>();
  final EmailController = TextEditingController();
  bool mounted = true;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    resetpassword() async {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          });

      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: EmailController.text);

        Navigator.pop(context);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Login()));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(days: 1),
          content: const Text("Error.."),
          action: SnackBarAction(label: "close", onPressed: () {}),
        ));

        // Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("forgot password"),
        elevation: 0,
        backgroundColor: appbarGreen,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(33.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Entre your Email to rest your password",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 33,
                ),
                // Textformfield(),
                TextFormField(
                    // we return "null" when something is valid
                    validator: (email) {
                      return email!.contains(RegExp(
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
                        suffixIcon: const Icon(Icons.email))),
                const SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      resetpassword();
                    } else {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error ',
                        desc: ' Entre a valid Email...🧐',
                      ).show();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(BTNgreen),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(16)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                  ),
                  child: isloading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Reset password",
                          style: TextStyle(fontSize: 19),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
