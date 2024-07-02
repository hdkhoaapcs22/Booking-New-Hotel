// import 'dart:async';

// import 'package:booking_new_hotel/global/global_var.dart';
// import 'package:booking_new_hotel/service/location/location.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class ShowHotelsInMap extends StatefulWidget {
//   const ShowHotelsInMap({super.key});

//   @override
//   State<ShowHotelsInMap> createState() => _ShowHotelsInMapState();
// }

// class _ShowHotelsInMapState extends State<ShowHotelsInMap> {
//   late GoogleMapController mapController;

//   static CameraPosition initialLocation = CameraPosition(
//       target: LatLng(GlobalVar.locationOfUser!.latitude,
//           GlobalVar.locationOfUser!.altitude),
//       zoom: 16);
//   List<Marker> markers = [
//     Marker(
//       markerId: MarkerId('curr'),
//       position: LatLng(GlobalVar.locationOfUser!.latitude,
//           GlobalVar.locationOfUser!.altitude),
//       infoWindow: InfoWindow(title: 'Your Location'),
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Hotels in Map'),
//       ),
//       body: GoogleMap(
//         markers: Set<Marker>.of(markers),
//         zoomControlsEnabled: false,
//         initialCameraPosition: initialLocation,
//         mapType: MapType.normal,
//         onMapCreated: (GoogleMapController controller) {
//           mapController = controller;
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           mapController
//               .animateCamera(CameraUpdate.newCameraPosition(initialLocation));
//         },
//         label: const Text("current location"),
//         icon: const Icon(Icons.location_history),
//       ),
//     );
//   }
// }
