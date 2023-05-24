// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/sub_pages/tour_check_availability.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/sub_pages/included_excluded.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/sub_pages/overview.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/sub_pages/tour_highlights.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/sub_pages/tour_plan.dart';
import 'package:tour_drive_frontend/screens/tour_screen/tour_home_screen.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/sub_pages/tour_feedback_screen.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/sub_pages/tour_map.dart';
import 'package:tour_drive_frontend/widgets/divider_container.dart';
import 'package:tour_drive_frontend/widgets/favorite_icon.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SingleTourScreen extends StatefulWidget {
  const SingleTourScreen({super.key});

  @override
  State<SingleTourScreen> createState() => _SingleTourScreenState();
}

class _SingleTourScreenState extends State<SingleTourScreen> {
  // ####################################################################################################################
    // Backend Integration
  var tourDetails;
  List<dynamic> tourReviews  = [];
  var numOfReview;
  var alreadybooking;
  bool isloading1 = true;
  bool isloading2 = true;

  Future<void> fetchTour() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tourId = prefs.getString('tourId');
    
    final response = await http.get(Uri.parse('$URL/api/v1/tours/$tourId'));
    
    if (response.statusCode == 200) {
      setState(() {
        final Map<String, dynamic> responseData =  jsonDecode(response.body);
        tourDetails =  responseData["data"];
        isloading1 = false;
      });
    } else {
      throw Exception('Failed to load Tour');
    }
  }

  Future<void> fetchTourReview() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tourId = prefs.getString('tourId');

    final response = await http.get(Uri.parse('$URL/api/v1/reviews?tour=$tourId'));
   
    if (response.statusCode == 200) {
      setState(() {
        final Map<String, dynamic> responseData =  jsonDecode(response.body);
        tourReviews =  responseData["data"]["reviews"];
        numOfReview = responseData["results"];
        isloading2 = false;

      });
    } else {
      throw Exception('Failed to load Tour');
    }
  }

  Future<void> getTotalBooking() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tourId = prefs.getString('tourId');
    final cookie = await prefs.getString('Cookie');

    final response = await http
    .get(Uri.parse('$URL/api/v1/booking/bookings-count/$tourId'),
      headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'cookie': (cookie == null) ? "" : cookie,
        },
      );
   
    if (response.statusCode == 200) {
      setState(() {
        final Map<String, dynamic> responseData =  jsonDecode(response.body);
        alreadybooking = responseData['data']['bookingCount'];
      });
    } else {
      throw Exception('Failed to get total booking');
    }
  }
  @override
  void initState() {
    super.initState();
    fetchTour();
    fetchTourReview();
    getTotalBooking();
  
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

                String tourname = tourDetails['name'];
                String tourdes = tourDetails['description'];
                int price = tourDetails['price'];
                String tourStartDate = tourDetails["start_date"].split('T')[0];
                String tourEndDate = tourDetails["end_date"].split('T')[0];
                String capacity = tourDetails['capacity'];
                
         
                Navigator.push(context,MaterialPageRoute(builder: (context) => TourCheckAvailabilityScreen(tourname: tourname, tourdes: tourdes, tourStartDate: tourStartDate, tourEndDate: tourEndDate, price: price, capacity1: capacity, alreadybooking: alreadybooking))); 
              },
              label: const Text('Check availability'),
            ),
         ),
       ),
       
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () { Navigator.pop(context,MaterialPageRoute(builder: (context) =>const TourHomeScreen())); }, 
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
                    itemCount: tourDetails["tour_gallery"].length,
                    itemBuilder: ((context, index) {
                      return Row(
                        children: [
                          Image.network('$urlPhoto/tour-uploads/${tourDetails["tour_gallery"][index]}', fit: BoxFit.fill, height: screenHeight * 0.3, width: screenWidth * 0.7,
                          errorBuilder: (context, error, stackTrace) => Image.network('https://www.tgsin.in/images/joomlart/demo/default.jpg', fit: BoxFit.fill, height: screenHeight * 0.3,width: screenWidth * 0.7,)),
                          SizedBox(width: screenWidth * 0.03,)

                      ],);
                    }
                    ),
                  ),
                ),
            
                SizedBox(height: screenHeight * 0.02),
            //######################## Tour name #######################################################################################################               
                Text(tourDetails['name'], style: TextStyle(fontSize: screenHeight *0.03, fontWeight: FontWeight.bold)),
                SizedBox(height: screenHeight * 0.02),
            
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: kPrimaryColor, size: 15.0,),
                    SizedBox(width: screenWidth * 0.005),
            //######################## Tour location #######################################################################################################               
                    SizedBox(width: screenWidth * 0.85, child: Text(tourDetails['cities'], style: TextStyle(fontSize: screenHeight * 0.017 ),maxLines: 2, overflow: TextOverflow.ellipsis),), 
                  ],
                ),
            //######################## Tour Reviews #######################################################################################################               
                SizedBox(height: screenHeight * 0.02),
                Row(children: [
                  RatingBarIndicator(
                    rating: ((tourDetails["locationRatingsAverage"]+tourDetails["serviceRatingsAverage"])/2).toDouble(),
                    itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: kPrimaryColor,
                    ),
                    itemCount: 5,
                    itemSize: screenHeight * 0.024,
                    direction: Axis.horizontal,
                  ),
                  SizedBox(width: screenWidth * 0.05,),
                  Text("${tourDetails['ratingsQuantity']} Reviews")
                ]
                ), 
                SizedBox(height: screenHeight * 0.025),
                Row(
                  children: [
                    const Icon(Icons.sell_outlined, color: kPrimaryColor, size: 20.0,),
                    SizedBox(width: screenWidth * 0.02),
            //######################## Tour Price #######################################################################################################               
                     Text("\$ ${tourDetails['price']}", style: TextStyle(fontSize: screenHeight * 0.03, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: screenHeight * 0.025),
            //######################## Tour sub details duration, max people, min age, pick up #######################################################################################################               
                Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: const[
                            Icon(Icons.date_range, color: kPrimaryColor,),
                          ],
                        ),
                        SizedBox(width: screenWidth * 0.015,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                           Text("Duration",style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenHeight * 0.017),),
                           Text("${tourDetails['duration']} days", style: TextStyle( fontSize: screenHeight * 0.017),),
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
                             Icon(Icons.group_outlined, color: kPrimaryColor,),
                          ],
                        ),
                        SizedBox(width: screenWidth * 0.015,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                           Text("Max People",style: TextStyle(fontWeight: FontWeight.bold,fontSize: screenHeight * 0.017),),
                           Text("${tourDetails['capacity']}", style: TextStyle( fontSize: screenHeight * 0.017) ),
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
                            Icon(Icons.man_sharp, color: kPrimaryColor,),
                          ],
                        ),
                        SizedBox(width: screenWidth * 0.015,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                           Text("Min Age",style: TextStyle(fontWeight: FontWeight.bold,fontSize: screenHeight * 0.017),),
                           Text("${tourDetails['age_limit']}+",style: TextStyle( fontSize: screenHeight * 0.017)),
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
                             Icon(Icons.location_on, color: kPrimaryColor,),
                          ],
                        ),
                        SizedBox(width: screenWidth * 0.015,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                           Text("Pick up",style: TextStyle(fontWeight: FontWeight.bold,fontSize: screenHeight * 0.017),),
                          SizedBox(width: screenWidth * 0.3,   child: Text("Air port ",maxLines: 4,style: TextStyle( fontSize: screenHeight * 0.017)),), 
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
                                const TourFeedbackForm()));
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: kPrimaryColor,
                    textStyle: const TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold // add underline style
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
           //######################## Touroverview ...  #######################################################################################################               
                DividerContainer(text: "Overview", press: () {
                  String tourDescription = tourDetails["description"];
                  Navigator.push(context,MaterialPageRoute(builder: (context) => OverviewScreen(tourDescription: tourDescription)));
                }
                ),
                DividerContainer(text: "Tour Highlights", press: () {
                  String tourHighlights = tourDetails["highlights"];
                  Navigator.push(context,MaterialPageRoute(builder: (context) => TourhighlightScreen(tourHighlights: tourHighlights)));
                }),
                DividerContainer(text: "Included / Excluded", press: () {
                  String tourIncludes = tourDetails["includes"];
                  String tourExcludes = tourDetails["excludes"];
                  Navigator.push(context,MaterialPageRoute(builder: (context) => IncludeExcludeScreen(tourIncludes: tourIncludes, tourExcludes: tourExcludes)));
                }),
                DividerContainer(text: "Tour Plan", press: () {
                  List<String> tourPlan = tourDetails['tourPlan'].cast<String>();
                  Navigator.push(context,MaterialPageRoute(builder: (context) => TourPlanScreen(tourPlan: tourPlan)));
                }),
                const Divider(thickness: 1.0),
            //#####################################      Tour Map   ##################################################################################        
                SizedBox(height: screenHeight * 0.012),
                Text( "Tour Map", style: TextStyle(fontSize: screenHeight * 0.025,fontWeight: FontWeight.bold)),
                SizedBox(height: screenHeight * 0.023),
                GestureDetector(
                  onTap: () {
                    List<dynamic> locations = tourDetails["locations"];
                    Navigator.push(context,MaterialPageRoute(builder: (context) => TourMapScreen(locations: locations)));
                  },
                  child: Image.asset('assets/images/map.jpeg', fit: BoxFit.fill, height: screenHeight * 0.15, width: screenWidth,)
                ),
                SizedBox(height: screenHeight * 0.023),
                const Divider(thickness: 1.0),
                SizedBox(height: screenHeight * 0.016),
                Text( "Reviews", style: TextStyle(fontSize: screenHeight * 0.025,fontWeight: FontWeight.bold)),
                SizedBox(height: screenHeight * 0.02),
                //#####################################      Tour Review   ##################################################################################                    
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: ((tourDetails["locationRatingsAverage"]+tourDetails["serviceRatingsAverage"])/2).toDouble(),
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
                Text("       (${((tourDetails["locationRatingsAverage"]+tourDetails["serviceRatingsAverage"])/2).toDouble()}/5)", style: TextStyle(fontSize: screenHeight * 0.022)),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  children: [
                    Text("Location ", style: TextStyle(fontSize: screenHeight * 0.022)),
                    SizedBox(width: screenWidth * 0.02,),
                    LinearPercentIndicator(
                      width: screenWidth * 0.5,
                      barRadius: Radius.circular(screenHeight * 0.02),
                      animation: true,
                      lineHeight: screenHeight * 0.022,
                      animationDuration: 2500,
                      percent: ((tourDetails["locationRatingsAverage"]*100)/5.toDouble())/100,
                      center: Text("${((tourDetails["locationRatingsAverage"]*100)/5)}%", style: TextStyle(fontSize: screenHeight * 0.015,color: Colors.white),),
                      progressColor: kPrimaryColor,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  children: [
                    Text("Service ", style: TextStyle(fontSize: screenHeight * 0.022)),
                    SizedBox(width: screenWidth * 0.05,),
                    LinearPercentIndicator(
                      width: screenWidth * 0.5,
                      barRadius: Radius.circular(screenHeight * 0.02),
                      animation: true,
                      lineHeight: screenHeight * 0.022,
                      animationDuration: 2500,
                      percent: ((tourDetails["serviceRatingsAverage"]*100)/5.toDouble())/100,
                      center: Text("${((tourDetails["serviceRatingsAverage"]*100)/5)}%", style: TextStyle(fontSize: screenHeight * 0.015,color: Colors.white),),
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
                    itemCount: tourReviews.length,
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
                                  backgroundImage:NetworkImage('https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper.png'),
                                ),
                                SizedBox(width: screenWidth * 0.05,),
                                Text(tourReviews[index]['name'], style: TextStyle(fontSize: screenHeight * 0.02,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            //SizedBox(height: screenHeight * 0.01,),
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    const Text("Location"),
                                    RatingBarIndicator(
                                      rating: tourReviews[index]['locationRating'].toDouble(),
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
                                    const Text("Service"),
                                    RatingBarIndicator(
                                      rating: tourReviews[index]['serviceRating'].toDouble(),
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
                              tourReviews[index]['review'],
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
                                Text(tourReviews[index]['updatedAt'].split('T')[0]),
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


