import 'package:dinacom_2024/components/loading.dart';
import 'package:dinacom_2024/components/profile/trash_bin_card.dart';
import 'package:dinacom_2024/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import 'login.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  Column userStatCard(String mainText, String labelText) {
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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    String displayPictureImagePath = 'assets/images/google_logo.svg';
    String displayName = 'Frankie Huang';
    String city = 'Bandung';
    String province = 'West Java';
    String trashBins = '5';
    String fillCount = '999';
    String emissionReduced = '100t';
    String trashBinImagePath = 'https://via.placeholder.com/70x70';
    String trashLogoPath = 'assets/images/google_logo.svg';
    String trashBinLocation = 'Jl. Ganesha No. 9';
    String trashFillCount = '100';
    String trashBinCreatedTime = '1 December 2023';
    bool isFull = true;

    List<Map<String, dynamic>> trashBinsInfo = [
      {
        'trashBinImagePath': trashBinImagePath,
        'trashLogoPath': trashLogoPath,
        'trashCreatedLocation': trashBinLocation,
        'trashFillCount': trashFillCount,
        'trashCreatedTime': trashBinCreatedTime,
        'isFull': isFull,
      },
      {
        'trashBinImagePath': trashBinImagePath,
        'trashLogoPath': trashLogoPath,
        'trashCreatedLocation': trashBinLocation,
        'trashFillCount': trashFillCount,
        'trashCreatedTime': trashBinCreatedTime,
        'isFull': isFull,
      },
      {
        'trashBinImagePath': trashBinImagePath,
        'trashLogoPath': trashLogoPath,
        'trashCreatedLocation': trashBinLocation,
        'trashFillCount': trashFillCount,
        'trashCreatedTime': trashBinCreatedTime,
        'isFull': isFull,
      },
      {
        'trashBinImagePath': trashBinImagePath,
        'trashLogoPath': trashLogoPath,
        'trashCreatedLocation': trashBinLocation,
        'trashFillCount': trashFillCount,
        'trashCreatedTime': trashBinCreatedTime,
        'isFull': isFull,
      },
      {
        'trashBinImagePath': trashBinImagePath,
        'trashLogoPath': trashLogoPath,
        'trashCreatedLocation': trashBinLocation,
        'trashFillCount': trashFillCount,
        'trashCreatedTime': trashBinCreatedTime,
        'isFull': isFull,
      },
      {
        'trashBinImagePath': trashBinImagePath,
        'trashLogoPath': trashLogoPath,
        'trashCreatedLocation': trashBinLocation,
        'trashFillCount': trashFillCount,
        'trashCreatedTime': trashBinCreatedTime,
        'isFull': isFull,
      },
    ];

    return user == null
        ? const Login()
        : StreamBuilder<UserModel>(
            stream: UserService(uid: user.uid).userModel,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserModel? userModel = snapshot.data;

                displayPictureImagePath = userModel!.photoURL.isNotEmpty
                    ? userModel.photoURL
                    : 'assets/images/google_logo.svg';
                displayName = userModel.displayName;

                // TODO: ADD CITY
                // TODO: ADD PROVINCE
                // TODO: ADD TRASHBIN COUNT
                // TODO: ADD FILLCOUNT
                // TODO: ADD EMMISIONREDUCED

                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: const Color(0xFF222222),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, right: 30.0),
                        child: IconButton(
                          onPressed: () {
                            GoRouter.of(context).push('/settings');
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Center(
                            child: Column(children: <Widget>[
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
                                child: SvgPicture.asset(displayPictureImagePath,
                                    height: 150.0,
                                    width: 150.0,
                                    fit: BoxFit.cover),
                              ),
                              const SizedBox(height: 20.0),
                              Text(displayName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  )),
                              const SizedBox(height: 10.0),
                              Text('$city, $province',
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  userStatCard(trashBins, 'Trash Bins'),
                                  const VerticalDivider(
                                      width: 1.0, color: Color(0xFF9D9D9D)),
                                  userStatCard(fillCount, 'Fill Count'),
                                  const VerticalDivider(
                                      width: 1.0, color: Color(0xFF9D9D9D)),
                                  userStatCard(
                                      emissionReduced, 'Emission\nReduced'),
                                ],
                              )),
                          const SizedBox(height: 25.0),
                          const Text('Trash Bins',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0)),
                          const SizedBox(height: 20.0),
                          Column(
                            children: trashBinsInfo
                                .map((trashBinInfo) => TrashBinCard(
                                      trashBinImagePath: trashBinImagePath,
                                      trashLogoPath: trashLogoPath,
                                      trashCreatedLocation: trashBinLocation,
                                      trashFillCount: trashFillCount,
                                      trashCreatedTime: trashBinCreatedTime,
                                      isFull: isFull,
                                    ))
                                .toList(),
                          ),
                        ],
                      )),
                );
              } else {
                print('nah');

                return const Loading();
              }
            },
          );
  }
}
