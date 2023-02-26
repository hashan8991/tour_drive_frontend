import "package:flutter/material.dart";
//import 'package:tour_drive_frontend/size_config.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/screens/sign_in/login_screen.dart';
import 'package:tour_drive_frontend/widgets/default_button.dart';
import 'package:tour_drive_frontend/widgets/header.dart';

class ForgetPasswordScreen extends StatelessWidget {

  static String routeName = "/forget_password";
  const ForgetPasswordScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    
     final double screenWidth = MediaQuery.of(context).size.width;
     final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(screenWidth * 0.04),
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
                TextField(
                  //controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    suffixIcon: const Icon(Icons.email, color: kPrimaryColor,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenHeight * 0.03),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  children: [
                    const Icon(Icons.warning, color: kPrimaryColor,),
                    SizedBox(width: screenWidth * 0.02,),
                    const Text("Enter the valid email address", ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.04),
                DefaultButton(text: "Send", press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
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


