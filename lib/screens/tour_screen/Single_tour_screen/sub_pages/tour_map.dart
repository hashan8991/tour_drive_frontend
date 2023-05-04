import 'package:flutter/material.dart';
import 'package:tour_drive_frontend/constants.dart';
import 'package:flutter_map/flutter_map.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';

class TourMapScreen extends StatefulWidget {
  final List<dynamic> locations;
  const TourMapScreen({super.key,required this.locations});

  @override
  State<TourMapScreen> createState() => _TourMapScreenState();
}

class _TourMapScreenState extends State<TourMapScreen> {
  

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Tour Locations', style: TextStyle(color: Colors.white),),
        ),
        body: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                center: LatLng(widget.locations[0][0],widget.locations[0][1]),
                zoom: 8.0,
              ),
              children: [
                TileLayer(
                    urlTemplate: 'https://api.mapbox.com/styles/v1/zerorobot/clh7yxz0k00xp01pg2l12c2af/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiemVyb3JvYm90IiwiYSI6ImNqOWgyajN2cjM1NnkycW5ycXF2Yms0M2kifQ.qDsoRRUqa9XsWBtcGNt9aQ',
                    additionalOptions: const {
                    'mapStyleId': 'mapbox://styles/zerorobot/clh7yxz0k00xp01pg2l12c2af',
                    'accessToken': 'pk.eyJ1IjoiemVyb3JvYm90IiwiYSI6ImNqOWgyajN2cjM1NnkycW5ycXF2Yms0M2kifQ.qDsoRRUqa9XsWBtcGNt9aQ',
                  },
                ),
                MarkerLayer(
                    markers: widget.locations
                    .map((location) => Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(location[0], location[1]), // convert the location to a LatLng object
                          builder: (ctx) => const Icon(Icons.location_on, color: kPrimaryColor, size:40.0,),
                        ))
                    .toList()
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}