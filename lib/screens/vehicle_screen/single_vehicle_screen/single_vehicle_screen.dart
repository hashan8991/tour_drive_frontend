// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/screens/vehicle_screen/single_vehicle_screen/sub_pages/description.dart';
import 'package:tour_drive_frontend/screens/vehicle_screen/single_vehicle_screen/sub_pages/features.dart';
import 'package:tour_drive_frontend/screens/vehicle_screen/single_vehicle_screen/sub_pages/vehicle_check_availability.dart';
import 'package:tour_drive_frontend/screens/vehicle_screen/single_vehicle_screen/sub_pages/vehicle_feedback_screen.dart';
import 'package:tour_drive_frontend/screens/vehicle_screen/vehicle_home_screen.dart';
import 'package:tour_drive_frontend/widgets/divider_container.dart';
import 'package:tour_drive_frontend/widgets/favorite_icon.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SingleVehicleScreen extends StatefulWidget {
  const SingleVehicleScreen({super.key});

  @override
  State<SingleVehicleScreen> createState() => _SingleVehicleScreenState();
}

class _SingleVehicleScreenState extends State<SingleVehicleScreen> {

   // ####################################################################################################################
    // Backend Integration
  var vehicleDetails;
  List<dynamic> vehicleReviews  = [];
  var numOfReview;
  bool isloading1 = true;
  bool isloading2 = true;

  Future<void> fetchVehicle() async {
    
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    String? vehicleId = prefs.getString('vehicleId');
    
    final response = await http.get(Uri.parse('$URL/api/v1/vehicles/$vehicleId'));
    
    if (response.statusCode == 200) {

      setState(() {
        final Map<String, dynamic> responseData =  jsonDecode(response.body);
        vehicleDetails =  responseData["data"];
        isloading1 = false;
      });

    } else {

      throw Exception('Failed to vehicle Tour');
    }
    
  }

  Future<void> fetchVehicleReview() async {

    SharedPreferences prefs =  await SharedPreferences.getInstance();
    String? vehicleId = prefs.getString('vehicleId');

    final response = await http.get(Uri.parse('$URL/api/v1/reviews?vehicle=$vehicleId'));
   
    if (response.statusCode == 200) {
      setState(() {
        final Map<String, dynamic> responseData =  jsonDecode(response.body);
        vehicleReviews =  responseData["data"]["reviews"];
        numOfReview = responseData["results"];
        isloading2 = false;
      });
    } else {
      throw Exception('Failed to vehicle Tour');
    }
  }
  
