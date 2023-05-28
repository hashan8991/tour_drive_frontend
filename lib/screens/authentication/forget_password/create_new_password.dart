// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/screens/authentication/forget_password/forget_password_screen.dart';
import 'package:tour_drive_frontend/screens/authentication/sign_in/login_screen.dart';
import 'package:tour_drive_frontend/widgets/default_button.dart';
import 'package:tour_drive_frontend/widgets/header.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class CreateNewPasswordScreen extends StatefulWidget {
  final String email;
  const CreateNewPasswordScreen({super.key, required this.email});

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

  


class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {

  late final String otp;
  final formKey3 = GlobalKey<FormState>();
  final otpController= TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;
  bool isError = false;
  String errorMessage = "";

  // Sending data to server
Future createNewPassword() async {
  print("sos");
  setState(() {
    isLoading = true;
  });
  final response = await http.post(              // send data to server using post method
    Uri.parse('$URL/api/v1/auth/resetPassword/mobile'),             // end point url
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'cookie': 'jwt=cookie_value',
    },
    body: jsonEncode(<String, String>{  
      "otp": otpController.text,
      "email": widget.email,
      "password": newPasswordController.text,
      "passwordConfirm": confirmPasswordController.text
    }),
  );
  setState(() {
    isLoading = false;
  });
  return response;
}
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
              Header(text: "Create new password", press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPasswordScreen()));
              } ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      
                      SizedBox(height: screenHeight * 0.03),
                      const Text("Please enter code sent to your registered email address and give new password",),
                      SizedBox(height: screenHeight * 0.02),
                      isLoading ?
                      Center(
                            child:CircularProgressIndicator(
                              backgroundColor: Colors.grey[200], // Set the background color of the widget
                              valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryColor), // Set the color of the progress indicator
                              strokeWidth: 3, // Set the width of the progress indicator
                            )
                      )
                      :
                      //  display error message             
                      Visibility(
                        visible: isError,
                        child: Text("🛑 $errorMessage " , style: TextStyle(fontSize: screenHeight * 0.02, color: Colors.red,fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Form(
                        key: formKey3,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: otpController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '* Please enter OTP number';
                                }
                            
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "OTP Number",
                                floatingLabelStyle: const TextStyle(color: kPrimaryColor),
                                contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.028),
                                hintText: 'Enter your OTP Number',
                                suffixIcon: const Icon(Icons.numbers, color: kPrimaryColor,),
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
                            SizedBox(height: screenHeight * 0.02),
                            TextFormField(
                              controller: newPasswordController,
                              validator: (value) {
                              if (value!.isEmpty) {
                                return '* Please enter your new password';
                              }
                              if (value.length < 8) {
                                return '* Please enter more than 8 characters';
                              }
                              return null;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "New Password",
                                floatingLabelStyle:
                                    const TextStyle(color: kPrimaryColor),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.05,
                                    vertical: screenHeight * 0.028),
                                hintText: 'Enter your new password',
                                suffixIcon: const Icon(
                                  Icons.lock,
                                  color: kPrimaryColor,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(screenHeight * 0.03),
                                  borderSide: const BorderSide(color: kPrimaryColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(screenHeight * 0.03),
                                  borderSide: const BorderSide(color: kPrimaryColor),
                                )),
                              ),
                               SizedBox(height: screenHeight * 0.02),
                          TextFormField(
                            controller: confirmPasswordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '* Please enter your Password';
                              }
                              if (value.length < 8) {
                                return '* Please enter more than 8 characters';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: "Confirm Password",
                                floatingLabelStyle:
                                    const TextStyle(color: kPrimaryColor),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.05,
                                    vertical: screenHeight * 0.028),
                                hintText: 'Re-enter your confirm password',
                                suffixIcon: const Icon(
                                  Icons.lock,
                                  color: kPrimaryColor,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(screenHeight * 0.03),
                                  borderSide: const BorderSide(color: kPrimaryColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(screenHeight * 0.03),
                                  borderSide: const BorderSide(color: kPrimaryColor),
                                )),
                            ),
                          ],
                        ),
                      ),
                       
                          SizedBox(height: screenHeight * 0.08),
                          DefaultButton(text: "Update Password", press: () async{

                            var response;

                            if (formKey3.currentState!.validate()) {
                              response =  await createNewPassword();
                            }

                            if (formKey3.currentState!.validate() && response.statusCode == 200) {

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Create New Password successfully'), 
                                  backgroundColor: kPrimaryColor,
                                  ),
                              );
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
                            }else{

                              final Map<String, dynamic> responseData = json.decode(response.body);
                              errorMessage = responseData["message"];
                              setState(() {
                                isError = true;
                            });
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