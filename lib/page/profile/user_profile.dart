import 'package:dinacom_2024/components/error_page.dart';
import 'package:dinacom_2024/components/loading.dart';
import 'package:dinacom_2024/components/profile/trash_bin_card.dart';
import 'package:dinacom_2024/models/trash_bin_model.dart';
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
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    String displayPictureImagePath;
    String displayName;
    String location;
    String trashBinCount;
    String totalTrashBinFillCount;
    String totalEmissionReduced;

    List<Map<String, dynamic>> trashBinsInfo = [];

    return FutureBuilder(
      future: Future.wait([
        UserService(uid: widget.user.uid).userModel,
        TrashBinService(uid: widget.user.uid).trashBinModels,
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

        List<TrashBinModel?> trashBinModels =
            snapshot.data![1] as List<TrashBinModel?>;

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
                        child: Image(
                          image: AssetImage(displayPictureImagePath),
                            height: 150.0, width: 150.0, fit: BoxFit.cover
                        ),
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
                  const SizedBox(height: 25.0),
                  const Text('Trash Bins',
                      style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  const SizedBox(height: 20.0),
                  Column(
                    children: trashBinsInfo
                        .map((trashBinInfo) => TrashBinCard(
                              tid: trashBinInfo['tid'],
                              imagePath: trashBinInfo['imagePath'],
                              types: trashBinInfo['types'],
                              createdLocation: trashBinInfo['createdLocation'],
                              fillCount: trashBinInfo['fillCount'],
                              createdAt: trashBinInfo['createdAt'],
                              isFull: trashBinInfo['isFull'],
                            ))
                        .toList(),
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
