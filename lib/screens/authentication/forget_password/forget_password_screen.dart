// ignore_for_file: use_build_context_synchronously

import "package:flutter/material.dart";
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/screens/authentication/forget_password/create_new_password.dart';
import 'package:tour_drive_frontend/screens/authentication/forget_password/otp_screen.dart';
import 'package:tour_drive_frontend/screens/authentication/sign_in/login_screen.dart';
import 'package:tour_drive_frontend/widgets/default_button.dart';
import 'package:tour_drive_frontend/widgets/header.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {

  late String email;
  final formKey1 = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool isLoading = false;
  bool isError = false;
  String errorMessage = "";

// Sending data to server
Future forgetpassword() async {
  setState(() {
    isLoading = true;
  });
  final response = await http.post(              // send data to server using post method
    Uri.parse('$URL/api/v1/auth/forgotPassword/mobile'),             // end point url
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'cookie': 'jwt=cookie_value',
    },
    body: jsonEncode(<String, String>{                          // what we need to send to the server
      "email": emailController.text,
      
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
                      const Text("Please enter email assosiated with your account.",),
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
                        key: formKey1,
                        child: TextFormField(
                              controller: emailController,
                              validator: (value) {
                                  if (value!.isEmpty) {
                                    return '* Please enter your email';
                                  }
                                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                    return '* Please enter a valid email';
                                  }
                                  return null;
                                },
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: "Email",
                                floatingLabelStyle: const TextStyle(color: kPrimaryColor),
                                contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.028),
                                hintText: 'Enter your Email',
                                suffixIcon: const Icon(Icons.email_outlined, color: kPrimaryColor,),
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
                      DefaultButton(text: "Send", press: () async{

                        var response;

                        if (formKey1.currentState!.validate()) {
                          response =  await forgetpassword();
                          
                        }
                        if (formKey1.currentState!.validate() && response.statusCode == 200) {

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Send OTP Successfully'), 
                              backgroundColor: kPrimaryColor,
                              ),
                          );
                          setState(() {
                            email = emailController.text;
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  CreateNewPasswordScreen(email: email)));
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