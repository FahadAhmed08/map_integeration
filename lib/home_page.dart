import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.871941, 66.988060), // Coordinates for Karachi
    zoom: 14,
  );
  List<Marker> _markers = [];
  final List<Marker> _list = const [
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(24.871941, 66.988060), // Your Current Location
      infoWindow: InfoWindow(title: "My Current Location"),
    ),
    //   Marker(
    //     markerId: MarkerId("2"),
    //     position: LatLng(24.910688, 67.031097), // Nazimabad Town
    //     infoWindow: InfoWindow(title: "Nazimabad Town"),
    //   ),
    //   Marker(
    //     markerId: MarkerId("3"),
    //     position: LatLng(24.893379, 67.082200), // Clifton
    //     infoWindow: InfoWindow(title: "Clifton"),
    //   ),
    //   Marker(
    //     markerId: MarkerId("4"),
    //     position: LatLng(24.860981, 67.001648), // Saddar
    //     infoWindow: InfoWindow(title: "Saddar"),
    //   ),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markers.addAll(_list);
    loadData();
  }

  loadData() {
    getUserCurrentLocation().then((value) async {
      print("My current location");
      print(value.latitude.toString() + "  " + value.longitude.toString());
      _markers.add(Marker(
          markerId: MarkerId("2"),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: InfoWindow(title: "abcd")));
      CameraPosition cameraPosition = CameraPosition(
          target: LatLng(value.latitude, value.longitude), zoom: 14);
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((Value) {})
        .onError((error, StackTrace) {
      print("error" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          // compassEnabled: true,
          // myLocationEnabled: true,
          // mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(_markers),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getUserCurrentLocation().then((value) async {
            print("My current location");
            print(
                value.latitude.toString() + "  " + value.longitude.toString());
            _markers.add(Marker(
                markerId: MarkerId("2"),
                position: LatLng(value.latitude, value.longitude),
                infoWindow: InfoWindow(title: "My current location")));
            CameraPosition cameraPosition = CameraPosition(
                target: LatLng(value.latitude, value.longitude), zoom: 14);
            final GoogleMapController controller = await _controller.future;
            controller
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
            setState(() {});
          });
        },
        child: Icon(Icons.location_disabled_outlined),
      ),
    );
  }
}
