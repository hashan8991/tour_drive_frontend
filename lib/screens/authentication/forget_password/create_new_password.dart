import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/screens/authentication/forget_password/forget_password_screen.dart';
import 'package:tour_drive_frontend/screens/authentication/sign_in/login_screen.dart';
import 'package:tour_drive_frontend/widgets/default_button.dart';
import 'package:tour_drive_frontend/widgets/header.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

  late final String otp;
  final formKey3 = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;


class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {


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
                      const Text("Please enter code sent to your registered mobile number",),
                      SizedBox(height: screenHeight * 0.06),
                      Form(
                        key: formKey3,
                        child: Column(
                          children: [
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
                                return '* Please enter more than 8 charactersl';
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
                          DefaultButton(text: "Update Password", press: () {
                            if (formKey3.currentState!.validate()) {
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   const SnackBar(
                              //     content: Text('Send  successfully'), 
                              //     backgroundColor: kPrimaryColor,
                              //     ),
                              // );
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
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