import 'package:dinacom_2024/models/trash_bin_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class TrashBinCard extends StatefulWidget {
  final TrashBinModel trashBin;
  final Future<void> fetch;

  const TrashBinCard({required this.trashBin, required this.fetch, super.key});

  @override
  State<TrashBinCard> createState() => _TrashBinCardState();
}

class _TrashBinCardState extends State<TrashBinCard> {
  final String organicTrashBinLogoPath =
      'assets/logos/type_trash_bin_organic.svg';

  final String paperTrashBinLogoPath = 'assets/logos/type_trash_bin_paper.svg';

  final String chemicalTrashBinLogoPath =
      'assets/logos/type_trash_bin_chemical.svg';

  final String plasticTrashBinLogoPath =
      'assets/logos/type_trash_bin_plastic.svg';

  final String glassTrashBinLogoPath = 'assets/logos/type_trash_bin_glass.svg';

  final String metalTrashBinLogoPath = 'assets/logos/type_trash_bin_metal.svg';

  final String eWasteTrashBinLogoPath =
      'assets/logos/type_trash_bin_ewaste.svg';

  @override
  Widget build(BuildContext context) {
    DateTime createdAt = widget.trashBin.createdAt;
    String fillCount = widget.trashBin.fillCount.toString();
    String createdLocation = widget.trashBin.createdLocation;
    List<TrashBinType> types = widget.trashBin.types;

    ImageProvider image;

    if (widget.trashBin.imagePath != '') {
      image = NetworkImage(widget.trashBin.imagePath);
    } else {
      image = const AssetImage('assets/images/default_trash_bin.png');
    }

    return Container(
      height: 70.0,
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: const BoxDecoration(
        color: Color(0xFF3B3B3B),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: InkWell(
        onTap: () async {
          dynamic result = await GoRouter.of(context).push(
              '/trash-bin/${widget.trashBin.tid}',
              extra: widget.trashBin);

          if (result != null) {
            await widget.fetch;

            setState(() {
              image = NetworkImage(result['imagePath']);

              createdLocation = result['createdLocation'];

              types = result['types'];
            });
          }
        },
        child: Row(
          children: <Widget>[
            Container(
              width: 70,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0)),
                image: DecorationImage(image: image),
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
                                .map((type) => _trashBinCardHeaderLogos(type))
                                .expand((e) => [e, const SizedBox(width: 5.0)])
                                .toList(),
                            Expanded(
                              child: Text(createdLocation,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16.0)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        Text('Filled $fillCount times',
                            style: const TextStyle(
                              color: Color(0xFFD9D9D9),
                              fontSize: 14.0,
                            )),
                        const SizedBox(height: 5.0),
                        Text(
                            "${createdAt.day}-${createdAt.month}-${createdAt.year}"
                                .toString(),
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
                    widget.trashBin.isFull ? 'FULL!' : '',
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

  SvgPicture _trashBinCardHeaderLogos(TrashBinType type) {
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
