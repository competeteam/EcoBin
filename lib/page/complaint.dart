import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ComplaintPage extends StatefulWidget {
  const ComplaintPage({super.key});

  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  Position? currentPositionOfUser;
  LatLng? destLocation;
  String? _address;

  getAddressFromLatLng() async {
    try {
      GeoData data = await Geocoder2.getDataFromCoordinates(
          latitude: destLocation!.latitude,
          longitude: destLocation!.longitude,
          googleMapApiKey: "AIzaSyAo8mKGA9Lu3v77seiutfmPAP8ErsiRhiE");
      setState(() {
        _address = data.address;
      });
    } catch (e) {
      print(e);
    }
  }

  getCurrentLiveLocationOfUser() async {
    Position positionOfUser = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPositionOfUser = positionOfUser;

    LatLng positionOfUserInLatLng = LatLng(
        currentPositionOfUser!.latitude, currentPositionOfUser!.longitude);

    destLocation = positionOfUserInLatLng;

    CameraPosition cameraPosition =
        CameraPosition(target: positionOfUserInLatLng, zoom: 15);

    controllerGoogleMap!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  final Completer<GoogleMapController> googleMapCompleterController =
      Completer<GoogleMapController>();

  GoogleMapController? controllerGoogleMap;

  static const CameraPosition googlePlexInitialPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaint'),
      ),
        body: Stack(
      children: [
        
        GoogleMap(
          initialCameraPosition: googlePlexInitialPosition,
          mapType: MapType.normal,
          zoomControlsEnabled: true,
          mapToolbarEnabled: true,
          onCameraMove: (CameraPosition? position) {
            if (destLocation != position!.target) {
              setState(() {
                destLocation = position.target;
                getAddressFromLatLng();
              });
            }
          },
          onTap: (latlng) {
            print(_address);
          },
          onMapCreated: (GoogleMapController mapController) {
            controllerGoogleMap = mapController;

            googleMapCompleterController.complete(controllerGoogleMap);

            getCurrentLiveLocationOfUser();
          },
        ),
        const Align(
          alignment: Alignment.center,
          child: Padding(
              padding: EdgeInsets.only(bottom: 35),
              child: Icon(Icons.pin_drop_outlined)),
        ),
        Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.only(bottom: 35),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Add complaint here"),
                  )),
            ),
        
      ],
    ));
  }
}
