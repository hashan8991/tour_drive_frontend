// ignore_for_file: await_only_futures

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:tour_drive_frontend/screens/navbar_main_page/navbar_main_page.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/single_tour_screen.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tour_drive_frontend/screens/tour_screen/tour_filter.dart';

class TourHomeScreen extends StatefulWidget {

  const TourHomeScreen({super.key});

  @override
  State<TourHomeScreen> createState() => _TourHomeScreenState();
}

class _TourHomeScreenState extends State<TourHomeScreen> {
// ####################################################################################################################
  // Backend Integration
  List<dynamic> tours = [];
  List<String>? catergories = [];
  //List<String> reviewScore = [];
  int? minPrice = 0;
  int? maxPrice = 2000;
  bool isloading = true;
  
  Future<void> fetchTours() async {
    // Get filter values
    final prefs = await SharedPreferences.getInstance();
    catergories = await prefs.getStringList('tourCatergories');
    // String? jsonString = await (prefs.getString('tourReviewScore'));
    // reviewScore = (jsonString == null) ? "" : json.decode(jsonString);
    minPrice = await prefs.getInt('tourMinPrice');
    maxPrice = await prefs.getInt('tourMaxPrice');

    // send get reqest to server get all tours
    final http.Response response;
    if (catergories == null && minPrice == null && maxPrice == null) {

         response = await http.get(Uri.parse('$URL/api/v1/tours?limit=10&price[gte]=0&price[lte]=2000'));

    }else {

      String url = "$URL/api/v1/tours?limit=10";
      url += (catergories!.isEmpty) ? "" : "&category=${catergories!.join(",")}"; 
      url += "&price[gte]=$minPrice";
      url += "&price[lte]=$maxPrice";
      response = await http.get(Uri.parse(url));

    }
    
    if (response.statusCode == 200) {
      
      setState(() {
        final Map<String, dynamic> responseData =  jsonDecode(response.body);
        tours =  responseData["data"];
        //print(tours[0]["tour_cover"]);
        isloading = false;
      });

    } else {
      throw Exception('Failed to load Tour');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTours();
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

              final kprefs = await SharedPreferences.getInstance();
              await kprefs.remove('tourCatergories');
              await kprefs.remove('tourReviewScore');
              await kprefs.remove('tourMinPrice');
              await kprefs.remove('tourMaxPrice');
              // ignore: use_build_context_synchronously
              Navigator.push(context, MaterialPageRoute(builder: (context) => const NavbarMainPage()));

            }, 
            icon: const Icon(Icons.arrow_back, color:Colors.black, )
          ),
          elevation: 0,
          title: Image.asset("assets/images/logoPic.png", width: screenWidth * 0.55,),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.black, ),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => const TourFilter()));
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
              Text("Explore Sri Lanka, One tour at a time", style: TextStyle(fontSize: screenHeight * 0.026, fontWeight: FontWeight.bold),),
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
              tours.isEmpty ? 
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
                  itemCount: tours.length,
                  itemBuilder: (BuildContext context, int index) {
                  final tour = tours[index];
                      
                  return GestureDetector(
                    onTap: () async{
                      // Store the  tour ID in shared preferences
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setString('tourId', tour["_id"]);
                      // ignore: use_build_context_synchronously
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SingleTourScreen()));
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
                                child: Image.network('$urlPhoto/tour-uploads/${tour["tour_cover"]}',errorBuilder: (context, error, stackTrace) => Image.network('https://www.tgsin.in/images/joomlart/demo/default.jpg', fit: BoxFit.fill, height: screenHeight * 0.14,width: screenWidth * 0.29, ), fit: BoxFit.fill, height: screenHeight * 0.14,width: screenWidth * 0.29, )),
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
                                    Text( tour["name"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenHeight * 0.019), maxLines: 2, overflow: TextOverflow.ellipsis,),
                                    SizedBox(height: screenHeight * 0.008,),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on_outlined, color: kPrimaryColor, size: 12.0,),
                                        SizedBox(width: screenWidth * 0.40, child: Text("${tour["cities"]}", style: TextStyle(fontSize: screenHeight * 0.018), maxLines:1, overflow: TextOverflow.ellipsis,)),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.008,),
                                    Row(
                                      children: [
                                       RatingBarIndicator(
                                        rating: ((tour["locationRatingsAverage"]+tour["serviceRatingsAverage"])/2).toDouble(),
                                        itemBuilder: (context, index) => const Icon(
                                            Icons.star,
                                            color: kPrimaryColor,
                                        ),
                                        itemCount: 5,
                                        itemSize: screenHeight * 0.021,
                                        direction: Axis.horizontal,
                                        ),
                                        SizedBox(width: screenWidth * 0.02,),
                                        Text("${tour["ratingsQuantity"]} reviews", style: TextStyle(fontSize: screenHeight *0.016),)
                                      ]
                                    ),
                                    SizedBox(height: screenHeight * 0.007,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.people_outline_sharp, color: kPrimaryColor, size: screenHeight * 0.02,),
                                            SizedBox(width: screenWidth *0.005,),
                                            Text("${tour["capacity"]}"),
                                          ],
                                        ),
                                        SizedBox(width: screenHeight * 0.01,),
                                        Row(
                                          children: [
                                            Icon(Icons.timer_outlined, color: kPrimaryColor, size: screenHeight * 0.02,),
                                            SizedBox(width: screenWidth *0.005,),
                                            Text("${tour["duration"]} days"),
                                          ],
                                        ),
                                        SizedBox(width: screenWidth * 0.09,),
                                        Text("\$ ${tour["price"].toStringAsFixed(0)}", style: TextStyle(fontSize: screenHeight * 0.021,fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.001,),
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