  @override
  void initState() {
    super.initState();
    fetchVehicle();
    fetchVehicleReview();
   // print("(${((vehicleDetails["driverRatingsAverage"]+vehicleDetails["vehicleRatingsAverage"])/2).toDouble()}/5)");
  }

// ####################################################################################################################

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(

       floatingActionButton: SizedBox(
        width: screenWidth * 0.4,
        height: screenHeight * 0.1,
         child: FittedBox(
           child: FloatingActionButton.extended(
              backgroundColor: kPrimaryColor,
              foregroundColor: Colors.white,
              onPressed: () {
                String vehicleName = "${vehicleDetails['brand']} ${vehicleDetails['model']}";
                num priceWithDriver = vehicleDetails['price_per_day_with_dr'];
                num priceWithoutDriver = vehicleDetails['price_per_day_without_dr'];
                Navigator.push(context,MaterialPageRoute(builder: (context) => VehicleCheckAvailability(vehicleName: vehicleName, priceWithDriver: priceWithDriver, priceWithoutDriver: priceWithoutDriver))); 
              },
              label: const Text('Check availability'),
            ),
         ),
       ),
       
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () { Navigator.push(context,MaterialPageRoute(builder: (context) =>const VehicleHomeScreen())); }, 
            icon: const Icon(Icons.arrow_back, color:Colors.black, )
            ),
          actions: <Widget>[
            // IconButton(
            //   icon: const MyFavoriteIconWidget(),
            //   onPressed: () {},
            //   alignment: Alignment.centerLeft,
            // ),
          ],
        ),

        body: 
        isloading1 ? 
        Center(
            child:CircularProgressIndicator(
              backgroundColor: Colors.grey[200], // Set the background color of the widget
              valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryColor), // Set the color of the progress indicator
              strokeWidth: 3, // Set the width of the progress indicator
            )
          )
        :
        Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(thickness: 1.0),
                Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15), // shadow color
                      spreadRadius: 1.0, // how wide the shadow is
                      blurRadius: 5.0, // how soft the shadow is
                      offset: const Offset(0, 3), // offset of the shadow
                    ),
                  ],
                ),
                height: screenHeight * 0.3,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: vehicleDetails["images_URL"].length,
                    itemBuilder: ((context, index) {
                      return Row(
                        children: [
                          Image.network('$urlPhoto/vehicle-uploads/${vehicleDetails["images_URL"][index]}', fit: BoxFit.fill, height: screenHeight * 0.3, width: screenWidth * 0.7,
                          errorBuilder: (context, error, stackTrace) => Image.network('https://www.tgsin.in/images/joomlart/demo/default.jpg', fit: BoxFit.fill, height: screenHeight * 0.3,width: screenWidth * 0.7,)),
                          SizedBox(width: screenWidth * 0.03,)

                      ],);
                    }
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
          //######################## vehicle name #######################################################################################################               
                Text("${vehicleDetails['brand']} ${vehicleDetails['model']}", style: TextStyle(fontSize: screenHeight *0.03, fontWeight: FontWeight.bold)),
                SizedBox(height: screenHeight * 0.02),
          
                
          //######################## vehicle Reviews #######################################################################################################              
                Row(children: [
                  RatingBarIndicator(
                    rating: vehicleDetails["vehicleRatingsAverage"].toDouble(),
                    itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: kPrimaryColor,
                    ),
                    itemCount: 5,
                    itemSize: screenHeight * 0.024,
                    direction: Axis.horizontal,
                  ),
                  SizedBox(width: screenWidth * 0.05,),
                  Text("${vehicleDetails['ratingsQuantity']} Reviews")
                ]
                ), 
                SizedBox(height: screenHeight * 0.025),
                Row(
                  children: [
                    const Icon(Icons.sell_outlined, color: kPrimaryColor, size: 20.0,),
                    SizedBox(width: screenWidth * 0.02),
          //######################## vehicle Price #######################################################################################################               
                     Text("\$ ${vehicleDetails["price_per_day_without_dr"]}", style: TextStyle(fontSize: screenHeight * 0.03, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: screenHeight * 0.025),
          //######################## vehicle sub details milage, transmisson, seats, Fuel #######################################################################################################               
                Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: const[
                            Icon(Icons.speed_outlined, color: kPrimaryColor,),
                          ],
                        ),
                        SizedBox(width: screenWidth * 0.015,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                           Text("Milage",style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenHeight * 0.017),),
                           Text("${vehicleDetails["milage"]} km", style: TextStyle( fontSize: screenHeight * 0.017),),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: screenWidth * 0.25,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: const [
                             Icon(Icons.local_taxi_outlined, color: kPrimaryColor,),
                          ],
                        ),
                        SizedBox(width: screenWidth * 0.015,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                           Text("Transmission",style: TextStyle(fontWeight: FontWeight.bold,fontSize: screenHeight * 0.017),),
                           Text("${vehicleDetails["transmission"]}", style: TextStyle( fontSize: screenHeight * 0.017) ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.025),

                Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start ,
                          children: const[
                            Icon(Icons.airline_seat_recline_normal_outlined, color: kPrimaryColor,),
                          ],
                        ),
                        SizedBox(width: screenWidth * 0.015,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                           Text("Seats",style: TextStyle(fontWeight: FontWeight.bold,fontSize: screenHeight * 0.017),),
                           Text("${vehicleDetails["seats"]} adults",style: TextStyle( fontSize: screenHeight * 0.017)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: screenWidth * 0.285,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: const [
                             Icon(Icons.local_gas_station_outlined, color: kPrimaryColor,),
                          ],
                        ),
                        SizedBox(width: screenWidth * 0.015,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                           Text("Fuel",style: TextStyle(fontWeight: FontWeight.bold,fontSize: screenHeight * 0.017),),
                          SizedBox(width: screenWidth * 0.3,   child: Text("${vehicleDetails["fuel"]}",maxLines: 4,style: TextStyle( fontSize: screenHeight * 0.017)),), 
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
               SizedBox(height: screenHeight * 0.021),
          //######################## submit review  #######################################################################################################               
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const VehicleFeedbackScreen()));
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: kPrimaryColor,
                    textStyle: const TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold  // add underline style
                  ),
                  ),
                  child: Text(
                    'Submit Review',
                    style: TextStyle(
                      fontSize: screenHeight * 0.025,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
 //######################## vehicle description ...  #######################################################################################################               
                DividerContainer(text: "Description", press: () {
                  String vehicleDescription = vehicleDetails["description"];
                  Navigator.push(context,MaterialPageRoute(builder: (context) => DescriptionScreen(vehicleDescription: vehicleDescription)));
                }
                ),
                DividerContainer(text: "Features", press: () {
                  String vehicleFeatures = vehicleDetails["features"];
                  Navigator.push(context,MaterialPageRoute(builder: (context) => FeaturesScreen(vehicleFeatures: vehicleFeatures)));
                }),
                SizedBox(height: screenHeight * 0.011),
                const Divider(thickness: 1.0),
                SizedBox(height: screenHeight * 0.016),
                Text( "Reviews", style: TextStyle(fontSize: screenHeight * 0.025,fontWeight: FontWeight.bold)),
                SizedBox(height: screenHeight * 0.02),
      //#####################################      vehicle Review   ##################################################################################                    
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: ((vehicleDetails["driverRatingsAverage"]+vehicleDetails["vehicleRatingsAverage"])/2).toDouble(),
                      itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: kPrimaryColor,
                      ),
                      itemCount: 5,
                      itemSize: screenHeight * 0.03,
                      direction: Axis.horizontal,
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    Text("Based on $numOfReview ratings", style: TextStyle(fontSize: screenHeight * 0.022)),
                  ],
                ),
                SizedBox(height: screenHeight * 0.01),
                Text("       (${((vehicleDetails["driverRatingsAverage"]+vehicleDetails["vehicleRatingsAverage"])/2).toDouble()}/5)", style: TextStyle(fontSize: screenHeight * 0.022)),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  children: [
                    Text("Driver ", style: TextStyle(fontSize: screenHeight * 0.022)),
                    SizedBox(width: screenWidth * 0.07,),
                    LinearPercentIndicator(
                      width: screenWidth * 0.5,
                      barRadius: Radius.circular(screenHeight * 0.02),
                      animation: true,
                      lineHeight: screenHeight * 0.022,
                      animationDuration: 2500,
                      percent: ((vehicleDetails["driverRatingsAverage"]*100)/5.toDouble())/100,
                      center: Text("${((vehicleDetails["driverRatingsAverage"]*100)/5).toStringAsFixed(2)}%", style: TextStyle(fontSize: screenHeight * 0.015,color: Colors.white),),
                      progressColor: kPrimaryColor,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  children: [
                    Text("Vehicle ", style: TextStyle(fontSize: screenHeight * 0.022)),
                    SizedBox(width: screenWidth * 0.05,),
                    LinearPercentIndicator(
                      width: screenWidth * 0.5,
                      barRadius: Radius.circular(screenHeight * 0.02),
                      animation: true,
                      lineHeight: screenHeight * 0.022,
                      animationDuration: 2500,
                      percent: ((vehicleDetails["vehicleRatingsAverage"]*100)/5.toDouble())/100,
                      center: Text("${((vehicleDetails["vehicleRatingsAverage"]*100)/5).toStringAsFixed(2)}%", style: TextStyle(fontSize: screenHeight * 0.015,color: Colors.white),),
                      progressColor: kPrimaryColor,
                    ),
                  ],
                ),
            //#####################################      Person revieew   ##################################################################################                    
          
                SizedBox(height: screenHeight * 0.02,),
                const Divider(thickness: 1.0),
                SizedBox(
                  height: screenHeight * 0.5,
                  child: 
                  isloading2  ? 
                    Center(child: CircularProgressIndicator(
                      backgroundColor: Colors.grey[200], // Set the background color of the widget
                      valueColor: const AlwaysStoppedAnimation<Color>(kPrimaryColor), // Set the color of the progress indicator
                      strokeWidth: 3, 
                    )) 
                  :
                  (numOfReview < 1) ? Text("No reviews for this tour yet",style: TextStyle(fontSize: screenHeight * 0.02,fontWeight: FontWeight.bold),):
                  ListView.builder(
                    //shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: vehicleReviews.length,
                    itemBuilder: (BuildContext context, int index) {
                      return 
                      SizedBox(
                        width: screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  backgroundImage:NetworkImage(kprofilePhoto),
                                ),
                                SizedBox(width: screenWidth * 0.05,),
                                Text(vehicleReviews[index]['name'], style: TextStyle(fontSize: screenHeight * 0.02,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            //SizedBox(height: screenHeight * 0.01,),
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    const Text("vehicle"),
                                    RatingBarIndicator(
                                      rating: vehicleReviews[index]['vehicleRating'].toDouble(),
                                      itemBuilder: (context, index) => const Icon(
                                          Icons.star,
                                          color: kPrimaryColor,
                                      ),
                                      itemCount: 5,
                                      itemSize: screenHeight * 0.03,
                                      direction: Axis.horizontal,
                                    ),
                                  ],
                                ),
                                SizedBox(width: screenWidth * 0.05,),
                                Column(
                                  children: [
                                    const Text("Driver"),
                                    RatingBarIndicator(
                                      rating: vehicleReviews[index]['driverRating'].toDouble(),
                                      itemBuilder: (context, index) => const Icon(
                                          Icons.star,
                                          color: kPrimaryColor,
                                      ),
                                      itemCount: 5,
                                      itemSize: screenHeight * 0.03,
                                      direction: Axis.horizontal,
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            SizedBox(height: screenHeight * 0.01,),
                            ReadMoreText(
                              vehicleReviews[index]['review'],
                              trimLines: 2,
                              colorClickableText: kPrimaryColor,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: 'Read more',
                              trimExpandedText: "",
                              moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              //lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: screenHeight * 0.01,),
                            Row(
                              children: [
                                const Icon(Icons.calendar_month_outlined, color: kPrimaryColor,),
                                SizedBox(width: screenWidth * 0.02),
                                Text(vehicleReviews[index]['updatedAt'].split('T')[0]),
                              ],
                            ),
                            const Divider(thickness: 1.0),
                            
                          ],
                        ),
                      );
                    }
                  ),
                ),
                
              ]
            ),
          ),
        ),
      ),
    );
  }
}