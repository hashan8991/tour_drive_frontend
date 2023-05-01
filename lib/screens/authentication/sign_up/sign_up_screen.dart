// ignore_for_file: use_build_context_synchronously

import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/screens/authentication/sign_in/login_screen.dart';
import 'package:tour_drive_frontend/screens/navbar_main_page/navbar_main_page.dart';
import 'package:tour_drive_frontend/widgets/default_button.dart';
import 'package:tour_drive_frontend/widgets/header.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen> {

  String? country,password;
  late final String email,fName,lName,confirmPassword;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isError = false;
  String errorMessage = "";
  late bool isloading = false;

  // Sending data to server
Future registerUser(TextEditingController emailController,TextEditingController passwordController,TextEditingController confirmPasswordController) async {
  setState(() {
    isloading = true;
  });
  final response = await http.post(                             // send data to server using post method
    Uri.parse('$URL/api/v1/auth/signup'),             // end point url
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'cookie': 'jwt=cookie_value',
    },
    body: jsonEncode(<String, String>{                          // what we need to send to the server
      "email": emailController.text,
      "password": passwordController.text,
      "passwordConfirm": confirmPasswordController.text,
    }),
  );
  setState(() {
    isloading = false;
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
              Header(text: "Sign Up", press: () {
                Navigator.pop(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
              } ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      
                      SizedBox(height: screenHeight * 0.01),
                      const Text("Please enter your profile information.",),
                      SizedBox(height: screenHeight * 0.02),

                      isloading ?
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
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                                controller: emailController,
                                onSaved: (value)  {
                                  email = value!;
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
                            SizedBox(height: screenHeight * 0.02),
                            TextFormField(
                              controller: passwordController,
                              onSaved: (value)  {
                                password = value!;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '* Please enter your Password';
                                }
                                if ( value.length < 8) {
                                  return '* Please enter more than 8 characters';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "Password",
                                floatingLabelStyle: const TextStyle(color: kPrimaryColor),
                                contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.028),
                                hintText: 'Enter your password',
                                suffixIcon: const Icon(Icons.lock, color: kPrimaryColor,),
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
                              controller: confirmPasswordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '* Please enter your re-password';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "Retype Password",
                                floatingLabelStyle: const TextStyle(color: kPrimaryColor),
                                contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.028),
                                hintText: 'Enter your password',
                                suffixIcon: const Icon(Icons.lock, color: kPrimaryColor,),
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
                            
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      
                      DefaultButton(
                        text: "Submit", 
                        press: () async {
                          // get response from the server
                          var response = await registerUser(emailController, passwordController, confirmPasswordController);

                          if( formKey.currentState!.validate() && response.statusCode == 201 ) {   
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Profile creation successfully'), 
                                backgroundColor: kPrimaryColor,
                                ),
                            );
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const NavbarMainPage()));

                            // register successful, extract the  user ID from the response body
                            final Map<String, dynamic> responseData = json.decode(response.body);
                            final String userId = responseData['data']["user"]["_id"];

                            // Store the  user ID in shared preferences
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString('userId', userId);
                          }else{
                            final Map<String, dynamic> responseData = json.decode(response.body);
                            errorMessage = responseData["message"];
                            setState(() {
                              isError = true;
                            });
                          }
                        }
                      ),

                      SizedBox(height: screenHeight * 0.02),
                      const Text("If you have already account ?",),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: kPrimaryColor,
                        ),
                        child: Text(
                          'Login',
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
            ],
          ),
        ),
      ),
    );
  }
}




