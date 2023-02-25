import "package:flutter/material.dart";
//import 'package:tour_drive_frontend/size_config.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/widgets/default_button.dart';
import 'package:tour_drive_frontend/widgets/header.dart';
import '../../size_config.dart';




class LogInScreen extends StatelessWidget {

  static String routeName = "/sign_in";
  const LogInScreen({super.key});
  
  
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
                Header(text: "Login", press: () {} ),
                SizedBox(height: screenHeight * 0.02),
                const Text("Hey, Enter your details to get sign in ",),
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
                TextField(
                  //controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    suffixIcon: const Icon(Icons.lock, color: kPrimaryColor),
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
                    const Text("Email Or Password Is Incorrect", ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    // Add forgot password logic here
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
                DefaultButton( text: "Login", press: () {
                  
                },),
                SizedBox(height: screenHeight * 0.03),
                Text("Or Sign In With", style: TextStyle(fontSize: screenHeight*0.02, fontWeight: FontWeight.bold),),  
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
                          borderRadius: BorderRadius.circular(screenWidth * 0.9), // Set the border radius of the button
                        ),
                      ), 
                      child: Image.asset('assets/images/google.png', height: screenHeight * 0.07, width: screenWidth * 0.07,)
                    ),
                    SizedBox(width: screenWidth * 0.08),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, 
                        elevation: 0.7, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(screenWidth * 0.9), // Set the border radius of the button
                        ),
                      ), 
                      child: Image.asset('assets/images/facebook.png', height: screenHeight * 0.07, width: screenWidth * 0.07,)
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Don't have an account ?"),
                
                    TextButton(
                      onPressed: () {
                        // Add forgot password logic here
                      },
                  
                      style: TextButton.styleFrom(
                        foregroundColor: kPrimaryColor,
                      ),
                      
                      child: Text('Register Now',style: TextStyle(fontSize: screenHeight * 0.02,color: kPrimaryColor,),
                      ),
                    ),
                  ]
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


