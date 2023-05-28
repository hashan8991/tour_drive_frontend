import "package:flutter/material.dart";
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/screens/authentication/forget_password/otp_screen.dart';
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
  final formKey1 = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    
     final double screenWidth = MediaQuery.of(context).size.width;
     final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Header(text: "Forget Password", press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
              } ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: screenHeight * 0.03),
                      const Text("Please enter phone number assosiated with your account.",),
                      SizedBox(height: screenHeight * 0.06),
                      Form(
                        key: formKey1,
                        child: TextFormField(
                              controller: phoneController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '* Please enter mobile number';
                                }
                                if (value.length != 10) {
                                  return '* Please enter valid phone number';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Phone Number",
                                floatingLabelStyle: const TextStyle(color: kPrimaryColor),
                                contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.028),
                                hintText: 'Enter your Phone Number',
                                suffixIcon: const Icon(Icons.phone, color: kPrimaryColor,),
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
                      SizedBox(height: screenHeight * 0.08),
                      DefaultButton(text: "Send", press: () {
                        if (formKey1.currentState!.validate()) {

                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(
                          //     content: Text('Send  successfully'), 
                          //     backgroundColor: kPrimaryColor,
                          //     ),
                          // );
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const OtpScreen()));
                        }
                      }),
                      SizedBox(height: screenHeight * 0.04),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}