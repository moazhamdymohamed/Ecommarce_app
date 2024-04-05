// ignore_for_file: prefer_const_constructors, unused_import, curly_braces_in_flow_control_structures

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flower_app/firebase_options.dart';
import 'package:flower_app/pages/checkout.dart';
import 'package:flower_app/pages/details_screen.dart';
import 'package:flower_app/pages/home.dart';
import 'package:flower_app/pages/login.dart';
import 'package:flower_app/pages/register.dart';
import 'package:flower_app/pages/veryfiyEmail.com.dart';
import 'package:flower_app/provider/Google.sigin.dart';
import 'package:flower_app/provider/cart.dart';
import 'package:flower_app/shared/showSnackpar.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

void main() async {


  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) {
            return Cart();
          }),
          ChangeNotifierProvider(create: (context) {
            return GoogleSignInProvider();
          }),
        ],
        child: MaterialApp(
            title: "myApp", debugShowCheckedModeBanner: false, home: Home()
            // StreamBuilder(
            //   stream: FirebaseAuth.instance.authStateChanges(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return Center(
            //           child: CircularProgressIndicator(
            //         color: Colors.white,
            //       ));
            //     } else if (snapshot.hasError) {
            //       return showSnackBar(context, "Something went wrong");
            //     } else if (snapshot.hasData) {
            //       return VerifyEmailPage(); // home() OR verify email
            //     } else {
            //       return Login();
            //     }
            //   },
            // )),
            ));
  }
}
