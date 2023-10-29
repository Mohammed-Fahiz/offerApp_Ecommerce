import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:offerapp/screens/map/mapservices.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {

  bool loading = true;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();

  Set<Polyline> get polyLines => _polyLines;
  Completer<GoogleMapController> _controller = Completer();
  var latLng;
  late LocationData currentLocation;


  // Future<Position> locateUser() async {
  //   return Geolocator()
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  // }

  @override
  void initState() {

    // loading = true;
    super.initState();

     setState(() {
       getLocation();
     });

  }

  // getUserLocation() async {
  //   __currentLocation = await locateUser();
  //   setState(() {
  //     latLng = LatLng(__currentLocation.latitude, __currentLocation.longitude);
  //     _onAddMarkerButtonPressed();
  //   });
  //   print('center:====== $latLng');
  // }


  getLocation() async {
    await Geolocator.requestPermission().then((value)  {
      getLocation().then((value) async {
        print('my current location');
        print(value.toString());
        print(value.latitude.toString()+""+value.longitude.toString());
        latLng=LatLng(value.latitude,value.longitude);

        print("getLocation:$latLng");
        _onAddMarkerButtonPressed();
        loading = false;

      });

    }).onError((error, stackTrace) {
      print("error"+error.toString());
    });
    return await Geolocator.getCurrentPosition();

        }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId("111"),
        position: latLng,
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }


  void onCameraMove(CameraPosition position) {
    latLng = position.target;
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  void sendRequest() async {
    LatLng destination = LatLng(11.1172, 73.780037);
    String route = await _googleMapsServices.getRouteCoordinates(
        latLng, destination);
    createRoute(route);
    _addMarker(destination, "KTHM Collage");
  }

  void createRoute(String encondedPoly) {
    _polyLines.add(Polyline(
        polylineId: PolylineId(latLng.toString()),
        width: 4,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.red));
  }

  void _addMarker(LatLng location, String address) {
    _markers.add(Marker(
        markerId: MarkerId("112"),
        position: location,
        infoWindow: InfoWindow(title: address, snippet: "go here"),
        icon: BitmapDescriptor.defaultMarker));
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = [];
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;

      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    for (var i = 2; i < lList.length; i++)
      lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  @override
  Widget build(BuildContext context) {
//    print("getLocation111:$latLng");
    return  Scaffold(
appBar: AppBar(),
      body:loading==true?Center(child: CircularProgressIndicator()):
      GoogleMap(
        polylines: polyLines,
        markers: _markers,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: latLng,
          zoom: 14.4746,
        ),
        onCameraMove: onCameraMove,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),


      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          sendRequest();
        },
        label: Text('Destination'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }
}