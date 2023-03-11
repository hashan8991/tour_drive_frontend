import "package:flutter/material.dart";
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/screens/authentication/sign_in/login_screen.dart';
import 'package:tour_drive_frontend/widgets/default_button.dart';
import 'package:tour_drive_frontend/widgets/header.dart';
//import 'package:tour_drive_frontend/size_config.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  late final String email;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    
     final double screenWidth = MediaQuery.of(context).size.width;
     final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Header(text: "Forget Password", press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
                } ),
                SizedBox(height: screenHeight * 0.02),
                const Text("Please enter the email address assosiated with your account.",),
                SizedBox(height: screenHeight * 0.04),
                Form(
                  key: formKey,
                  child: TextFormField(
                        controller: emailController,
                        onSaved: (name)  {
                          email = name!;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '* Please enter your email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return '* Please enter a valid email';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          floatingLabelStyle: const TextStyle(color: kPrimaryColor),
                          contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.028),
                          hintText: 'Enter your email',
                          suffixIcon: const Icon(Icons.email, color: kPrimaryColor,),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(screenHeight * 0.03),
                            borderSide: const BorderSide(color: kPrimaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(screenHeight * 0.03),
                            borderSide: const BorderSide(color: kPrimaryColor),
                          )
                        ),
                      ),
                ),
                SizedBox(height: screenHeight * 0.02),
                // Row(
                //   children: [
                //     const Icon(Icons.warning, color: kPrimaryColor,),
                //     SizedBox(width: screenWidth * 0.02,),
                //     const Text("Enter the valid email address", ),
                //   ],
                // ),
                SizedBox(height: screenHeight * 0.04),
                DefaultButton(text: "Send", press: () {
                  if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Send email successfully'), 
                        backgroundColor: kPrimaryColor,
                        ),
                    );
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
                  }
                }),
                SizedBox(height: screenHeight * 0.04),
                const Text("If you still need help, contact ?",),
                TextButton(
                  onPressed: () {
                    // Add forgot password logic here
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: kPrimaryColor,
                  ),
                  child: Text(
                    'TourDrive Support',
                    style: TextStyle(
                      fontSize: screenHeight * 0.02,
                      color: kPrimaryColor,
                    ),
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