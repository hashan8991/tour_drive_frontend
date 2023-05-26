import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;



class TourOptionNewScreen extends StatefulWidget {
  const TourOptionNewScreen({super.key});

  @override
  State<TourOptionNewScreen> createState() => _TourOptionNewScreenState();
}

  class Location {
    final String city;
    final List<String> availableLocations;

    Location({required this.city, required this.availableLocations});
  }

class _TourOptionNewScreenState extends State<TourOptionNewScreen> {

// ########################## Booked Tours Integration ###############################################################################

  List<dynamic> tourBookingDetails = [];
  late bool isloading = false ;
  late int numofbooking;
  
  get cities => null;

  Future<void> fetchTourBooking() async {

    setState(() {
      isloading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final cookie = await prefs.getString('Cookie');
    
    final response = await http
        .get(Uri.parse('$URL/api/v1/booking/my-bookings/tours'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'cookie': (cookie==null) ? "" : cookie,
        },
    );

    if (response.statusCode == 200) {
      setState(() {
        final Map<String, dynamic> responseData =  jsonDecode(response.body);
        tourBookingDetails =  responseData["data"]["bookings"];
        numofbooking = responseData["records"];
      });
    } else {
      throw Exception('Failed to load TourBooking Details');
    }

    setState(() {
      isloading = false;
    });

  }
// ###############################-----------------------------------------------------------------#################################################################################################################

// ########################## Request Custom tour #################################################################################################################################################

List<Map<String, dynamic>> locations = [
    {
      "city": "galle",
      "availableLocations": [
        "Unawatuna Beach",
        "Galle Fort",
        "Jungle Beach",
        "Mihiripenna Beach",
        "Japanese Peace Pagoda",
      ],
    },
    {
      "city": "matara",
      "availableLocations": [
        "Parey Dewa Buddhist Temple",
        "Weherahena Buddhist Temple",
        "Dondra Head Lighthouse",
        "Polhena Beach",
        "Mirissa Beach",
      ],
    },
    {
      "city": "hambantota",
      "availableLocations": [
        "Yala National Park",
        "Bundala National Park",
        "Tissamaharama",
        "Kataragama",
        "Sithulpawwa Rock Temple",
      ],
    },
  ];

  String? _selectedCity;
  List<String> _selectedLocations = [];
  List<String> _cities = [];

  final _cityController = TextEditingController();

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

// ###############################-----------------------------------------------------------------#################################################################################################################

  @override
  void initState() {
    super.initState();
    fetchTourBooking();
  }

  List<DropdownMenuItem<String>> _getDropdownItems(String city) {
  final location = locations.firstWhere(
    (location) => location["city"].toLowerCase() == city.toLowerCase(),
  );

  final availableLocations = List<String>.from(location["availableLocations"]);

  return availableLocations
      .map(
        (location) => DropdownMenuItem<String>(
          value: location,
          child: Text(location),
        ),
      )
      .toList();

 
}

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return 
       DefaultTabController(
        length: 3, // set the length of the tab bar to 4
        child: Scaffold(

          appBar: AppBar(
            title: const Text('Tour Option', style: TextStyle(color: Colors.black),),
            backgroundColor: Colors.white,
            bottom: const TabBar(
              indicatorColor: kPrimaryColor,
              labelColor: Colors.black,
              tabs: [
                Tab( text: 'Booked\nTours'),
                Tab( text: 'Request\nCustom Tour'),
                Tab( text: 'Requested\nCustom Tour'),
              ],
            ),
          ),

          body: TabBarView(
            children: [
    // ########################## Booked Tours Integration ###############################################################################
              Column(
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
                  (numofbooking < 1) ? Text("No booking tours yet",style: TextStyle(fontSize: screenHeight * 0.02,fontWeight: FontWeight.bold),):
                  SizedBox(height: screenHeight * 0.03),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: tourBookingDetails.length,
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
                                      child: Image.network(
                                      tourBookingDetails != null && tourBookingDetails[index] != null && tourBookingDetails[index]["tour"] != null
                                          ? '$urlPhoto/tour-uploads/${tourBookingDetails[index]["tour"]["tour_cover"]}'
                                          : 'https://www.tgsin.in/images/joomlart/demo/default.jpg',
                                      errorBuilder: (context, error, stackTrace) => Image.network(
                                        'https://www.tgsin.in/images/joomlart/demo/default.jpg',
                                        fit: BoxFit.fill,
                                        height: screenHeight * 0.14,
                                        width: screenWidth * 0.29,
                                      ),
                                      fit: BoxFit.fill,
                                      height: screenHeight * 0.14,
                                      width: screenWidth * 0.29,
                                      ),
                                    ),
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
                                          Text(
                                            tourBookingDetails != null && tourBookingDetails[index] != null && tourBookingDetails[index]["tour"] != null
                                            ? "${tourBookingDetails[index]["tour"]["name"]}"
                                            : "${tourBookingDetails[index]["customTour"]["name"]}",
                                             style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenHeight * 0.02), maxLines: 2, overflow: TextOverflow.ellipsis,),
                                          SizedBox(height: screenHeight * 0.008,),                                    
                                          Text(
                                            tourBookingDetails != null && tourBookingDetails[index] != null && tourBookingDetails[index]["tour"] != null 
                                            ?"\$ ${tourBookingDetails[index]["tour"]["price"]}"
                                            : "\$ ${tourBookingDetails[index]["customTour"]["finalCost"]}",
                                           style: TextStyle(fontSize: screenHeight * 0.022,fontWeight: FontWeight.bold),),
                                          SizedBox(height: screenHeight * 0.008,),
                                          Text(
                                            tourBookingDetails != null && tourBookingDetails[index] != null && tourBookingDetails[index]["tour"] != null 
                                            ?"Check In    :   ${tourBookingDetails[index]["tour"]["start_date"].split('T')[0]}"
                                            : "${tourBookingDetails[index]["customTour"]["startDate"]}",
                                            style: TextStyle(fontSize: screenHeight * 0.018)), 
                                          SizedBox(height: screenHeight * 0.008,),
                                          Text(
                                            tourBookingDetails != null && tourBookingDetails[index] != null && tourBookingDetails[index]["tour"] != null 
                                            ?"Check Out :   ${tourBookingDetails[index]["tour"]["end_date"].split('T')[0]}"
                                            : "${tourBookingDetails[index]["customTour"]["endDate"]}",
                                            style: TextStyle(fontSize: screenHeight * 0.018)),  
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
    // ##########################------------------------------------------------------------------------------------------ ###############################################################################

    // ########################## Request Custom tour #################################################################################################################################################
       
      Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: DropdownButtonFormField<String>(
        value: _selectedCity,
        hint: Text("Select a city"),
        onChanged: (value) {
          setState(() {
            _selectedCity = value;
            _selectedLocations = locations
                .firstWhere((location) =>
                    location["city"].toLowerCase() ==
                    value!.toLowerCase())
                ["availableLocations"]
                .cast<String>();
          });
        },
        items: locations
            .map((location) => DropdownMenuItem<String>(
                  value: location["city"],
                  child: Text(location["city"]),
                ))
            .toList(),
      ),
    ),
    if (_selectedLocations.isNotEmpty)
      Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Available Locations",
              style:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _selectedLocations
                  .map((location) => Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          location,
                          style: TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    SizedBox(height: 16),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            if (_selectedCity != null && !_cities.contains(_selectedCity!)) {
              setState(() {
                _cities.add(_selectedCity!);
              });
            }
          },
          child: Text("Add"),
        ),
      ],
    ),
    SizedBox(height: 16),
    Text(
      "City List",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    SizedBox(height: 8),
  Wrap(
  spacing: 8,
  children: _cities
      .map((city) => Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _cities.remove(city);
              });
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                city,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _cities.remove(city);
              });
            },
            child: Icon(
              Icons.cancel,
              color: Colors.grey,
            ),
          ),
        ],
      ))
      .toList(),
),
  Expanded(
  child: ListView.builder(
    itemCount: _cities.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "City: ${_cities[index]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Select Locations",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: null,
                  hint: Text("Location 1"),
                  onChanged: (value) {},
                  items: _getDropdownItems(_cities[index]),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: null,
                  hint: Text("Location 2"),
                  onChanged: (value) {},
                  items: _getDropdownItems(_cities[index]),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: null,
                  hint: Text("Location 3"),
                  onChanged: (value) {},
                  items: _getDropdownItems(_cities[index]),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: null,
                  hint: Text("Location 4"),
                  onChanged: (value) {},
                  items: _getDropdownItems(_cities[index]),
                ),
              ],
            ),
          ),
        ),
      );
    },
  ),
),

  ],
),
  
      
      
    // ##########################------------------------------------------------------------------------------------------ ###############################################################################   
    
    //  ########################## Requested Custom tour #################################################################################################################################################
               Icon(Icons.directions_bike),
    // ##########################------------------------------------------------------------------------------------------ ###############################################################################    
              
              
               // add a new icon
            ],
          ),
        ),
      );
    
  }
}

