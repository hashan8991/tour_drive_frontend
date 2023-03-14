import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/screens/vehicle_screen/single_vehicle_screen/single_vehicle_screen.dart';
import 'package:tour_drive_frontend/widgets/default_button.dart';
import 'package:tour_drive_frontend/widgets/header.dart';

class VehicleFeedbackScreen extends StatefulWidget {
  const VehicleFeedbackScreen({super.key});

  @override
  State<VehicleFeedbackScreen> createState() => _VehicleFeedbackScreenState();
}

class _VehicleFeedbackScreenState extends State<VehicleFeedbackScreen> {

  final formKey = GlobalKey<FormState>();
  String? name,email,comment;
  double serviceRating = 0;

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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SingleVehicleScreen()));
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
                          //controller: firstNameController,
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
                            //controller: firstNameController,
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
                            //controller: firstNameController,
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
                                'Driver',
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
                                onRatingUpdate: (rating) {
                                  setState(() {
                                    serviceRating = rating;
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
                                'vehicle',
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
                                onRatingUpdate: (rating) {
                                  setState(() {
                                    serviceRating = rating;
                                  });
                                },
                              ),
                            ],
                          ),
                          ]
                            ),
                     ),
                    
                    SizedBox(height: screenHeight *0.06,),
                    SizedBox(
                      width: screenWidth *0.5,
                      child: DefaultButton(text: "Submit Review", press: () {
                              if (formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Review submit successfully'), 
                                    backgroundColor: kPrimaryColor,
                                    ),
                                );
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInScreen()));
                        }
                      }),
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