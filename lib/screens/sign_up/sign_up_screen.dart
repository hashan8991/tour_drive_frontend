import "package:flutter/material.dart";
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/screens/loading/loading_screen.dart';
import 'package:tour_drive_frontend/screens/sign_in/login_screen.dart';
import 'package:tour_drive_frontend/widgets/default_button.dart';
import 'package:tour_drive_frontend/widgets/header.dart';
//import 'package:tour_drive_frontend/size_config.dart';

class SignUpScreen extends StatefulWidget {

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? country,password;
  late final String email,fName,lName,confirmPassword;
  final formKey = GlobalKey<FormState>();
  final countryController = TextEditingController();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;

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
                          controller: firstNameController,
                          onSaved: (value)  {
                            fName = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '* Please enter your first name';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "First Name",
                            floatingLabelStyle: const TextStyle(color: kPrimaryColor),
                            contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.028),
                            hintText: 'Enter your first name',
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
                          controller: lastNameController,
                          onSaved: (value)  {
                            fName = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '* Please enter your last name';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "Last Name",
                            floatingLabelStyle: const TextStyle(color: kPrimaryColor),
                            contentPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.028),
                            hintText: 'Enter your last name',
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
                          if ( value.length < 6) {
                            return '* Please enter more than 6 characters';
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
                        onSaved: (value)  {
                          confirmPassword = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '* Please enter your re-password';
                          }
                          // if ( password! != confirmPassword) {
                          //   return '* Password do not match';
                          // }
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
                            Text("Select Country", style: TextStyle(fontSize: screenHeight * 0.021, color: const Color.fromARGB(255, 114, 111, 111)) ),
                            DropdownButton<String>(
                              enableFeedback: true,
                              borderRadius: BorderRadius.circular(screenHeight * 0.02),
                              dropdownColor: kPrimaryColor,
                              value: country,
                              onChanged: (value) {
                                setState(() {
                                  country = value!;
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
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                // Row(
                //   children: [
                //     const Icon(Icons.warning, color: kPrimaryColor,),
                //     SizedBox(width: screenWidth * 0.02,),
                //     const Text("Enter the valid email or correct password", ),
                //   ],
                // ),
                SizedBox(height: screenHeight * 0.02),
                DefaultButton(text: "Submit", press: () {
                  if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Profile creation successfully'), 
                        backgroundColor: kPrimaryColor,
                        ),
                    );
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
                  }
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




