import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ComplaintPage extends StatefulWidget {
  String? adrs;
  ComplaintPage({super.key, this.adrs});

  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  Position? currentPositionOfUser;
  LatLng? destLocation;
  String title = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222222),
      body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(30.0, 200.0, 30.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Center(
                child: Text(
                  'Add complaint',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              TextFormField(
                validator: (val) {
                  if (val!.trim().isEmpty) {
                    return 'Title cannot be empty';
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() => title = val);
                },
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(12.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    color: Color(0xFF646464),
                    fontSize: 12,
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                validator: (val) {
                  if (val!.trim().isEmpty) {
                    return 'Password cannot be empty';
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() => password = val);
                },
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(12.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Color(0xFF646464),
                    fontSize: 12,
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                obscureText: true,
              ),
              OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          fixedSize: const Size.fromHeight(40.0),
                          side:
                              const BorderSide(width: 1.0, color: Colors.white),
                        ),
                        onPressed: () async {
                        },
                        child: const Text(
                  'Add complaint',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),

            ],
          )),
    );
  }
}
