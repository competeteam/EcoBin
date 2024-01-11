import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddBinPage extends StatefulWidget {
  String? adrs;
  AddBinPage({super.key, this.adrs});

  @override
  State<AddBinPage> createState() => _AddBinPageState();
}

class _AddBinPageState extends State<AddBinPage> {
  Position? currentPositionOfUser;
  LatLng? destLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222222),
      body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(30.0, 200.0, 30.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Text(
                  widget.adrs!,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 18),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      labelText: 'Bin Name',
                      labelStyle: TextStyle(
                        color: Color(0xFF646464),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      labelText: 'Description',
                      labelStyle: TextStyle(
                        color: Color(0xFF646464),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 9),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size.fromHeight(40.0),
                    side: const BorderSide(width: 1.0, color: Colors.white),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Add Bin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
