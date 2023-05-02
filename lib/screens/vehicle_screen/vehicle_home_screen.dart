// ignore_for_file: await_only_futures

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/screens/navbar_main_page/navbar_main_page.dart';
import 'package:tour_drive_frontend/screens/vehicle_screen/single_vehicle_screen/single_vehicle_screen.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tour_drive_frontend/screens/vehicle_screen/vehicle_filter.dart';

class VehicleHomeScreen extends StatefulWidget {
  const VehicleHomeScreen({super.key});

  @override
  State<VehicleHomeScreen> createState() => _VehicleHomeScreenState();
}

class _VehicleHomeScreenState extends State<VehicleHomeScreen> {

   // ####################################################################################################################
        // Backend Integration
  List<dynamic> vehicles = [];
  List<String>? vehicleType = [];
  //List<String> VehicleReviewScore = [];
  List<String>? fuelType = [];
  List<String>? transmission = [];
  int? minPrice = 0;
  int? maxPrice = 2000;
  bool isloading = true;

  Future<void> fetchVehicles() async {

    // Get filter values
    final pref = await SharedPreferences.getInstance();
    vehicleType = await pref.getStringList('VehicleType');
    fuelType = await pref.getStringList('FuelType');
    transmission = await pref.getStringList('TransmissionType');
    // String? jsonString = await (prefs.getString('VehicleReviewScore'));
    // VehicleReviewScore = (jsonString == null) ? "" : json.decode(jsonString);
    minPrice = await pref.getInt('VehicleMinPrice');
    maxPrice = await pref.getInt('VehicleMaxPrice');
    
    final http.Response response;

    if (vehicleType == null && fuelType == null && transmission == null && minPrice == null && maxPrice == null) {
         response = await http.get(Uri.parse('$URL/api/v1/vehicles?vehicle_state=available&limit=10&price_per_day_without_dr[gte]=0&price_per_day_without_dr[lte]=2000'));
    } else {

      String url = "$URL/api/v1/vehicles?vehicle_state=available&limit=10";
      url += (vehicleType!.isEmpty) ? "" : "&vehicle_type=${vehicleType!.join(",")}"; 
      url += (fuelType!.isEmpty) ? "" : "&fuel=${fuelType!.join(",")}";
      url += (transmission!.isEmpty) ? "" : "&transmission=${transmission!.join(",")}";
      url += "&price_per_day_without_dr[gte]=$minPrice";
      url += "&price_per_day_without_dr[lte]=$maxPrice";
      response = await http.get(Uri.parse(url));
      
    }

    if (response.statusCode == 200) {

      setState(() {
        final Map<String, dynamic> responseData =  jsonDecode(response.body);
        vehicles =  responseData["data"];
        isloading = false;
      });
      
    } else {
      throw Exception('Failed to vehicle Tour');
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

     return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () async{
              final kpref = await SharedPreferences.getInstance();
              await kpref.remove('VehicleType');
              await kpref.remove('FuelType');
              await kpref.remove('TransmissionType');
              await kpref.remove('VehicleReviewScore');
              await kpref.remove('VehicleMinPrice');
              await kpref.remove('VehicleMaxPrice');
              // ignore: use_build_context_synchronously
              Navigator.push(context, MaterialPageRoute(builder: (context) => const NavbarMainPage()));
            }, 
            icon: const Icon(Icons.arrow_back, color:Colors.black, )),
          elevation: 0,
          title: Image.asset("assets/images/logoPic.png", width: screenWidth * 0.55,),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.black, ),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => const VehicleFilter()));
              },
            ),
          ],
        ),
        

        body: Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.01,),
              Text("Choose Your best vehicle here", style: TextStyle(fontSize: screenHeight * 0.026, fontWeight: FontWeight.bold),),
              SizedBox(height: screenHeight * 0.02,),

              isloading 
              ? Center(
                  child:CircularProgressIndicator(
                    backgroundColor: Colors.grey[200], // Set the background color of the widget
                    valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryColor), // Set the color of the progress indicator
                    strokeWidth: 3, // Set the width of the progress indicator
                  )
                )
              :
              vehicles.isEmpty ?
              Column(
                children: [
                  SizedBox(height: screenHeight * 0.2,),
                  Container(
                    padding: EdgeInsets.all(screenHeight * 0.05),
                    child: Text("👀 Sorry, we couldn't find any results that match your search criteria.", style: TextStyle(fontSize: screenHeight * 0.016,fontWeight: FontWeight.bold, color: kPrimaryColor),)
                  ),
                ],
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
                                child: Image.network('$urlPhoto/vehicle-uploads/${vehicle["cover_URL"]}', fit: BoxFit.fill, height: screenHeight * 0.14,width: screenWidth * 0.29, errorBuilder: (context, error, stackTrace) => Image.network('https://www.tgsin.in/images/joomlart/demo/default.jpg', fit: BoxFit.fill, height: screenHeight * 0.14,width: screenWidth * 0.29, ))),
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
                                        SizedBox(width: screenWidth * 0.4, child: Text(" ${vehicle['transmission']}", style: TextStyle(fontSize: screenHeight * 0.018), maxLines:1, overflow: TextOverflow.ellipsis,)),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.008,),
                                    Row(
                                      children: [
                                        RatingBarIndicator(
                                        rating: vehicle["vehicleRatingsAverage"].toDouble(),
                                        itemBuilder: (context, index) => const Icon(
                                            Icons.star,
                                            color: kPrimaryColor,
                                        ),
                                        itemCount: 5,
                                        itemSize: screenHeight * 0.021,
                                        direction: Axis.horizontal,
                                      ),
                                        SizedBox(width: screenWidth * 0.02,),
                                        Text("${vehicle["ratingsQuantity"]} reviews", style: TextStyle(fontSize: screenHeight *0.015),)]),
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

