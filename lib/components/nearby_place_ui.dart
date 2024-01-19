import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NearbyPlaceUI extends StatefulWidget
{
  double? lat;
  double? lng;
  String? adrs;
  String? sec;
  Function? func;
  String? types;
  NearbyPlaceUI({super.key, this.lat, this.lng, this.adrs, this.sec, this.func, this.types});

  @override
  State<NearbyPlaceUI> createState() => _NearbyPlaceUIState();
}

class _NearbyPlaceUIState extends State<NearbyPlaceUI> {

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.types == null? (){
        widget.func!(widget.lat, widget.lng, widget.adrs
            );
      }: () {
              widget.func!(widget.lat, widget.lng, widget.adrs, widget.types);
            }
      ,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 5
      ),
      child: SizedBox(
        child: Column(
          children: [

            const SizedBox(height: 10,),

            Row(
              children: [

                const Icon(
                  Icons.share_location,
                  color: Colors.grey,
                ),

                const SizedBox(width: 13,),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Text(
                        widget.adrs!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 3,),

                      Text(
                        widget.sec!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),

            const SizedBox(height: 10,),

          ],
        ),
      ),
    );
  }
}
