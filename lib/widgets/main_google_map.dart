import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:map_app/models/place_model.dart';

class MainGoogleMap extends StatefulWidget {
  const MainGoogleMap({super.key});

  @override
  State<MainGoogleMap> createState() => _MainGoogleMapState();
}

class _MainGoogleMapState extends State<MainGoogleMap> {
  late String mapStyle;
  GoogleMapController? googleMapController;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  late Location location;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadMapStyle();
    });
    initMarkers();
    initPolyLines();
    location = Location();
    updateMyLocation();
  }

  Future<void> checkAndRequestLocationService() async {
    bool isServiceEnabled = await location.serviceEnabled();
    if(!isServiceEnabled){
      isServiceEnabled = await location.requestService();
      if(!isServiceEnabled){
        return;
      }
    }
  }
  Future<bool> checkAndRequestLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if(permissionStatus == PermissionStatus.deniedForever){
      return false;
    }
    if(permissionStatus == PermissionStatus.denied){
      permissionStatus = await location.requestPermission();
      if(permissionStatus != PermissionStatus.granted){
        return false;
      }
    }
    return true;
  }
  void getLocationData(){
    location.onLocationChanged.listen((locationData) {
      var cameraPosition = CameraPosition(target: LatLng(locationData.latitude!, locationData.longitude!), zoom: 12);
      googleMapController?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    });
  }

  void updateMyLocation() async {
    await checkAndRequestLocationService();
    var hasPermission = await checkAndRequestLocationPermission();
    if(hasPermission){
      getLocationData();
    } else{

    }
  }
  void initPolyLines(){
    Polyline polyline = Polyline(
      polylineId: PolylineId('1'),
      points: [],
    );
    polylines.add(polyline);
  }

  void initMarkers(){
    var myMarkers = places.map(
          (placeModel) => Marker(
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue,
            ),
            infoWindow: InfoWindow(
              title: placeModel.name,
            ),
            position: placeModel.latLng,
            markerId: MarkerId(
              placeModel.id.toString(),
            ),
          ),
    ).toSet();
    markers.addAll(myMarkers);
    setState(() {});
  }
  Future<void> loadMapStyle() async{
      final String style = await DefaultAssetBundle.of(context).loadString('assets/map_styles/night_maps_style.json');
      setState(() {
        mapStyle = style;
      });
  }

  @override
  Widget build(BuildContext context) {

    return GoogleMap(
      polylines: polylines,
      zoomControlsEnabled: false,
      initialCameraPosition: CameraPosition(
        target: LatLng(
          27.256747592535554, 33.8162738641592,
        ),
        zoom: 12,
      ),
      onMapCreated: (GoogleMapController controller){
        googleMapController = controller;
      },
      style: mapStyle,
      markers: markers,
    );
  }
}
