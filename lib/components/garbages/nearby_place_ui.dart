import 'package:flutter/material.dart';

class NearbyPlaceUI extends StatefulWidget {
  final double? lat;
  final double? lng;
  final String? adrs;
  final String? sec;
  final Function? func;
  final String? types;
  final String? tid;

  const NearbyPlaceUI(
      {super.key,
      this.lat,
      this.lng,
      this.adrs,
      this.sec,
      this.func,
      this.types,
      this.tid});

  @override
  State<NearbyPlaceUI> createState() => _NearbyPlaceUIState();
}

class _NearbyPlaceUIState extends State<NearbyPlaceUI> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.types == null
          ? () {
              widget.func!(widget.lat, widget.lng, widget.adrs);
            }
          : () {
              widget.func!(widget.lat, widget.lng, widget.adrs, widget.types,
                  widget.tid);
            },
      style: ElevatedButton.styleFrom(
          surfaceTintColor: const Color.fromARGB(0, 255, 255, 255),
          backgroundColor: const Color.fromARGB(248, 26, 23, 23),
          shadowColor: const Color.fromARGB(0, 255, 255, 255),
          elevation: 5),
      child: SizedBox(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Icon(
                  Icons.share_location,
                  color: Color(0xFF5A8A62),
                ),
                const SizedBox(
                  width: 13,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.adrs!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 220, 229, 222),
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        widget.sec!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 220, 229, 222),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
