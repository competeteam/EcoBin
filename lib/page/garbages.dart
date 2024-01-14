import 'dart:async';
import 'dart:convert';

import 'package:dinacom_2024/components/prediction_place_ui.dart';
import 'package:dinacom_2024/models/prediction_model.dart';
import 'package:dinacom_2024/services/trash_bin_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Garbages extends StatefulWidget {
  const Garbages({super.key});

  @override
  State<Garbages> createState() => _GarbagesState();
}

class _GarbagesState extends State<Garbages> {
  final TrashBinService _trashBinService = TrashBinService();
  TextEditingController destinationTextEditingController =
      TextEditingController();
  List<PredictionModel> dropOffPredictionsPlacesList = [];
  String map_api_key = "AIzaSyAo8mKGA9Lu3v77seiutfmPAP8ErsiRhiE";

  Position? currentPositionOfUser;
  LatLng? destLocation;
  double? lat;
  double? lng;
  String? _address = "225 Bill Graham Pkwy, Mountain View, CA 94043, USA";

  ///Place Details - Places API
  fetchClickedPlaceDetails(String placeID) async {
    // showDialog(
    //   barrierDismissible: false,
    //   context: context,
    //   builder: (BuildContext context) =>
    //       LoadingDialog(messageText: "Getting details..."),
    // );

    String urlPlaceDetailsAPI =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeID&key=$map_api_key";

    var responseFromPlaceDetailsAPI =
        await sendRequestToAPI(urlPlaceDetailsAPI);

    if (responseFromPlaceDetailsAPI == "error") {
      return;
    }

    if (responseFromPlaceDetailsAPI["status"] == "OK") {
      _address = responseFromPlaceDetailsAPI["result"]["name"];
      lat =
          responseFromPlaceDetailsAPI["result"]["geometry"]["location"]["lat"];
      lng =
          responseFromPlaceDetailsAPI["result"]["geometry"]["location"]["lng"];
      destLocation = LatLng(lat!, lng!);
      CameraPosition cameraPosition =
          CameraPosition(target: destLocation!, zoom: 15);

      controllerGoogleMap!
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    }
  }

  Future<List<Marker>> getMarkers() async {
    final cans = await _trashBinService.getAllTrashCan();
    return List<Marker>.from(cans.map((e) => Marker(
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          markerId: MarkerId(e!.xCoord!),
          position: LatLng(double.parse(e.xCoord!), double.parse(e.yCoord!)),
        )));
  }

  void updateMarkers() async {
    final ok = await getMarkers();
    setState(() {
      for (var marker in ok) {
        markers.add(marker);
      }
    });
  }

  sendRequestToAPI(String apiUrl) async {
    http.Response responseFromAPI = await http.get(Uri.parse(apiUrl));

    try {
      if (responseFromAPI.statusCode == 200) {
        String dataFromApi = responseFromAPI.body;
        var dataDecoded = jsonDecode(dataFromApi);
        return dataDecoded;
      } else {
        return "error";
      }
    } catch (errorMsg) {
      return "error";
    }
  }

  searchLocation(String locationName) async {
    if (locationName == "") {
      dropOffPredictionsPlacesList = List.empty();
    }
    if (locationName.length > 1) {
      String apiPlacesUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$locationName&key=$map_api_key&components=country:id";

      var responseFromPlacesAPI = await sendRequestToAPI(apiPlacesUrl);

      if (responseFromPlacesAPI == "error") {
        return;
      }

      if (responseFromPlacesAPI["status"] == "OK") {
        var predictionResultInJson = responseFromPlacesAPI["predictions"];
        var predictionsList = (predictionResultInJson as List)
            .map((eachPlacePrediction) =>
                PredictionModel.fromJson(eachPlacePrediction))
            .toList();

        setState(() {
          dropOffPredictionsPlacesList = predictionsList;
        });
      }
    }
  }

  getAddressFromLatLng() async {
    try {
      GeoData data = await Geocoder2.getDataFromCoordinates(
          latitude: destLocation!.latitude,
          longitude: destLocation!.longitude,
          googleMapApiKey: map_api_key);
      setState(() {
        _address = data.address;
      });
      _trashBinService.getAllTrashCan();
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

  Set<Marker> markers = Set();
  var mymarkers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: SpeedDial(
          childrenButtonSize: const Size(60, 60),
          spacing: 3,
          spaceBetweenChildren: 5,
          backgroundColor: const Color.fromARGB(255, 34, 34, 34),
          animatedIcon: AnimatedIcons.menu_close,
          foregroundColor: Colors.white,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.add),
              shape: CircleBorder(),
              onTap: () {
                context.goNamed('addbin', queryParameters: {
                  'lat': lat.toString(),
                  'lng': lng.toString(),
                  'adrs': _address
                });
              },
              label: 'Add bin here',
            ),
            SpeedDialChild(
              child: const Icon(Icons.message),
              shape: CircleBorder(),
              label: 'Complaint',
              onTap: () {
                context
                    .goNamed('complaint', pathParameters: {'adrs': _address!});
              },
            ),
          ],
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
                    lat = destLocation!.latitude;
                    lng = destLocation!.longitude;
                    getAddressFromLatLng();
                  });
                }
              },
              markers: markers,
              onTap: (latlng) {
                updateMarkers();
              },
              onMapCreated: (GoogleMapController mapController) {
                controllerGoogleMap = mapController;

                googleMapCompleterController.complete(controllerGoogleMap);

                getCurrentLiveLocationOfUser();
                updateMarkers();
              },
            ),
            const Align(
              alignment: Alignment.center,
              child: Padding(
                  padding: EdgeInsets.only(bottom: 35),
                  child: Icon(Icons.pin_drop_outlined)),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 75, right: 20),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 18,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(color: Colors.black, blurRadius: 3)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: TextField(
                            controller: destinationTextEditingController,
                            onEditingComplete: () {
                              searchLocation("");
                            },
                            onTapOutside: (e) {
                              searchLocation("");
                            },
                            onChanged: (inputText) {
                              searchLocation(inputText);
                            },
                            decoration: const InputDecoration(
                                hintText: "Location search",
                                fillColor: Colors.white12,
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 11, top: 9, bottom: 9)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            (dropOffPredictionsPlacesList.isNotEmpty)
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListView.separated(
                      padding: const EdgeInsets.only(top: 130),
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.transparent,
                          elevation: 0,
                          child: PredictionPlaceUI(
                            predictedPlaceData:
                                dropOffPredictionsPlacesList[index],
                            func: fetchClickedPlaceDetails,
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 2,
                      ),
                      itemCount: dropOffPredictionsPlacesList.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                    ),
                  )
                : Container(),
          ],
        ));
  }
}
