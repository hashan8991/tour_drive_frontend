// ignore_for_file: use_build_context_synchronously

import "package:flutter/material.dart";
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/single_tour_screen.dart';
import 'package:tour_drive_frontend/widgets/default_button.dart';
import 'package:tour_drive_frontend/widgets/header.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


class TourFeedbackForm extends StatefulWidget {
  const TourFeedbackForm({Key? key}) : super(key: key);

  @override
  State<TourFeedbackForm> createState() => _TourFeedbackFormState();
}

class _TourFeedbackFormState extends State<TourFeedbackForm> {

  String? name,email,comment;
  double locationRating = 1.0 ;
  double serviceRating = 1.0;
  bool isError = false;
  String errorMessage = "";
  late bool isloading = false ;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final reviewPasswordController = TextEditingController();

  // Sending data to server
Future submitReview(TextEditingController nameController,TextEditingController emailController,TextEditingController reviewPasswordController,double locationRating,double serviceRating) async {

  setState(() {
      isloading = true;
  });

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? tourId = prefs.getString('tourId');

  final response = await http.post(                             // send data to server using post method
    Uri.parse('$URL/api/v1/reviews'),             // end point url
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
 
    body: jsonEncode(<String, String>{                          // what we need to send to the server
      "name": nameController.text,
      "email": emailController.text,
      "review": reviewPasswordController.text,
      "locationRating": "$locationRating",
      "serviceRating": "$serviceRating",
      "reviewType":"tour",
      "tour":"$tourId"
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
              Header(text: "Create Review", press: () {
                        Navigator.pop(context, MaterialPageRoute(builder: (context) => const SingleTourScreen()));
              }),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    
                    SizedBox(height: screenHeight *0.02,),
                    const Center(child: Text("Hey, Leave feedback about this",)),
                    SizedBox(height: screenHeight *0.02,),
                    isloading ?
                      Center(
                          child:CircularProgressIndicator(
                            backgroundColor: Colors.grey[200], // Set the background color of the widget
                            valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryColor), // Set the color of the progress indicator
                            strokeWidth: 3, // Set the width of the progress indicator
                          )
                      )
                    :
                    Visibility(
                        visible: isError,
                        child: Text("🛑 $errorMessage " , style: TextStyle(fontSize: screenHeight * 0.02, color: Colors.red,fontWeight: FontWeight.bold),),
                      ),
                    SizedBox(height: screenHeight * 0.04),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: screenHeight *0.01,),

                          TextFormField(
                          controller: nameController,
                          onSaved: (value)  {
                            name = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '* Please enter your name';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kPrimaryColor),
                            )
                          ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          const Text(
                            'Email',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: screenHeight *0.01,),

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
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryColor),
                              )
                            ),
                          ),
                          SizedBox(height: screenHeight *0.02,),
                          const Text(
                            'Comment',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: screenHeight *0.01,),

                          TextFormField(
                            controller: reviewPasswordController,
                            onSaved: (value)  {
                              comment = value!;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return '* Please enter your comment';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryColor),
                              )
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Location',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              RatingBar.builder(
                                initialRating: locationRating,
                                minRating: 0,
                                maxRating: 5,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: kPrimaryColor,
                                ),
                                onRatingUpdate: (locationrating) {
                                  setState(() {
                                    locationRating = locationrating;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Service',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              RatingBar.builder(
                                initialRating: serviceRating,
                                minRating: 0,
                                maxRating: 5,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: kPrimaryColor,
                                ),
                                onRatingUpdate: (servicerating) {
                                  setState(() {
                                    serviceRating = servicerating;
                                    
                                  });
                                },
                              ),
                            ],
                          ),
                          ]
                        ),
                     ),
                    SizedBox(height: screenHeight *0.05,),
                    SizedBox(
                      width: screenWidth *0.5,
                      child: 
                        DefaultButton(text: "Submit Review", press: () async {

                          // get response from the server
                          var response = await submitReview(nameController,emailController,reviewPasswordController,locationRating,serviceRating);
                          
                          if (formKey.currentState!.validate() && response.statusCode == 201) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Review submit successfully'), 
                                backgroundColor: kPrimaryColor,
                                ),
                            );
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const SingleTourScreen()));
                          }else{
                            final Map<String, dynamic> responseData = json.decode(response.body);
                            errorMessage = responseData["message"];
                            setState(() {
                              isError = true;
                            });
                          }
                        }
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