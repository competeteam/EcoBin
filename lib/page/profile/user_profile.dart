import 'package:dinacom_2024/components/loading.dart';
import 'package:dinacom_2024/components/profile/complaint_card.dart';
import 'package:dinacom_2024/components/profile/trash_bin_card.dart';
import 'package:dinacom_2024/models/complaint_model.dart';
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
  late UserModel? _futureUserModel;
  late List<TrashBinModel?> _futureTrashBinModel;
  late List<ComplaintModel?> _futureComplaintModel;

  int _pageIndex = 0;

  bool _loading = false;

  bool _isTrashBinsTabSelected = true;
  bool _isComplaintsTabSelected = false;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  @override
  void didUpdateWidget(covariant UserProfile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.user != widget.user) _fetch();
  }

  Future<void> _fetch() async {
    setState(() => _loading = true);

    _futureUserModel = await UserService(uid: widget.user.uid).userModel;
    _futureTrashBinModel =
        await TrashBinService(uid: widget.user.uid).trashBinModels;
    _futureComplaintModel =
        await ComplaintService(uid: widget.user.uid).complaintModels;

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Loading();
    } else {
      final user = Provider.of<UserModel?>(context);

      UserModel userModel = _futureUserModel!;

      String displayName = userModel.displayName;
      String location = userModel.city != '' && userModel.province != ''
          ? '${userModel.city}, ${userModel.province}'
          : '';
      String trashBinCount = userModel.trashBinCount.toString();
      String totalTrashBinFillCount =
          userModel.totalTrashBinFillCount.toString();
      String totalEmissionReduced = userModel.totalEmissionReduced.toString();

      ImageProvider image;

      if (userModel.photoURL != '') {
        image = NetworkImage(userModel.photoURL);
      } else {
        image = const AssetImage('assets/images/default_profile_picture.png');
      }

      List<TrashBinModel?> trashBinModels = _futureTrashBinModel;

      List<TrashBinCard> userTrashBins = trashBinModels
          .map((trashBinModel) => TrashBinCard(
                trashBin: trashBinModel!,
                fetch: _fetch(),
              ))
          .toList();

      List<ComplaintModel?> complaintModels = _futureComplaintModel;

      List<ComplaintCard> userComplaints = complaintModels
          .map((complaintModel) => ComplaintCard(
              cid: complaintModel!.cid,
              type: complaintModel.type,
              location: complaintModel.location,
              createdAt: complaintModel.createdAt,
              content: complaintModel.content,
              isResolved: complaintModel.isResolved))
          .toList();

      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF222222),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 30.0),
              child: IconButton(
                onPressed: () async {
                  dynamic result =
                      await GoRouter.of(context).push('/settings', extra: user);

                  if (result != null) {
                    await _fetch();

                    setState(() {
                      userModel = _futureUserModel!;
                      trashBinModels = _futureTrashBinModel;
                      complaintModels = _futureComplaintModel;
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
        body: RefreshIndicator(
          onRefresh: _fetch,
          child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
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
                          Column(
                            children: <Widget>[
                              Text(trashBinCount,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20.0)),
                              const SizedBox(height: 5.0),
                              const Text('Trash Bins',
                                  style: TextStyle(
                                    color: Color(0xFF9D9D9D),
                                    fontSize: 14.0,
                                  )),
                            ],
                          ),
                          const VerticalDivider(
                              width: 1.0, color: Color(0xFF9D9D9D)),
                          Column(
                            children: <Widget>[
                              Text(totalTrashBinFillCount,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20.0)),
                              const SizedBox(height: 5.0),
                              const Text('Fill Count',
                                  style: TextStyle(
                                    color: Color(0xFF9D9D9D),
                                    fontSize: 14.0,
                                  )),
                            ],
                          ),
                          const VerticalDivider(
                              width: 1.0, color: Color(0xFF9D9D9D)),
                          Column(
                            children: <Widget>[
                              Text(totalEmissionReduced,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20.0)),
                              const SizedBox(height: 5.0),
                              const Text('Emission\nReduced',
                                  style: TextStyle(
                                    color: Color(0xFF9D9D9D),
                                    fontSize: 14.0,
                                  )),
                            ],
                          ),
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
                              decoration: _isTrashBinsTabSelected
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
                                    _isTrashBinsTabSelected = true;
                                    _isComplaintsTabSelected = false;
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
                              decoration: _isComplaintsTabSelected
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
                                    _isTrashBinsTabSelected = false;
                                    _isComplaintsTabSelected = true;
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
                            ])
                          ]),
                    ],
                  ),
                ],
              )),
        ),
      );
    }
  }
}
