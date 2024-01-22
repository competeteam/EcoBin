import 'package:dinacom_2024/models/complaint_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ComplaintCard extends StatelessWidget {
  final String fullComplaintLogoPath = 'assets/logos/complaint_type_full.svg';
  final String damagedComplaintLogoPath =
      'assets/logos/complaint_type_damaged.svg';
  final String unusualOdorComplaintLogoPath =
      'assets/logos/complaint_type_unusual_odor.svg';
  final String noLabelComplaintLogoPath =
      'assets/logos/complaint_type_no_label.svg';
  final String improperlySortedComplaintLogoPath =
      'assets/logos/complaint_type_improperly_sorted.svg';
  final String notFoundComplaintLogoPath =
      'assets/logos/complaint_type_not_found.svg';
  final String othersComplaintLogoPath =
      'assets/logos/complaint_type_others.svg';

  final DateTime createdAt;
  final String cid;
  final String location;
  final String content;
  final bool isResolved;
  final ComplaintType type;

  const ComplaintCard(
      {super.key,
      required this.createdAt,
      required this.cid,
      required this.location,
      required this.content,
      required this.isResolved,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: const BoxDecoration(
        color: Color(0xFF3B3B3B),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Row(children: <Widget>[
        Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _complaintCardHeaderLogo(type),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Text(location,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16.0)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                        "${createdAt.hour}:${createdAt.minute} ${createdAt.day}-${createdAt.month}-${createdAt.year}",
                        style: const TextStyle(
                            color: Color(0xFFD9D9D9), fontSize: 14.0)),
                    const SizedBox(height: 10.0),
                    Text(content,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 16.0)),
                    const SizedBox(height: 10.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Status: ',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0)),
                        Text(isResolved ? 'Resolved' : 'Waiting',
                            style: TextStyle(
                                color: isResolved
                                    ? const Color(0xFF75BC7B)
                                    : const Color(0xFFEBEF26),
                                fontSize: 16.0))
                      ],
                    )
                  ],
                )))
      ]),
    );
  }

  SvgPicture _complaintCardHeaderLogo(ComplaintType type) {
    if (type == ComplaintType.full) {
      return SvgPicture.asset(fullComplaintLogoPath, height: 16.0, width: 16.0);
    }

    if (type == ComplaintType.damaged) {
      return SvgPicture.asset(damagedComplaintLogoPath,
          height: 16.0, width: 16.0);
    }

    if (type == ComplaintType.unusualOdor) {
      return SvgPicture.asset(unusualOdorComplaintLogoPath,
          height: 16.0, width: 16.0);
    }

    if (type == ComplaintType.noLabel) {
      return SvgPicture.asset(noLabelComplaintLogoPath,
          height: 16.0, width: 16.0);
    }

    if (type == ComplaintType.improperlySorted) {
      return SvgPicture.asset(improperlySortedComplaintLogoPath,
          height: 16.0, width: 16.0);
    }

    if (type == ComplaintType.notFound) {
      return SvgPicture.asset(notFoundComplaintLogoPath,
          height: 16.0, width: 16.0);
    }

    return SvgPicture.asset(othersComplaintLogoPath, height: 16.0, width: 16.0);
  }
}
