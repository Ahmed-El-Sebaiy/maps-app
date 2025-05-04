import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_app/widgets/main_google_map.dart';

void main() {
  runApp(const TestGoogleMaps());
}

class TestGoogleMaps extends StatelessWidget {
  const TestGoogleMaps({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MainGoogleMap(),
    );
  }
}