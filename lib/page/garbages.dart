import 'dart:async';
import 'dart:convert';
import 'dart:math' show cos, sqrt, asin;

import 'package:dinacom_2024/components/common/checbox.dart';
import 'package:dinacom_2024/components/nearby_place_ui.dart';
import 'package:dinacom_2024/components/prediction_place_ui.dart';
import 'package:dinacom_2024/models/address_model.dart';
import 'package:dinacom_2024/models/prediction_model.dart';
import 'package:dinacom_2024/models/trash_bin_model.dart';
import 'package:dinacom_2024/models/user_model.dart';
import 'package:dinacom_2024/services/map_launcher.dart';
import 'package:dinacom_2024/services/trash_bin_service.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
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

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class _GarbagesState extends State<Garbages> {
  final TrashBinService _trashBinService = TrashBinService();

  bool isFindNearby = true;
  TextEditingController destinationTextEditingController =
      TextEditingController();
  // List<PredictionModel> dropOffPredictionsPlacesList = []; google maps punya
  List<AddressModel> dropOffPredictionsPlacesList = [];
  List<AddressModel> nearbyBinsList = [];
  String map_api_key = "AIzaSyAo8mKGA9Lu3v77seiutfmPAP8ErsiRhiE";
  String autocomplete_api_key = "6340be1c7c4746ce923eb55a79fe87bd";

  bool isOrganicChecked = true;
  bool isPaperChecked = true;
  bool isChemicalChecked = true;
  bool isPlasticChecked = true;
  bool isGlassChecked = true;
  bool isMetalChecked = true;
  bool isEWasteChecked = true;
  bool isError = true;
  bool isFull = true;
  bool isFiltering = true;

  Position? currentPositionOfUser;
  LatLng? destLocation;
  double lat = 37.42796133580664;
  double lng = -122.085749655962;
  String? _address = "225 Bill Graham Pkwy, Mountain View, CA 94043, USA";

  goToBin(
      double latt, double lngg, String adrs, String types, String tid) async {
    _address = adrs;
    lat = latt;
    lng = lngg;
    destLocation = LatLng(lat!, lng!);
    CameraPosition cameraPosition =
        CameraPosition(target: destLocation!, zoom: 15);
    controllerGoogleMap!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    nearbyBinsList = [];
    isFindNearby = true;

    _displayBottomSheet(context, adrs, '', latt, lngg, types, tid);
  }

  // fetchClickedPlaceDetails(String placeID) async {
  //   String urlPlaceDetailsAPI =
  //       "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeID&key=$map_api_key";

  //   var responseFromPlaceDetailsAPI =
  //       await sendRequestToAPI(urlPlaceDetailsAPI);

  //   if (responseFromPlaceDetailsAPI == "error") {
  //     return;
  //   }

  //   if (responseFromPlaceDetailsAPI["status"] == "OK") {
  //     _address = responseFromPlaceDetailsAPI["result"]["name"];
  //     lat =
  //         responseFromPlaceDetailsAPI["result"]["geometry"]["location"]["lat"];
  //     lng =
  //         responseFromPlaceDetailsAPI["result"]["geometry"]["location"]["lng"];
  //     destLocation = LatLng(lat!, lng!);
  //     CameraPosition cameraPosition =
  //         CameraPosition(target: destLocation!, zoom: 15);

  //     controllerGoogleMap!
  //         .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  //   }
  // } google maps punya

  fetchClickedPlaceDetails(double latt, double lngg, String adrs) async {
    _address = adrs;
    lat = latt;
    lng = lngg;
    destLocation = LatLng(lat!, lng!);
    CameraPosition cameraPosition =
        CameraPosition(target: destLocation!, zoom: 15);
    controllerGoogleMap!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    nearbyBinsList = [];
    dropOffPredictionsPlacesList = [];
    isFindNearby = true;
  }

  Future<List<Marker>> getMarkers() async {
    final cans = await _trashBinService.getAllTrashCan();
    print(cans.first!.xCoord);
    return List<Marker>.from(
      cans
          .where((element) =>
              (isChemicalChecked &&
                  element!.types.contains(TrashBinType.chemical)) ||
              (isEWasteChecked &&
                  element!.types.contains(TrashBinType.eWaste)) ||
              (isGlassChecked && element!.types.contains(TrashBinType.glass)) ||
              (isMetalChecked && element!.types.contains(TrashBinType.metal)) ||
              (isOrganicChecked &&
                  element!.types.contains(TrashBinType.organic)) ||
              (isPaperChecked && element!.types.contains(TrashBinType.paper)) ||
              (isPlasticChecked &&
                  element!.types.contains(TrashBinType.plastic))
                  )
          .map(
            (e) => Marker(
              consumeTapEvents: true,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed),
              markerId: MarkerId('${e!.xCoord}'),
              onTap: () {
                _displayBottomSheet(
                    context,
                    e.createdLocation,
                    e.imagePath,
                    double.parse('${e.xCoord!}'),
                    double.parse('${e.yCoord!}'),
                    e.types
                        .join(', ')
                        .toString()
                        .replaceAll("TrashBinType.", "")
                        .capitalize(),
                    e.tid);
              },
              position: LatLng(
                  double.parse('${e.xCoord!}'), double.parse('${e.yCoord!}')),
            ),
          ),
    );
  }

  void updateMarkers() async {
    final ok = await getMarkers();
    markers.clear();
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

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  searchNearby() async {
    final cans = await _trashBinService.getAllTrashCan();
    List<AddressModel> dists = List<AddressModel>.from(
      cans.where((element) => 
      (isChemicalChecked &&
                  element!.types.contains(TrashBinType.chemical)) ||
              (isEWasteChecked &&
                  element!.types.contains(TrashBinType.eWaste)) ||
              (isGlassChecked && element!.types.contains(TrashBinType.glass)) ||
              (isMetalChecked && element!.types.contains(TrashBinType.metal)) ||
              (isOrganicChecked &&
                  element!.types.contains(TrashBinType.organic)) ||
              (isPaperChecked && element!.types.contains(TrashBinType.paper)) ||
              (isPlasticChecked &&
                  element!.types.contains(TrashBinType.plastic))
      ).map(
        (e) => AddressModel(
            humanReadableAddress: e!.createdLocation,
            latitudePosition: double.parse(e.xCoord),
            longitudePosition: double.parse(e.yCoord),
            dist: calculateDistance(
              lat,
              lng,
              double.parse(e.xCoord),
              double.parse(e.yCoord),
            ),
            types: e.types
                .join(", ")
                .toString()
                .replaceAll("TrashBinType.", "")
                .capitalize(),
            tid: e.tid),
      ),
    );
    dists.sort((a, b) => a.dist!.compareTo(b.dist!));
    dropOffPredictionsPlacesList = [];
    nearbyBinsList = dists.take(3).toList();
    isFiltering = true;
    setState(() {});
  }

  searchLocation(String locationName) async {
    // nearbyBinsList = [];
    // isFindNearby = true;
    // isFiltering = true;

    if (locationName == "") {
      dropOffPredictionsPlacesList = List.empty();
    }
    if (locationName.length > 1) {
      String apiPlacesUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$locationName&key=$map_api_key&components=country:id";
      String apiPlacesUrl2 =
          "https://api.geoapify.com/v1/geocode/autocomplete?text=$locationName&apiKey=$autocomplete_api_key";

      var responseFromPlacesAPI = await sendRequestToAPI(apiPlacesUrl2);
      print(responseFromPlacesAPI);

      if (responseFromPlacesAPI == "error" ||
          responseFromPlacesAPI["status"] == "REQUEST_DENIED") {
        return;
      }

      if (responseFromPlacesAPI["status"] == "OK" ||
          responseFromPlacesAPI["type"] == "FeatureCollection") {
        print(responseFromPlacesAPI["features"].length);
        print("not err somehowasdddddddddddddddddddd");
        print(responseFromPlacesAPI["features"][0]);
        var predictionsList = (responseFromPlacesAPI["features"] as List)
            .map((e) => AddressModel.fromJson(e))
            .toList();

        // google maps api punya
        // var predictionResultInJson = responseFromPlacesAPI["predictions"];
        // var predictionsList = (predictionResultInJson as List)
        //     .map((eachPlacePrediction) =>
        //         PredictionModel.fromJson(eachPlacePrediction))
        //     .toList();

        setState(() {
          dropOffPredictionsPlacesList = predictionsList;
        });
      }
    }
  }

  getAddressFromLatLng() async {
    try {
      var data = await placemarkFromCoordinates(
          destLocation!.latitude, destLocation!.longitude);

      setState(() {
        _address = data.first.street! +
            ", " +
            data.first.subLocality! +
            ", " +
            data.first.locality! +
            ", " +
            data.first.subAdministrativeArea!;
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
    lat = destLocation!.latitude;
    lng = destLocation!.longitude;

    CameraPosition cameraPosition =
        CameraPosition(target: positionOfUserInLatLng, zoom: 15);

    controllerGoogleMap!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  Future _displayBottomSheet(BuildContext context, String adrs, String link,
      double lat, double lng, String secondary, String tid) {
    final user = Provider.of<UserModel?>(context, listen: false);
    String default_trash_bin =
        'https://firebasestorage.googleapis.com/v0/b/ecobin-9f4b9.appspot.com/o/images%2F1705400888863-images.jpg?alt=media&token=26b725b6-a238-4e1b-a732-bd61caf22bce';
    return showModalBottomSheet(
      backgroundColor: Color.fromARGB(248, 35, 33, 33),
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => Container(
        margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
        height: 350,
        child: Center(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              adrs,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 231, 227, 227),
                                fontSize: 21,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                            child: Text(
                              secondary,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 238, 233, 233),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w300,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.28,
                          maxHeight: MediaQuery.of(context).size.width * 0.28,
                        ),
                        child: Image(
                            image: NetworkImage(
                                link == '' ? default_trash_bin : link),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ],
                ),
              ),

              // ListTile(
              //   visualDensity: VisualDensity(vertical: 4),
              //   title: Text(
              //     adrs,
              //     maxLines: 4,
              //     overflow: TextOverflow.ellipsis,
              //     style: const TextStyle(
              //       color: Colors.black,
              //       fontSize: 23,
              //       fontFamily: 'Inter',
              //       fontWeight: FontWeight.w500,
              //       height: 0,
              //     ),
              //   ),
              //   subtitle: Text(
              //     secondary,
              //     maxLines: 4,
              //     overflow: TextOverflow.ellipsis,
              //     style: const TextStyle(
              //       color: Colors.black,
              //       fontSize: 16,
              //       fontFamily: 'Inter',
              //       fontWeight: FontWeight.w300,
              //       height: 0,
              //     ),
              //   ),
              //   trailing: SizedBox(
              //     height: 120,
              //     width: 120,
              //     child: Image(
              //       fit: BoxFit.fill,
              //       image: NetworkImage(link == '' ? default_trash_bin : link),
              //       errorBuilder: (context, error, stackTrace) =>
              //           const Placeholder(),
              //     ),
              //   ),
              //   contentPadding: EdgeInsets.zero,
              //   minVerticalPadding: 0,
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(190, 40),
                    side: const BorderSide(
                        width: 1.0, color: Color.fromARGB(255, 236, 230, 230)),
                  ),
                  onPressed: () async {
                    MapUtils.openMap(lat, lng);
                  },
                  child: const Text(
                    'Open in Maps',
                    style: TextStyle(
                      color: Color.fromARGB(255, 237, 231, 231),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(190, 40),
                    side: const BorderSide(
                        width: 1.0, color: Color.fromARGB(255, 233, 226, 226)),
                  ),
                  onPressed: () async {
                    context.pushNamed(
                      'addcomplaint',
                      queryParameters: {
                        'lat': lat.toString(),
                        'lng': lng.toString(),
                        'adrs': _address,
                        'tid': tid,
                        'uid': user!.uid,
                      },
                    );
                  },
                  child: const Text(
                    'Add complaint',
                    style: TextStyle(
                      color: Color.fromARGB(255, 239, 234, 234),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(190, 40),
                    side: const BorderSide(
                        width: 1.0, color: Color.fromARGB(255, 238, 234, 234)),
                  ),
                  onPressed: () async {
                    context.goNamed(
                      'showcomplaints',
                      queryParameters: {
                        'lat': lat.toString(),
                        'lng': lng.toString(),
                        'adrs': _address,
                        'tid': tid,
                        'uid': user!.uid,
                      },
                    );
                  },
                  child: const Text(
                    'Show complaints',
                    style: TextStyle(
                      color: Color.fromARGB(255, 241, 236, 236),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
    final user = Provider.of<UserModel?>(context);

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
                context.pushNamed(
                  'addbin',
                  queryParameters: {
                    'lat': lat.toString(),
                    'lng': lng.toString(),
                    'adrs': _address,
                    'uid': user!.uid
                  },
                ).whenComplete(() {
                  updateMarkers();
                  print("here lol it does get called");
                });
              },
              label: 'Add bin here',
            ),
          ],
        ),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: googlePlexInitialPosition,
              mapType: MapType.normal,
              zoomControlsEnabled: true,
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.1),
              mapToolbarEnabled: true,
              onCameraMove: (CameraPosition? position) {
                EasyDebounce.debounce(
                    'refresh location', Duration(milliseconds: 500), () {
                  if (destLocation != position!.target) {
                    setState(() {
                      destLocation = position.target;
                      lat = destLocation!.latitude;
                      lng = destLocation!.longitude;
                      getAddressFromLatLng();
                    });
                  }
                });
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
                  padding: EdgeInsets.only(bottom: 95),
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
                          color: Color.fromARGB(248, 54, 51, 51),
                          borderRadius: BorderRadius.circular(50),
                          // boxShadow: [
                          //   BoxShadow(color: Colors.black, blurRadius: 3)
                          // ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            onTap: () {
                              isFiltering = true;
                              isFindNearby = true;
                              nearbyBinsList = [];
                            },
                            controller: destinationTextEditingController,
                            onEditingComplete: () {
                              searchLocation("");
                            },
                            onTapOutside: (e) {
                              searchLocation("");
                            },
                            onChanged: (inputText) {
                              isFiltering = true;
                              EasyDebounce.debounce('searchdebounce',
                                  const Duration(milliseconds: 500), () {
                                searchLocation(inputText);
                              });
                            },
                            decoration: const InputDecoration(
                                hintText: "Location search",
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 199, 192, 192)),
                                // fillColor: Color.fromARGB(31, 255, 255, 255),
                                // filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 15, top: 9, bottom: 9)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 129, left: 20),
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            print(isFindNearby);
                            if (!isFindNearby)
                              nearbyBinsList = [];
                            else
                              searchNearby();
                            isFindNearby = !isFindNearby;
                            print(isFindNearby);
                          });
                        },
                        style: OutlinedButton.styleFrom(
                            fixedSize: Size(170, 40),
                            backgroundColor: isFindNearby
                                ? const Color.fromARGB(248, 76, 73, 73)
                                : const Color(0xFF5A8A62),
                            shadowColor: Colors.black,
                            elevation: 5),
                        child: Text(
                          'Show nearby bins',
                          style: TextStyle(
                              color: isFindNearby
                                  ? const Color.fromARGB(255, 220, 229, 222)
                                  : const Color.fromARGB(255, 220, 229, 222)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 129, left: 20),
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            if (isFiltering) nearbyBinsList = [];
                            isFindNearby = true;
                            isFiltering = !isFiltering;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                            fixedSize: Size(160, 40),
                            backgroundColor: isFiltering
                                ? const Color.fromARGB(248, 76, 73, 73)
                                : const Color(0xFF5A8A62),
                            shadowColor: Colors.black,
                            elevation: 5),
                        child: Text(
                          'Filter bin type',
                          style: TextStyle(
                              color: isFiltering
                                  ? const Color.fromARGB(255, 220, 229, 222)
                                  : const Color.fromARGB(255, 220, 229, 222)),
                        ),
                      ),
                    ),
                  ],
                )),
            isFiltering
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(
                            left: 30.0, right: 30, top: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            CommonCheckbox(
                              componentValue: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/logos/type_trash_bin_organic.svg',
                                        height: 16.0,
                                        width: 16.0),
                                    const SizedBox(width: 5.0),
                                    const Text('Organic',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0)),
                                  ]),
                              isChecked: isOrganicChecked,
                              isError: isError,
                              setStateFunction: () => setState(
                                () {
                                  isOrganicChecked = !isOrganicChecked;
                                  updateMarkers();
                                },
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            CommonCheckbox(
                              componentValue: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/logos/type_trash_bin_paper.svg',
                                        height: 16.0,
                                        width: 16.0),
                                    const SizedBox(width: 5.0),
                                    const Text('Paper',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0)),
                                  ]),
                              isChecked: isPaperChecked,
                              isError: isError,
                              setStateFunction: () => setState(() {
                                isPaperChecked = !isPaperChecked;
                                updateMarkers();
                              }),
                            ),
                            const SizedBox(height: 10.0),
                            CommonCheckbox(
                              componentValue: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/logos/type_trash_bin_chemical.svg',
                                        height: 16.0,
                                        width: 16.0),
                                    const SizedBox(width: 5.0),
                                    const Text('Chemical',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0)),
                                  ]),
                              isChecked: isChemicalChecked,
                              isError: isError,
                              setStateFunction: () => setState(() {
                                isChemicalChecked = !isChemicalChecked;
                                updateMarkers();
                              }),
                            ),
                            const SizedBox(height: 10.0),
                            CommonCheckbox(
                              componentValue: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/logos/type_trash_bin_plastic.svg',
                                        height: 16.0,
                                        width: 16.0),
                                    const SizedBox(width: 5.0),
                                    const Text('Plastic',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0)),
                                  ]),
                              isChecked: isPlasticChecked,
                              isError: isError,
                              setStateFunction: () => setState(() {
                                isPlasticChecked = !isPlasticChecked;
                                updateMarkers();
                              }),
                            ),
                            const SizedBox(height: 10.0),
                            CommonCheckbox(
                              componentValue: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/logos/type_trash_bin_glass.svg',
                                        height: 16.0,
                                        width: 16.0),
                                    const SizedBox(width: 5.0),
                                    const Text('Glass',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0)),
                                  ]),
                              isChecked: isGlassChecked,
                              isError: isError,
                              setStateFunction: () => setState(() {
                                isGlassChecked = !isGlassChecked;
                                updateMarkers();
                              }),
                            ),
                            const SizedBox(height: 10.0),
                            CommonCheckbox(
                              componentValue: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/logos/type_trash_bin_metal.svg',
                                        height: 16.0,
                                        width: 16.0),
                                    const SizedBox(width: 5.0),
                                    const Text('Metal',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0)),
                                  ]),
                              isChecked: isMetalChecked,
                              isError: isError,
                              setStateFunction: () => setState(() {
                                isMetalChecked = !isMetalChecked;
                                updateMarkers();
                              }),
                            ),
                            const SizedBox(height: 10.0),
                            CommonCheckbox(
                              componentValue: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/logos/type_trash_bin_ewaste.svg',
                                        height: 16.0,
                                        width: 16.0),
                                    const SizedBox(width: 5.0),
                                    const Text('E Waste',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0)),
                                  ]),
                              isChecked: isEWasteChecked,
                              isError: isError,
                              setStateFunction: () => setState(() {
                                isEWasteChecked = !isEWasteChecked;
                                updateMarkers();
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            (dropOffPredictionsPlacesList.isNotEmpty)
                ? Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 179),
                    child: ListView.separated(
                      padding: const EdgeInsets.only(top: 0),
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.transparent,
                          elevation: 0,
                          child: NearbyPlaceUI(
                              lat: dropOffPredictionsPlacesList[index]
                                  .latitudePosition,
                              lng: dropOffPredictionsPlacesList[index]
                                  .longitudePosition,
                              adrs: dropOffPredictionsPlacesList[index]
                                  .humanReadableAddress,
                              sec: dropOffPredictionsPlacesList[index]
                                  .secondary_text,
                              func: fetchClickedPlaceDetails),
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
            (nearbyBinsList.isNotEmpty)
                ? Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 179),
                    child: ListView.separated(
                      padding: const EdgeInsets.only(top: 0),
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.transparent,
                          elevation: 0,
                          child: NearbyPlaceUI(
                              lat: nearbyBinsList[index].latitudePosition,
                              lng: nearbyBinsList[index].longitudePosition,
                              adrs: nearbyBinsList[index].humanReadableAddress,
                              sec: nearbyBinsList[index]
                                      .dist!
                                      .toStringAsFixed(3) +
                                  ' km from current location. ',
                              types: nearbyBinsList[index].types,
                              tid: nearbyBinsList[index].tid,
                              func: goToBin),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 2,
                      ),
                      itemCount: nearbyBinsList.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                    ),
                  )
                : Container(),
          ],
        ));
  }
}
