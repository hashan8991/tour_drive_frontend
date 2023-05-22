import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DriveOptionScreen extends StatefulWidget {
  const DriveOptionScreen({super.key});

  @override
  State<DriveOptionScreen> createState() => _DriveOptionScreenState();
}

class _DriveOptionScreenState extends State<DriveOptionScreen> {

  // ###############################################################################################################
  List<dynamic> vehicleBookingDetails = [];
  late bool isloading = false ;
  late int numofbooking;

  Future<void> fetchVehicleBooking() async {

    setState(() {
      isloading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final cookie = await prefs.getString('Cookie');
    
    final response = await http
        .get(Uri.parse('$URL/api/v1/booking/my-bookings/vehicles'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'cookie': (cookie==null) ? "" : cookie,
        },
    );

    if (response.statusCode == 200) {
      setState(() {
        final Map<String, dynamic> responseData =  jsonDecode(response.body);
        vehicleBookingDetails =  responseData["data"]["bookings"];
        numofbooking = responseData["records"];
      });
    } else {
      throw Exception('Failed to load vehicleBooking Details');
    }

    setState(() {
      isloading = false;
    });

  }

  @override
  void initState() {
    super.initState();
    fetchVehicleBooking();
  }


  // #############################################################################################################
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
            'Booked Vehicle',
            textAlign: TextAlign.center,
            style: TextStyle(color: kTextColor),
          ),
        ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          children: [
            isloading ? 
            Center(
                child:CircularProgressIndicator(
                  backgroundColor: Colors.grey[200], // Set the background color of the widget
                  valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryColor), // Set the color of the progress indicator
                  strokeWidth: 3, // Set the width of the progress indicator
                )
              )
            :
            (numofbooking < 1) ? Text("No booking vehicles yet",style: TextStyle(fontSize: screenHeight * 0.02,fontWeight: FontWeight.bold),):
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: vehicleBookingDetails.length,
                itemBuilder: (BuildContext context, int index){
                  return Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,0,16),
                      child: Container(
                        
                        height: screenHeight * 0.16,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          // color: const Color.fromARGB(115, 155, 239, 254),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.15), // shadow color
                              spreadRadius: 1.0, // how wide the shadow is
                              blurRadius: 5.0, // how soft the shadow is
                              offset: const Offset(0, 3), // offset of the shadow
                            ),
                          ],
                          borderRadius:
                              BorderRadius.circular(screenWidth * 0.03),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(screenWidth * 0.025),
                          child: Row(
                            children: [
                              ClipRRect( 
                                borderRadius: BorderRadius.circular(screenWidth * 0.03),
                                child: Image.network('$urlPhoto/vehicle-uploads/${vehicleBookingDetails[index]["vehicle"]["cover_URL"]}',errorBuilder: (context, error, stackTrace) => Image.network('https://www.tgsin.in/images/joomlart/demo/default.jpg', fit: BoxFit.fill, height: screenHeight * 0.14,width: screenWidth * 0.29, ), fit: BoxFit.fill, height: screenHeight * 0.14,width: screenWidth * 0.29, )),
                              SizedBox(width: screenWidth * 0.03),
                              Container(
                                height: screenHeight * 0.14,
                                width: screenWidth * 0.52,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${vehicleBookingDetails[index]["vehicle"]["brand"]} ${vehicleBookingDetails[index]["vehicle"]["model"]}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenHeight * 0.02), maxLines: 2, overflow: TextOverflow.ellipsis,),
                                    SizedBox(height: screenHeight * 0.008,),                                    
                                    Text("\$ ${vehicleBookingDetails[index]["vehicle"]["price_per_day_without_dr"]}", style: TextStyle(fontSize: screenHeight * 0.022,fontWeight: FontWeight.bold),),
                                    SizedBox(height: screenHeight * 0.008,),
                                    Text("Check In    :   ${vehicleBookingDetails[index]["duration"].split('-')[0]}", style: TextStyle(fontSize: screenHeight * 0.018)), 
                                    SizedBox(height: screenHeight * 0.008,),
                                    Text("Check Out :   ${vehicleBookingDetails[index]["duration"].split('-')[1]} ", style: TextStyle(fontSize: screenHeight * 0.018)),  
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ),
                      ),
                    );
                }
              ),
            ),
          ],
        ),
        ),
        
    );
  }
}