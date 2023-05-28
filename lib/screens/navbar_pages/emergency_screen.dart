// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/widgets/default_button.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tour_drive_frontend/widgets/list_tile_phone_call.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {

  String latitude = '';
  String longtitude = '';
  bool isloading = false;
  final formKey = GlobalKey<FormState>();
  final messageController = TextEditingController();
  String emergencyType = "Mechanical Breakdown";
  var items = [
    "Mechanical Breakdown",
    "Accidents or Collisions",
    "Theft",
    "Natural Disasters",
    "Traffic Violations",
  ];


  Future createEmergencie(String message) async {
    
    setState(() {
      isloading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final cookie = await prefs.getString('Cookie');
    final userid = await prefs.getString('userId');

   
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    latitude = position.latitude.toString();
    longtitude = position.longitude.toString();
    

    final response = await http
        .post(Uri.parse('$URL/api/v1/emergencies'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'cookie': (cookie == null) ? "" : cookie,
        },
        body: jsonEncode(<String, String>{  // what we need to send to the server
          "user": (userid == null) ? "" : userid,
          "message": "type: $emergencyType \nmessage: ${messageController.text}",
          "latitude": latitude,
          "longtitude": longtitude
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

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: kTextColor),
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          leading: IconButton(
            onPressed: () {
             
            },
            icon: const Icon(
                Icons.arrow_back_ios, color: Colors.white,), //replace with our own icon data.
          ),
          title: const Text(
            'Emergency Contact',
            textAlign: TextAlign.center,
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.03,),
              Text("Let's ride safely!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenHeight * 0.025),),
              SizedBox(height: screenHeight * 0.03,),
              Text("When You ride using this profile ,preference will be selected by default.", style: TextStyle( fontSize: screenHeight * 0.02),),
              SizedBox(height: screenHeight * 0.05,),
              isloading ? 
              Center(
                  child:CircularProgressIndicator(
                    backgroundColor: Colors.grey[200], // Set the background color of the widget
                    valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryColor), // Set the color of the progress indicator
                    strokeWidth: 3, // Set the width of the progress indicator
                  )
                )
              :
              SizedBox(height: screenHeight * 0.02,),
              Text("Emergency type", style: TextStyle( fontSize: screenHeight * 0.02),),
              SizedBox(height: screenHeight * 0.02,),
              Container(
                height: screenHeight * 0.07,
                decoration: BoxDecoration(
                  color: const Color(0xFFE4F9FB),
                  borderRadius: BorderRadius.circular(screenHeight * 0.02),
                ),
              //##########################################  Driving option ######################################################################################                                                     
                child: Container(
                  margin:  EdgeInsets.symmetric( horizontal: screenWidth * 0.05),
                  child: DropdownButton(
                    value: emergencyType,
                    icon: const Icon(Icons.keyboard_arrow_down), 
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                  onChanged: (String? newValue) { 
                    setState(() {
                      emergencyType = newValue!;
                    });
                  }
                  ),
                  
                ),
              ),
              SizedBox(height: screenHeight * 0.02,),
              Text("Message", style: TextStyle( fontSize: screenHeight * 0.02),),
              SizedBox(height: screenHeight * 0.02,),
              Form(
                key: formKey,
                child: TextFormField(
                  controller: messageController,
                  
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return '* Please enter message shortly';
                  //   }
                  //   return null;
                  // },
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
              ),
              SizedBox(height: screenHeight * 0.09,),
              DefaultButton(text: "ADD SOS", press: () async {
        
                // ignore: prefer_typing_uninitialized_variables
                var response;
        
                if( formKey.currentState!.validate())   {
                  response = await createEmergencie(messageController.text);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("TourDrive Emergencie"),
                        // content: const Text("Our customer service team will review your request and respond as soon as possible."),
                        content:  SizedBox(
                          height: screenHeight*0.25,
                          child: Column(
                            children: const [
                              Text("Our customer service team will review your request and respond as soon as possible.\n\n For further contact, please use the provided contact number ..."),
                              PhoneCallListTile(
                                      iconLeading: Icons.phone_android_outlined,
                                      title:
                                          '011 123 4567', // add this phone number to the definition of this list_tile
                                    ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(onPressed: () {
                            Navigator.pop(context);
                          }, 
                          child: const Text("Ok"))
                        ],
                      );
                    }
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Emergency Request successfully'), 
                      backgroundColor: kPrimaryColor,
                      ),
                  );
                  
                }else  {
        
                  final Map<String, dynamic> responseData = json.decode(response.body);
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("TourDrive Emergencie"),
                        content: Text(responseData["message"]),
                        actions: [
                          TextButton(onPressed: () {
                            Navigator.pop(context);
                          }, 
                          child: const Text("Ok"))
                        ],
                      );
                    }
                  );
        
                }
                
                 
              }),
            ],
          ),
        ),
        ),
        
    );
  }
}