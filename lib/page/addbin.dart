import 'dart:async';

import 'package:dinacom_2024/services/trash_bin_service.dart';
import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dinacom_2024/components/common/checbox.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class AddBinPage extends StatefulWidget {
  String? lat;
  String? lng;

  AddBinPage({super.key, this.lat, this.lng});

  @override
  State<AddBinPage> createState() => _AddBinPageState();
}

class _AddBinPageState extends State<AddBinPage> {
  final _formKey = GlobalKey<FormState>();
  String? trashBinLocation;
  final TrashBinService _trashCanService = TrashBinService();

  getAddressFromLatLng() async {
    try {
      GeoData data = await Geocoder2.getDataFromCoordinates(
          latitude: double.parse(widget.lat!),
          longitude: double.parse(widget.lng!),
          googleMapApiKey: "AIzaSyAo8mKGA9Lu3v77seiutfmPAP8ErsiRhiE");
      setState(() {
        trashBinLocation = data.address;
      });
    } catch (e) {
      print(e);
    }
  }

  String trashBinPictureImagePath = 'assets/images/google_logo.svg';
  String fillCount = '999';

  bool isOrganicChecked = false;
  bool isPaperChecked = false;
  bool isChemicalChecked = false;
  bool isPlasticChecked = false;
  bool isGlassChecked = false;
  bool isMetalChecked = false;
  bool isEWasteChecked = false;
  bool isError = false;
  bool isFull = false;

  @override
  Widget build(BuildContext context) {
    getAddressFromLatLng();
    return Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 30.0),
                child: TextButton(
                  onPressed: () async {
                    print(_formKey.currentState!.validate());

                    if (!isOrganicChecked &&
                        !isPaperChecked &&
                        !isChemicalChecked &&
                        !isPlasticChecked &&
                        !isGlassChecked &&
                        !isMetalChecked &&
                        !isEWasteChecked) {
                      setState(() => isError = true);
                    } else {
                      setState(() => isError = false);

                      if (_formKey.currentState!.validate()) {
                        await _trashCanService.addTrashBin(createdAt: DateTime.now(), uid: "test", tid: widget.lat!+widget.lng!, createdLocation: trashBinLocation!, xCoord: widget.lat!,
                            yCoord: widget.lng!, types: List.empty());
                      }
                    }
                  },
                  child: const Text('Done',
                      style:
                          TextStyle(color: Color(0xFF75BC7B), fontSize: 16.0)),
                ),
              ),
            ],
            backgroundColor: const Color(0xFF222222),
            title: const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text('Trash Bin',
                  style: TextStyle(color: Colors.white, fontSize: 20.0)),
            ),
            surfaceTintColor: Colors.transparent,
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          backgroundColor: const Color(0xFF222222),
          body: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Center(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: 150.0,
                            height: 150.0,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                )
                              ],
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(trashBinPictureImagePath,
                                height: 150.0, width: 150.0, fit: BoxFit.cover),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: ClipOval(
                                  child: Container(
                                width: 40,
                                height: 40,
                                color: Colors.white,
                                child: IconButton(
                                  icon: const Icon(Icons.edit),
                                  color: const Color(0xFF2897ED),
                                  onPressed: () {},
                                ),
                              )))
                        ],
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    const Text('Location',
                        style: TextStyle(color: Colors.white, fontSize: 16.0)),
                    Text(trashBinLocation!,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 16.0)),
                    const SizedBox(height: 15.0),
                    const Text('Type',
                        style: TextStyle(color: Colors.white, fontSize: 16.0)),
                    const SizedBox(height: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        CommonCheckbox(
                          componentValue: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    'assets/images/google_logo.svg',
                                    height: 16.0,
                                    width: 16.0),
                                const SizedBox(width: 5.0),
                                const Text('Organic',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0)),
                              ]),
                          isChecked: isOrganicChecked,
                          isError: isError,
                          setStateFunction: () => setState(
                              () => isOrganicChecked = !isOrganicChecked),
                        ),
                        const SizedBox(height: 10.0),
                        CommonCheckbox(
                          componentValue: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    'assets/images/google_logo.svg',
                                    height: 16.0,
                                    width: 16.0),
                                const SizedBox(width: 5.0),
                                const Text('Paper',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0)),
                              ]),
                          isChecked: isPaperChecked,
                          isError: isError,
                          setStateFunction: () =>
                              setState(() => isPaperChecked = !isPaperChecked),
                        ),
                        const SizedBox(height: 10.0),
                        CommonCheckbox(
                          componentValue: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    'assets/images/google_logo.svg',
                                    height: 16.0,
                                    width: 16.0),
                                const SizedBox(width: 5.0),
                                const Text('Chemical',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0)),
                              ]),
                          isChecked: isChemicalChecked,
                          isError: isError,
                          setStateFunction: () => setState(
                              () => isChemicalChecked = !isChemicalChecked),
                        ),
                        const SizedBox(height: 10.0),
                        CommonCheckbox(
                          componentValue: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    'assets/images/google_logo.svg',
                                    height: 16.0,
                                    width: 16.0),
                                const SizedBox(width: 5.0),
                                const Text('Plastic',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0)),
                              ]),
                          isChecked: isPlasticChecked,
                          isError: isError,
                          setStateFunction: () => setState(
                              () => isPlasticChecked = !isPlasticChecked),
                        ),
                        const SizedBox(height: 10.0),
                        CommonCheckbox(
                          componentValue: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    'assets/images/google_logo.svg',
                                    height: 16.0,
                                    width: 16.0),
                                const SizedBox(width: 5.0),
                                const Text('Glass',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0)),
                              ]),
                          isChecked: isGlassChecked,
                          isError: isError,
                          setStateFunction: () =>
                              setState(() => isGlassChecked = !isGlassChecked),
                        ),
                        const SizedBox(height: 10.0),
                        CommonCheckbox(
                          componentValue: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    'assets/images/google_logo.svg',
                                    height: 16.0,
                                    width: 16.0),
                                const SizedBox(width: 5.0),
                                const Text('Metal',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0)),
                              ]),
                          isChecked: isMetalChecked,
                          isError: isError,
                          setStateFunction: () =>
                              setState(() => isMetalChecked = !isMetalChecked),
                        ),
                        const SizedBox(height: 10.0),
                        CommonCheckbox(
                          componentValue: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                    'assets/images/google_logo.svg',
                                    height: 16.0,
                                    width: 16.0),
                                const SizedBox(width: 5.0),
                                const Text('E Waste',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0)),
                              ]),
                          isChecked: isEWasteChecked,
                          isError: isError,
                          setStateFunction: () => setState(
                              () => isEWasteChecked = !isEWasteChecked),
                        ),
                      ],
                    ),
                    isError
                        ? const SizedBox(height: 5.0)
                        : const SizedBox(height: 0.0),
                    Text(isError ? 'One trash bin type must be selected' : '',
                        style: TextStyle(
                            color: Colors.red.shade900, fontSize: 12.0)),
                    isFull
                        ? Container(
                            height: 40.0,
                            decoration: const BoxDecoration(
                              color: Color(0xFF75BC7B),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            child: InkWell(
                                onTap: () {
                                  setState(() => isFull = false);
                                },
                                child: const Center(
                                    child: Text('Empty Trash Bin',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0)))),
                          )
                        : const SizedBox(height: 5.0),
                  ])),
        ));
  }
}
