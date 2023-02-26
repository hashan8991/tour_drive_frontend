import "package:flutter/material.dart";
//import 'package:tour_drive_frontend/size_config.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/screens/loading/loading_screen.dart';
import 'package:tour_drive_frontend/screens/sign_in/login_screen.dart';
import 'package:tour_drive_frontend/widgets/default_button.dart';
import 'package:tour_drive_frontend/widgets/header.dart';

class SignUpScreen extends StatefulWidget {

  static String routeName = "/sign_up";

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? selectedItem;

  List<String> items = [
    'SriLanka',
    'Other',
  ];

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
                Header(text: "Sign Up", press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
                } ),
                SizedBox(height: screenHeight * 0.01),
                const Text("Please enter your profile information.",),
                SizedBox(height: screenHeight * 0.02),
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
                  //controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter First Name',
                    suffixIcon: const Icon(Icons.man, color: kPrimaryColor,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenHeight * 0.03),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                TextField(
                  //controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter Last Name',
                    suffixIcon: const Icon(Icons.man, color: kPrimaryColor,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenHeight * 0.03),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                TextField(
                  //controller: emailController,
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    suffixIcon: const Icon(Icons.lock, color: kPrimaryColor,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenHeight * 0.03),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                TextField(
                  //controller: emailController,
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Retype Password',
                    suffixIcon: const Icon(Icons.lock, color: kPrimaryColor,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenHeight * 0.03),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Select Country", style: TextStyle(fontSize: screenHeight * 0.021),),
                      DropdownButton<String>(
                        enableFeedback: true,
                        borderRadius: BorderRadius.circular(screenHeight * 0.02),
                        dropdownColor: kPrimaryColor,
                        value: selectedItem,
                        onChanged: (newValue) {
                          setState(() {
                            selectedItem = newValue;
                          });
                        },
                        items: items.map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        hint: const Text("Country"),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  children: [
                    const Icon(Icons.warning, color: kPrimaryColor,),
                    SizedBox(width: screenWidth * 0.02,),
                    const Text("Enter the valid email or correct password", ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                DefaultButton(text: "Submit", press: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
                }),
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
      ),
    );
  }
}

void setState(Null Function() param0) {
}


