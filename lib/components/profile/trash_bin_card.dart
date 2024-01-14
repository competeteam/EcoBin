import 'package:dinacom_2024/models/trash_bin_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class TrashBinCard extends StatelessWidget {
  final DateTime createdAt;
  final String tid;
  final String imagePath;
  final String createdLocation;
  final int fillCount;
  final bool isFull;
  final List<TrashBinType> types;

  const TrashBinCard({
    super.key,
    required this.createdAt,
    required this.tid,
    required this.imagePath,
    required this.createdLocation,
    required this.fillCount,
    required this.isFull,
    required this.types,
  });

  final String defaultTrashBinImagePath = 'assets/images/default_trash_bin.png';
  final String organicTrashBinLogoPath = 'assets/logos/organic_type.svg';
  final String paperTrashBinLogoPath = 'assets/logos/paper_type.svg';
  final String chemicalTrashBinLogoPath = 'assets/logos/chemical_type.svg';
  final String plasticTrashBinLogoPath = 'assets/logos/plastic_type.svg';
  final String glassTrashBinLogoPath = 'assets/logos/glass_type.svg';
  final String metalTrashBinLogoPath = 'assets/logos/metal_type.svg';
  final String eWasteTrashBinLogoPath = 'assets/logos/ewaste_type.svg';

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
          GoRouter.of(context).push('/trash-bin/$tid');
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
                    image: AssetImage(imagePath != ''
                        ? imagePath
                        : defaultTrashBinImagePath)),
              ),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ...types
                                .map((type) => _trashBinCardHeader(type))
                                .expand((e) => [e, const SizedBox(width: 5.0)])
                                .toList(),
                            Text(createdLocation,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16.0)),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        Text('Filled ${fillCount.toString()} times',
                            style: const TextStyle(
                              color: Color(0xFFD9D9D9),
                              fontSize: 14.0,
                            )),
                        const SizedBox(height: 5.0),
                        Text("${createdAt.day}-${createdAt.month}-${createdAt.year}".toString(),
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

  SvgPicture _trashBinCardHeader(TrashBinType type) {
    if (type == TrashBinType.organic) {
      return SvgPicture.asset(organicTrashBinLogoPath,
          height: 16.0, width: 16.0);
    }

    if (type == TrashBinType.paper) {
      return SvgPicture.asset(paperTrashBinLogoPath, height: 16.0, width: 16.0);
    }

    if (type == TrashBinType.chemical) {
      return SvgPicture.asset(chemicalTrashBinLogoPath,
          height: 16.0, width: 16.0);
    }

    if (type == TrashBinType.plastic) {
      return SvgPicture.asset(plasticTrashBinLogoPath,
          height: 16.0, width: 16.0);
    }

    if (type == TrashBinType.glass) {
      return SvgPicture.asset(glassTrashBinLogoPath, height: 16.0, width: 16.0);
    }

    if (type == TrashBinType.metal) {
      return SvgPicture.asset(metalTrashBinLogoPath, height: 16.0, width: 16.0);
    }

    return SvgPicture.asset(eWasteTrashBinLogoPath, height: 16.0, width: 16.0);
  }
}
