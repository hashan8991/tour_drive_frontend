// ignore_for_file: use_build_context_synchronously
import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/screens/authentication/forget_password/forget_password_screen.dart';
import 'package:tour_drive_frontend/screens/loading/loading_screen.dart';
import 'package:tour_drive_frontend/screens/navbar_main_page/navbar_main_page.dart';
import 'package:tour_drive_frontend/screens/authentication/sign_up/sign_up_screen.dart';
import 'package:tour_drive_frontend/widgets/default_button.dart';
import 'package:tour_drive_frontend/widgets/header.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  late final String email, password;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isError = false;
  String errorMessage = "";
  late bool isloading = false ;

  // Sending data to server
  Future loginUser(TextEditingController emailController,TextEditingController passwordController) async {

    setState(() {
      isloading = true;
    });

    final response = await http.post( // send data to server using post method
      Uri.parse('$URL/api/v1/auth/login'), // end point url
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'cookie': 'jwt=cookie_value',
      },
      body: jsonEncode(<String, String>{ // what we need to send to the server
        "email": emailController.text,
        "password": passwordController.text,
      }),
    );

    setState(() {
      isloading = false ;
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
              Header(
                text: "Sign In",
                press: () {
                  Navigator.pop(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoadingScreen()));
                }
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05), 
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical, 
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: screenHeight * 0.02),
                      const Text(
                        "Hey, Enter your details to get sign in ",
                      ),
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
                      SizedBox(height: screenHeight * 0.02),       
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
                              onSaved: (name) {
                                email = name!;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '* Please enter your email';
                                }
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value)) {
                                  return '* Please enter a valid email';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: "Email",
                                  floatingLabelStyle:
                                      const TextStyle(color: kPrimaryColor),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.05,
                                      vertical: screenHeight * 0.028),
                                  hintText: 'Enter your email',
                                  suffixIcon: const Icon(
                                    Icons.email,
                                    color: kPrimaryColor,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(screenHeight * 0.03),
                                    borderSide:
                                        const BorderSide(color: kPrimaryColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(screenHeight * 0.03),
                                    borderSide:
                                        const BorderSide(color: kPrimaryColor),
                                  )),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            TextFormField(
                              controller: passwordController,
                              onSaved: (value) {
                                password = value!;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '* Please enter your Password';
                                }
                                if (value.length < 3) {
                                  return '* Please enter valid email';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                  labelText: "Password",
                                  floatingLabelStyle:
                                      const TextStyle(color: kPrimaryColor),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.05,
                                      vertical: screenHeight * 0.028),
                                  hintText: 'Enter your password',
                                  suffixIcon: const Icon(
                                    Icons.lock,
                                    color: kPrimaryColor,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(screenHeight * 0.03),
                                    borderSide:
                                        const BorderSide(color: kPrimaryColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(screenHeight * 0.03),
                                    borderSide:
                                        const BorderSide(color: kPrimaryColor),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
             
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgetPasswordScreen()));
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: kPrimaryColor,
                        ),
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            fontSize: screenHeight * 0.02,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
        
                      DefaultButton(
                        text: "Login",
                        press: () async {
                          
                          // get response from the server
                          var response = await loginUser(emailController, passwordController);
                         
                          if( formKey.currentState!.validate() && response.statusCode == 200 ) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Login successfully'), 
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
        
                      SizedBox(height: screenHeight * 0.03),
                      Text(
                        "Or Sign In With",
                        style: TextStyle(
                            fontSize: screenHeight * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                elevation: 0.7,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(screenWidth *
                                      0.9), // Set the border radius of the button
                                ),
                              ),
                              child: Image.asset(
                                'assets/images/google.png',
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.07,
                              )),
                          SizedBox(width: screenWidth * 0.08),
                          ElevatedButton(
                              onPressed: () {
                                
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                elevation: 0.7,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(screenWidth *
                                      0.9), // Set the border radius of the button
                                ),
                              ),
                              child: Image.asset(
                                'assets/images/facebook.png',
                                height: screenHeight * 0.07,
                                width: screenWidth * 0.07,
                              )),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Don't have an account ?"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SignUpScreen()));
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: kPrimaryColor,
                              ),
                              child: Text(
                                'Register Now',
                                style: TextStyle(
                                  fontSize: screenHeight * 0.02,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                          ]),
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
