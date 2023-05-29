// import 'package:flutter/material.dart';
// import 'package:tour_drive_frontend/constants.dart';
// import 'package:tour_drive_frontend/screens/authentication/forget_password/create_new_password.dart';
// import 'package:tour_drive_frontend/screens/authentication/forget_password/forget_password_screen.dart';
// import 'package:tour_drive_frontend/screens/authentication/sign_in/login_screen.dart';
// import 'package:tour_drive_frontend/widgets/default_button.dart';
// import 'package:tour_drive_frontend/widgets/header.dart';

// class OtpScreen extends StatefulWidget {
//   const OtpScreen({super.key});

//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {

//   late final String otp;
//   final formKey2 = GlobalKey<FormState>();
//   final otpController = TextEditingController();
//   bool isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//      final double screenHeight = MediaQuery.of(context).size.height;

//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             children: [
//               Header(text: "Enter OTP", press: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPasswordScreen()));
//               } ),
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   child: Column(
//                     children: <Widget>[
                      
//                       SizedBox(height: screenHeight * 0.03),
//                       const Text("Please enter code sent to your registered mobile number",),
//                       SizedBox(height: screenHeight * 0.06),
//                       Form(
//                         key: formKey2,
//                         child: TextFormField(
//                               controller: otpController,
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return '* Please enter OTP number';
//                                 }
                            
//                                 return null;
//                               },
//                               keyboardType: TextInputType.number,
//                               decoration: InputDecoration(
//                                 labelText: "OTP Number",
//                                 floatingLabelStyle: const TextStyle(color: kPrimaryColor),
//                                 contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.028),
//                                 hintText: 'Enter your OTP Number',
//                                 suffixIcon: const Icon(Icons.numbers, color: kPrimaryColor,),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(screenHeight * 0.03),
//                                   borderSide: const BorderSide(color: kPrimaryColor),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(screenHeight * 0.03),
//                                   borderSide: const BorderSide(color: kPrimaryColor),
//                                 )
//                               ),
//                             ),
//                       ),

//                       SizedBox(height: screenHeight * 0.08),
//                       DefaultButton(text: "Submit", press: () {
//                         if (formKey2.currentState!.validate()) {
//                           // ScaffoldMessenger.of(context).showSnackBar(
//                           //   const SnackBar(
//                           //     content: Text('Send  successfully'), 
//                           //     backgroundColor: kPrimaryColor,
//                           //     ),
//                           // );
//                           Navigator.push(context, MaterialPageRoute(builder: (context) =>  CreateNewPasswordScreen(email: "")));
//                         }
//                       }),
//                       SizedBox(height: screenHeight * 0.04),
                      

//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }