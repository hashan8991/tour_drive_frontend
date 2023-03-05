import 'package:flutter/cupertino.dart';

class Tour {
  final String name,locations;
  final int maxSeats,duration;
  final double id,price,ratingsAverage,reviews;
  Image? tourCover;
  String? category,type;
 
  Tour({
    required this.id,
    required this.name,
    this.tourCover,
    required this.locations,
    required this.ratingsAverage,
    required this.reviews,
    required this.maxSeats,
    required this.duration,
    required this.price,

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
    ratingsAverage: 2.5,
    reviews: 2,
    maxSeats: 18,
    duration: 4,
    price: 599,
    
  ),
  Tour(
    id: 2,
    name: "Wonder Of Sigiriya " ,
    tourCover: Image.asset('assets/images/sigiriya.jpeg'),
    locations: "Central Province, Sri Lanka",
    ratingsAverage: 4.5,
    reviews: 2,
    maxSeats: 12,
    duration: 8,
    price: 599,
    
  ),
  Tour(
    id: 1,
    name: "Wonder Of Sigiriya " ,
    tourCover: Image.asset('assets/images/sigiriya.jpeg'),
    locations: "Central Province, Sri Lanka",
    ratingsAverage: 2.5,
    reviews: 2,
    maxSeats: 18,
    duration: 4,
    price: 599,
    
  ),
  Tour(
    id: 1,
    name: "Wonder Of Sigiriya " ,
    tourCover: Image.asset('assets/images/sigiriya.jpeg'),
    locations: "Central Province, Sri Lanka",
    ratingsAverage: 2.5,
    reviews: 2,
    maxSeats: 18,
    duration: 4,
    price: 599,
    
  ),
  Tour(
    id: 1,
    name: "Wonder Of Sigiriya " ,
    tourCover: Image.asset('assets/images/sigiriya.jpeg'),
    locations: "Central Province, Sri Lanka",
    ratingsAverage: 2.5,
    reviews: 2,
    maxSeats: 18,
    duration: 4,
    price: 599,
    
  ),
  Tour(
    id: 1,
    name: "Wonder Of Sigiriya " ,
    tourCover: Image.asset('assets/images/sigiriya.jpeg'),
    locations: "Central Province, Sri Lanka",
    ratingsAverage: 2.5,
    reviews: 2,
    maxSeats: 18,
    duration: 4,
    price: 599,
    
  ),
  Tour(
    id: 1,
    name: "Wonder Of Sigiriya " ,
    tourCover: Image.asset('assets/images/sigiriya.jpeg'),
    locations: "Central Province, Sri Lanka",
    ratingsAverage: 2.5,
    reviews: 2,
    maxSeats: 18,
    duration: 4,
    price: 599,
    
  ),
  Tour(
    id: 1,
    name: "Wonder Of Sigiriya " ,
    tourCover: Image.asset('assets/images/sigiriya.jpeg'),
    locations: "Central Province, Sri Lanka",
    ratingsAverage: 2.5,
    reviews: 2,
    maxSeats: 18,
    duration: 4,
    price: 599,
    
  ),
  Tour(
    id: 1,
    name: "Wonder Of Sigiriya " ,
    tourCover: Image.asset('assets/images/sigiriya.jpeg'),
    locations: "Central Province, Sri Lanka",
    ratingsAverage: 2.5,
    reviews: 2, 
    maxSeats: 18,
    duration: 4,
    price: 599,
    
  ),
  
];