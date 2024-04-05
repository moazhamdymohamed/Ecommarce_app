// // ignore_for_file: non_constant_identifier_names

// import 'package:flower_app/shared/contants.dart';
// import 'package:flutter/material.dart';

// class Textformfield extends StatelessWidget {
//   Textformfield({super.key});
//   final EmailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return
    
    
//      TextFormField(
//         // we return "null" when something is valid
//         validator: (email) {
//           return email!.contains(RegExp(
//                   r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
//               ? null
//               : "Entr a valid Email...";
//         },
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         controller: EmailController,
//         keyboardType: TextInputType.emailAddress,
//         obscureText: false,
//         decoration: decorationTextfield.copyWith(
//             hintText: "Enter Your Email : ",
//             suffixIcon: const Icon(Icons.email)));
//   }
// }
