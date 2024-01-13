import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class TrashBinCard extends StatelessWidget {
  final String trashBinImagePath;
  final String trashLogoPath;
  final String trashCreatedLocation;
  final String trashFillCount;
  final String trashCreatedTime;
  final bool isFull;

  const TrashBinCard({
    super.key,
    required this.trashBinImagePath,
    required this.trashLogoPath,
    required this.trashCreatedLocation,
    required this.trashFillCount,
    required this.trashCreatedTime,
    required this.isFull,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: const BoxDecoration(
        color: Color(0xFF3B3B3B),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: InkWell(
        onTap: () async {
          GoRouter.of(context).push('/trash-bin/1');
        },
        child: Row(
          children: <Widget>[
            Container(
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0)),
                  image: DecorationImage(
                    image: NetworkImage(trashBinImagePath),
                    fit: BoxFit.fill,
                  )),
            ),
            Expanded(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(trashLogoPath,
                                  height: 16.0, width: 16.0),
                              const SizedBox(width: 5.0),
                              Text(trashCreatedLocation,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16.0)),
                            ]),
                        const SizedBox(height: 5.0),
                        Text('Filled $trashFillCount times',
                            style: const TextStyle(
                              color: Color(0xFFD9D9D9),
                              fontSize: 14.0,
                            )),
                        const SizedBox(height: 5.0),
                        Text(trashCreatedTime,
                            style: const TextStyle(
                              color: Color(0xFFD9D9D9),
                              fontSize: 12.0,
                            )),
                      ])),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    isFull ? 'FULL!' : '',
                    style: const TextStyle(
                      color: Color(0xFFE54335),
                      fontSize: 16.0,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
