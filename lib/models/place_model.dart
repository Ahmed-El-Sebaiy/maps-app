import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel{
  final int id;
  final String name;
  final LatLng latLng;

  PlaceModel({required this.id, required this.name, required this.latLng});
}

List<PlaceModel> places = [
  PlaceModel(id: 1, name:'Go Bus' , latLng: LatLng(27.238304126220815,33.83205317931495),),
  PlaceModel(id: 2, name:'Dolphin House' , latLng: LatLng(27.252539546922225, 33.83834556926137),),
  PlaceModel(id: 3, name:'Red Sea Hospital' , latLng: LatLng(27.236311472211206, 33.83415397144954),),
];