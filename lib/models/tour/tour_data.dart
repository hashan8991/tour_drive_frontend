import 'package:flutter/cupertino.dart';

class Tour {
  String? name,locations,maxSeats,duration;
  double? id,price,ratingsAverage,reviews;
  Image? tourCover;
  String? category,type;
 
  Tour({
    this.id,
    this.name,
    this.tourCover,
    this.locations,
    this.ratingsAverage,
    this.reviews,
    this.maxSeats,
    this.duration,
    this.price,

    this.category,
    this.type,
   
  });
}

final List<Tour> tours = [
  Tour(
    id: 1,
    name: "Wonder Of Sigiriya " ,
    tourCover: Image.asset('assets/images/sigiriya.jpeg'),
    locations: "Central Province, Sri Lanka",
    ratingsAverage: 4.5,
    reviews: 2,
    maxSeats: "20",
    duration: "5",
    price: 599,
    
  ),
  Tour(
    id: 1,
    name: "Wonder Of Sigiriya " ,
    tourCover: Image.asset('assets/images/sigiriya.jpeg'),
    locations: "Central Province, Sri Lanka",
    ratingsAverage: 4.5,
    reviews: 2,
    maxSeats: "20",
    duration: "5",
    price: 599,
    
  ),
  
];