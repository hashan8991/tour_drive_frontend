import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/screens/tour_screen/single_tour_screen/single_tour_screen.dart';
import 'package:tour_drive_frontend/widgets/header.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';

class TourMapScreen extends StatefulWidget {
  const TourMapScreen({super.key});

  @override
  State<TourMapScreen> createState() => _TourMapScreenState();
}

class _TourMapScreenState extends State<TourMapScreen> {
  // List<LatLng> locations = [
  // LatLng(37.7749, -122.4194), // San Francisco
  // LatLng(40.7128, -74.0060), // New York
  // LatLng(51.5074, -0.1278), // London
// ];
@override
  void initState() {
    super.initState();
    //MapboxMapController.registerWith();
  }

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        // body: MapboxMap(
        //       accessToken: 'pk.eyJ1IjoiY2hlcmlucGl5dW1hbnRoYSIsImEiOiJja2xuNGprczQwZnBjMm5uM3NwZ2Q1bjY5In0.WmrYfERdPhdhkkuXwcDC8g',
        //       initialCameraPosition: CameraPosition(
        //         target: locations[0],
        //         zoom: 4,
        //       ),
        //       onMapCreated: (MapboxMapController controller) {
        //         // You can customize the map here
        //         for (var location in locations) {
        //           controller.addSymbol(SymbolOptions(
        //             geometry: location,
        //             iconImage: 'airport-15',
        //             iconSize: 1.5,
        //             iconColor: '#FF0000', // This is an example icon
        //           ));
        //         }
        //       },
        //     ),
      ),
    );
  }
}