import 'dart:convert';

import 'package:dinacom_2024/models/prediction_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PredictionPlaceUI extends StatefulWidget
{
  PredictionModel? predictedPlaceData;
  Function? func;
  PredictionPlaceUI({super.key, this.predictedPlaceData, this.func});

  @override
  State<PredictionPlaceUI> createState() => _PredictionPlaceUIState();
}

class _PredictionPlaceUIState extends State<PredictionPlaceUI> {
  String map_api_key = "AIzaSyAo8mKGA9Lu3v77seiutfmPAP8ErsiRhiE";

  

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        widget.func!(
            widget.predictedPlaceData!.place_id.toString());
      },
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
                        widget.predictedPlaceData!.main_text.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 3,),

                      Text(
                        widget.predictedPlaceData!.secondary_text.toString(),
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
