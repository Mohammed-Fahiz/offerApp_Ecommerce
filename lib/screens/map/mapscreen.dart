import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  final Set<Marker> _markers = {};
  static LatLng? latLng;
  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId("111"),
        position: _center,
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }
  var myposition;
  bool loading = true;
  LocationData? currentLocation;
  Future <Position> getUserCurrentLocation() async{
    await Geolocator.requestPermission().then((value)  {
      getUserCurrentLocation().then((value) async {
        print('my current location');
        print(value.toString());
        print(value.latitude.toString()+""+value.longitude.toString());
        myposition=LatLng(value.latitude,value.longitude);
        _markers.add(
            Marker(markerId:MarkerId('2'),
                position:LatLng(value.latitude,value.longitude),

                infoWindow:InfoWindow(
                    title: 'Hello'
                )

            ));
        CameraPosition cameraPosition=CameraPosition(
            zoom: 14,

            target:LatLng(value.latitude,value.longitude));


        final GoogleMapController controller= await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
        setState(() {

        });
      });

    }).onError((error, stackTrace) {
      print("error"+error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

@override
  void initState() {
  getUserCurrentLocation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: _markers,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
    );
  }
}
