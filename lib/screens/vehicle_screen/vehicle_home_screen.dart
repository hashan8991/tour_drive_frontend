import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/screens/navbar_main_page/navbar_main_page.dart';
import 'package:tour_drive_frontend/screens/vehicle_screen/single_vehicle_screen/single_vehicle_screen.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class VehicleHomeScreen extends StatefulWidget {
  const VehicleHomeScreen({super.key});

  @override
  State<VehicleHomeScreen> createState() => _VehicleHomeScreenState();
}

class _VehicleHomeScreenState extends State<VehicleHomeScreen> {

   // ####################################################################################################################
        // Backend Integration
  List<dynamic> vehicles = [];

  Future<void> fetchVehicles() async {
    final response = await http
        .get(Uri.parse('https://tour-drive.onrender.com/api/v1/vehicles'));

    if (response.statusCode == 200) {
      setState(() {
        final Map<String, dynamic> responseData =  jsonDecode(response.body);
        vehicles =  responseData["data"];
         
      });
    } else {
      throw Exception('Failed to load Tour');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchVehicles();
  }

// ####################################################################################################################

  @override
  Widget build(BuildContext context) {
    
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    Text buildRatingStars(int rating) {

      String stars = '';
      for (int i = 0; i < rating; i++) {
        stars += '⭐ ';
      }
      stars.trim();
      return Text(stars, style: TextStyle(fontSize: screenHeight * 0.015),);
    }

     return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const NavbarMainPage()));}, 
            icon: const Icon(Icons.arrow_back, color:Colors.black, )),
          elevation: 0,
          title: Image.asset("assets/images/logoPic.png"),
          centerTitle: true,
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.all(3),
              child: IconButton(
                alignment: Alignment.centerRight,
                icon: const Icon(Icons.search, color: Colors.black,),
                onPressed: () {
 
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.black, ),
              onPressed: () {

              },
            ),
          ],
        ),
        

        body: Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Choose Your best vehicle here", style: TextStyle(fontSize: screenHeight * 0.032, fontWeight: FontWeight.bold),),
              SizedBox(height: screenHeight * 0.02,),

              vehicles.isEmpty 
              ? Center(
                  child:CircularProgressIndicator(
                    backgroundColor: Colors.grey[200], // Set the background color of the widget
                    valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryColor), // Set the color of the progress indicator
                    strokeWidth: 3, // Set the width of the progress indicator
                  )
                )
              :
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: vehicles.length,
                  itemBuilder: (BuildContext context, int index) {
                  final vehicle = vehicles[index];

                  return GestureDetector(
                    onTap: () async {

                      // Store the  vehicle ID in shared preferences
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('vehicleId', vehicle["_id"]);

                      // ignore: use_build_context_synchronously
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SingleVehicleScreen()));

                    },
                    child: Padding(
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
                                child: Image.network('https://tour-drive.onrender.com/vehicle-uploads/${vehicle["cover_URL"]}', fit: BoxFit.fill, height: screenHeight * 0.14,width: screenWidth * 0.29, )),
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
                                    Text("${vehicle["brand"]} ${vehicle["model"]}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenHeight * 0.02), maxLines: 2, overflow: TextOverflow.ellipsis,),
                                    SizedBox(height: screenHeight * 0.008,),
                                    Row(
                                      children: [
                                        const Icon(Icons.construction_outlined, color: kPrimaryColor, size: 12.0,),
                                        SizedBox(width: screenWidth * 0.4, child: Text(" Brandnew condition", style: TextStyle(fontSize: screenHeight * 0.018), maxLines:1, overflow: TextOverflow.ellipsis,)),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.008,),
                                    Row(children: [buildRatingStars(vehicle["vehicleRatingsAverage"]), SizedBox(width: screenWidth * 0.02,),Text("${vehicle["ratingsQuantity"]} reviews", style: TextStyle(fontSize: screenHeight *0.015),)]),
                                    SizedBox(height: screenHeight * 0.007,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.airline_seat_recline_normal_sharp, color: kPrimaryColor, size: screenHeight * 0.02,),
                                            SizedBox(width: screenWidth *0.005,),
                                            Text("${vehicle["seats"]} seats"),
                                          ],
                                        ),
                                        Text("\$ ${vehicle["price_per_day_without_dr"]}", style: TextStyle(fontSize: screenHeight * 0.022,fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
      ),
    );
  }
}

