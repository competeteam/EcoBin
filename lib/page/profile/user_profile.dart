import 'package:dinacom_2024/components/error_page.dart';
import 'package:dinacom_2024/components/loading.dart';
import 'package:dinacom_2024/components/profile/complaint_card.dart';
import 'package:dinacom_2024/components/profile/trash_bin_card.dart';
import 'package:dinacom_2024/models/complaint.dart';
import 'package:dinacom_2024/models/trash_bin_model.dart';
import 'package:dinacom_2024/services/complaint_service.dart';
import 'package:dinacom_2024/services/trash_bin_service.dart';
import 'package:dinacom_2024/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:dinacom_2024/models/user_model.dart';

class UserProfile extends StatefulWidget {
  final UserModel user;

  const UserProfile({required this.user, super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  int _pageIndex = 0;

  bool isTrashBinsTabSelected = true;
  bool isComplaintsTabSelected = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    String displayPictureImagePath;
    String displayName;
    String location;
    String trashBinCount;
    String totalTrashBinFillCount;
    String totalEmissionReduced;

    return FutureBuilder(
      future: Future.wait([
        UserService(uid: widget.user.uid).userModel,
        TrashBinService(uid: widget.user.uid).trashBinModels,
        ComplaintService(uid: widget.user.uid).complaintModels
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        }

        if (snapshot.hasError) {
          return const ErrorPage();
        }

        UserModel? userModel = snapshot.data![0] as UserModel?;

        displayPictureImagePath = userModel!.photoURL != ''
            ? userModel.photoURL
            : 'assets/images/default_profile_picture.png';
        displayName = userModel.displayName;
        location = userModel.city != '' && userModel.province != ''
            ? '${userModel.city}, ${userModel.province}'
            : '';
        trashBinCount = userModel.trashBinCount.toString();
        totalTrashBinFillCount = userModel.totalTrashBinFillCount.toString();
        totalEmissionReduced = userModel.totalEmissionReduced.toString();

        ImageProvider image;

        if (userModel.photoURL != '') {
          image = NetworkImage(userModel.photoURL);
        } else {
          image = const AssetImage('assets/images/default_profile_picture.png');
        }

        List<TrashBinModel?> trashBinModels =
            snapshot.data![1] as List<TrashBinModel?>;

        List<Map<String, dynamic>> trashBinsInfo = [];

        for (TrashBinModel? trashBinModel in trashBinModels) {
          trashBinsInfo.add({
            'tid': trashBinModel!.tid,
            'imagePath': trashBinModel.imagePath,
            'types': trashBinModel.types,
            'createdLocation': trashBinModel.createdLocation,
            'fillCount': trashBinModel.fillCount,
            'createdAt': trashBinModel.createdAt,
            'isFull': trashBinModel.isFull,
          });
        }

        List<TrashBinCard> userTrashBins = trashBinsInfo
            .map((trashBinInfo) => TrashBinCard(
                  tid: trashBinInfo['tid'],
                  imagePath: trashBinInfo['imagePath'],
                  types: trashBinInfo['types'],
                  createdLocation: trashBinInfo['createdLocation'],
                  fillCount: trashBinInfo['fillCount'],
                  createdAt: trashBinInfo['createdAt'],
                  isFull: trashBinInfo['isFull'],
                ))
            .toList();

        List<Complaint?> complaints = snapshot.data![2] as List<Complaint?>;

        List<Map<String, dynamic>> complaintsInfo = [];

        for (Complaint? complaint in complaints) {
          complaintsInfo.add({
            'cid': complaint!.cid,
            'type': complaint.type,
            'location': complaint.location,
            'createdAt': complaint.createdAt,
            'content': complaint.content,
            'isResolved': complaint.isResolved
          });
        }

        List<ComplaintCard> userComplaints = complaintsInfo
            .map((complaintInfo) => ComplaintCard(
                createdAt: complaintInfo['createdAt'],
                cid: complaintInfo['cid'],
                location: complaintInfo['location'],
                content: complaintInfo['content'],
                isResolved: complaintInfo['isResolved'],
                type: complaintInfo['type']))
            .toList();

        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF222222),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 30.0),
                child: IconButton(
                  onPressed: () async {
                    dynamic result = await GoRouter.of(context)
                        .push('/settings', extra: user);

                    if (result != null) {
                      setState(() {
                        if (result['displayName'] != '') {
                          displayName = result['displayName'];
                        }

                        if (result['city'] != '' && result['province'] != '') {
                          location = "${result['city']}, ${result['province']}";
                        }
                      });
                    }
                  },
                  icon: const Icon(Icons.settings_rounded,
                      size: 24.0, color: Colors.white),
                ),
              )
            ],
            surfaceTintColor: Colors.transparent,
            automaticallyImplyLeading: false,
          ),
          backgroundColor: const Color(0xFF222222),
          body: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: Column(children: <Widget>[
                      // TODO: Fix image to circle
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
                        child: CircleAvatar(backgroundImage: image),
                      ),
                      const SizedBox(height: 20.0),
                      Text(displayName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          )),
                      const SizedBox(height: 10.0),
                      Text(location,
                          style: const TextStyle(
                            color: Color(0xFF9D9D9D),
                            fontSize: 16.0,
                          ))
                    ]),
                  ),
                  const SizedBox(height: 35.0),
                  Container(
                      height: 80.0,
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        color: Color(0xFF3B3B3B),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _userStatCard(trashBinCount, 'Trash Bins'),
                          const VerticalDivider(
                              width: 1.0, color: Color(0xFF9D9D9D)),
                          _userStatCard(totalTrashBinFillCount, 'Fill Count'),
                          const VerticalDivider(
                              width: 1.0, color: Color(0xFF9D9D9D)),
                          _userStatCard(
                              totalEmissionReduced, 'Emission\nReduced'),
                        ],
                      )),
                  const SizedBox(height: 15.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: isTrashBinsTabSelected
                                  ? const BoxDecoration(
                                      border: Border(
                                      bottom: BorderSide(
                                          width: 1.0, color: Color(0xFF75BC7B)),
                                    ))
                                  : null,
                              child: FilledButton(
                                style: FilledButton.styleFrom(
                                  elevation: 0,
                                  shape: const BeveledRectangleBorder(),
                                  backgroundColor: const Color(0xFF222222),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _pageIndex = 0;
                                    isTrashBinsTabSelected = true;
                                    isComplaintsTabSelected = false;
                                  });
                                },
                                child: const Center(
                                    child: Text('Trash Bins',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0))),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: isComplaintsTabSelected
                                  ? const BoxDecoration(
                                      border: Border(
                                      bottom: BorderSide(
                                          width: 1.0, color: Color(0xFF75BC7B)),
                                    ))
                                  : null,
                              child: FilledButton(
                                style: FilledButton.styleFrom(
                                  elevation: 0,
                                  shape: const BeveledRectangleBorder(),
                                  backgroundColor: const Color(0xFF222222),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _pageIndex = 1;
                                    isTrashBinsTabSelected = false;
                                    isComplaintsTabSelected = true;
                                  });
                                },
                                child: const Center(
                                    child: Text('Complaints',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0))),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IndexedStack(index: _pageIndex, children: <Widget>[
                              SizedBox(
                                height: _pageIndex == 0 ? null : 1,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: userTrashBins),
                              ),
                              SizedBox(
                                height: _pageIndex == 1 ? null : 1,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: userComplaints),
                              ),
                            ]
                                // children: _pageIndex == 0
                                //     ? userTrashBins
                                //     : userComplaints,
                                )
                          ]),
                    ],
                  ),
                ],
              )),
        );
      },
    );
  }

  Column _userStatCard(String mainText, String labelText) {
    return Column(
      children: <Widget>[
        Text(mainText,
            style: const TextStyle(color: Colors.white, fontSize: 20.0)),
        const SizedBox(height: 5.0),
        Text(labelText,
            style: const TextStyle(
              color: Color(0xFF9D9D9D),
              fontSize: 14.0,
            )),
      ],
    );
  }
}
