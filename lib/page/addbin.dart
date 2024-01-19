import 'dart:math';

import 'package:dinacom_2024/components/loading.dart';
import 'package:dinacom_2024/models/trash_bin_model.dart';
import 'package:dinacom_2024/services/select_image_service.dart';
import 'package:dinacom_2024/services/trash_bin_service.dart';
import 'package:flutter/material.dart';
import 'package:dinacom_2024/components/common/checbox.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class AddBinPage extends StatefulWidget {
  final String uid;
  final String lat;
  final String lng;
  final String adrs;

  const AddBinPage(
      {super.key, required this.uid, required this.lat, required this.lng, required this.adrs});

  @override
  State<AddBinPage> createState() => _AddBinPageState();
}

class _AddBinPageState extends State<AddBinPage> {
  final _formKey = GlobalKey<FormState>();

  final TrashBinService _trashBinService = TrashBinService();
  final SelectImageService _selectImageService = SelectImageService();

  String _trashBinPictureImagePath = '';
  
  List<TrashBinType> _trashBinTypes = [];

  bool _isOrganicChecked = false;
  bool _isPaperChecked = false;
  bool _isChemicalChecked = false;
  bool _isPlasticChecked = false;
  bool _isGlassChecked = false;
  bool _isMetalChecked = false;
  bool _isEWasteChecked = false;
  bool _isError = false;
  bool _isFull = false;

  bool _loading = false;


  @override
  Widget build(BuildContext context) {

    if (_loading) {
      return const Loading();
    } else {
      ImageProvider image;

      if (_trashBinPictureImagePath != '') {
        image = NetworkImage(_trashBinPictureImagePath);
      } else {
        image = const AssetImage('assets/images/default_trash_bin.png');
      }

      return Form(
          key: _formKey,
          child: Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, right: 30.0),
                  child: TextButton(
                    onPressed: () async {
                      if (!_isOrganicChecked &&
                          !_isPaperChecked &&
                          !_isChemicalChecked &&
                          !_isPlasticChecked &&
                          !_isGlassChecked &&
                          !_isMetalChecked &&
                          !_isEWasteChecked) {
                        setState(() => _isError = true);
                      } else {
                        setState(() => _isError = false);

                        if (_formKey.currentState!.validate()) {
                          _trashBinService.addTrashBin(
                              createdAt: DateTime.now(),
                              uid: widget.uid,
                              tid: generateRandomString(28),
                              createdLocation: widget.adrs,
                              xCoord: widget.lat,
                              yCoord: widget.lng,
                              types: _trashBinTypes);

                          if (context.mounted) {
                            GoRouter.of(context).pop();
                          }
                        }
                      }
                    },
                    child: const Text('Done',
                        style: TextStyle(
                            color: Color(0xFF75BC7B), fontSize: 16.0)),
                  ),
                ),
              ],
              title: const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text('Trash Bin',
                    style: TextStyle(color: Colors.white, fontSize: 20.0)),
              ),
              backgroundColor: const Color(0xFF222222),
              surfaceTintColor: Colors.transparent,
              automaticallyImplyLeading: false,
              centerTitle: true,
            ),
            backgroundColor: const Color(0xFF222222),
            body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(
                        child: Stack(
                          children: <Widget>[
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
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: ClipOval(
                                    child: Container(
                                  width: 40,
                                  height: 40,
                                  color: Colors.white,
                                  child: IconButton(
                                      icon: const Icon(Icons.edit),
                                      color: const Color(0xFF2897ED),
                                      onPressed: () async {
                                        setState(() => _loading = true);
                                        String downloadURL =
                                            await _selectImageService
                                                .selectImage();
                                        setState(() {
                                          _trashBinPictureImagePath =
                                              downloadURL;
                                          _loading = false;
                                        });
                                      }),
                                )))
                          ],
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      const Text('Location',
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.0)),
                      Text(widget.adrs,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16.0)),
                      const SizedBox(height: 15.0),
                      const Text('Type',
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.0)),
                      const SizedBox(height: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          CommonCheckbox(
                            componentValue: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      'assets/logos/type_trash_bin_organic.svg',
                                      height: 16.0,
                                      width: 16.0),
                                  const SizedBox(width: 5.0),
                                  const Text('Organic',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0)),
                                ]),
                            isChecked: _isOrganicChecked,
                            isError: _isError,
                            setStateFunction: () => setState(() {
                              _isOrganicChecked = !_isOrganicChecked;
                              if (_isOrganicChecked) {
                                _trashBinTypes.add(TrashBinType.organic);
                              } else {
                                _trashBinTypes.remove(TrashBinType.organic);
                              }
                            }),
                          ),
                          const SizedBox(height: 10.0),
                          CommonCheckbox(
                            componentValue: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      'assets/logos/type_trash_bin_paper.svg',
                                      height: 16.0,
                                      width: 16.0),
                                  const SizedBox(width: 5.0),
                                  const Text('Paper',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0)),
                                ]),
                            isChecked: _isPaperChecked,
                            isError: _isError,
                            setStateFunction: () => setState(() {
                              _isPaperChecked = !_isPaperChecked;
                              if (_isPaperChecked) {
                                _trashBinTypes.add(TrashBinType.paper);
                              } else {
                                _trashBinTypes.remove(TrashBinType.paper);
                              }
                            }),
                          ),
                          const SizedBox(height: 10.0),
                          CommonCheckbox(
                            componentValue: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      'assets/logos/type_trash_bin_chemical.svg',
                                      height: 16.0,
                                      width: 16.0),
                                  const SizedBox(width: 5.0),
                                  const Text('Chemical',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0)),
                                ]),
                            isChecked: _isChemicalChecked,
                            isError: _isError,
                            setStateFunction: () => setState(() {
                              _isChemicalChecked = !_isChemicalChecked;
                              if (_isChemicalChecked) {
                                _trashBinTypes.add(TrashBinType.chemical);
                              } else {
                                _trashBinTypes.remove(TrashBinType.chemical);
                              }
                            }),
                          ),
                          const SizedBox(height: 10.0),
                          CommonCheckbox(
                            componentValue: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      'assets/logos/type_trash_bin_plastic.svg',
                                      height: 16.0,
                                      width: 16.0),
                                  const SizedBox(width: 5.0),
                                  const Text('Plastic',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0)),
                                ]),
                            isChecked: _isPlasticChecked,
                            isError: _isError,
                            setStateFunction: () => setState(() {
                              _isPlasticChecked = !_isPlasticChecked;

                              if (_isPlasticChecked) {
                                _trashBinTypes.add(TrashBinType.plastic);
                              } else {
                                _trashBinTypes.remove(TrashBinType.plastic);
                              }
                            }),
                          ),
                          const SizedBox(height: 10.0),
                          CommonCheckbox(
                            componentValue: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      'assets/logos/type_trash_bin_glass.svg',
                                      height: 16.0,
                                      width: 16.0),
                                  const SizedBox(width: 5.0),
                                  const Text('Glass',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0)),
                                ]),
                            isChecked: _isGlassChecked,
                            isError: _isError,
                            setStateFunction: () => setState(() {
                              _isGlassChecked = !_isGlassChecked;

                              if (_isGlassChecked) {
                                _trashBinTypes.add(TrashBinType.glass);
                              } else {
                                _trashBinTypes.remove(TrashBinType.glass);
                              }
                            }),
                          ),
                          const SizedBox(height: 10.0),
                          CommonCheckbox(
                            componentValue: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      'assets/logos/type_trash_bin_metal.svg',
                                      height: 16.0,
                                      width: 16.0),
                                  const SizedBox(width: 5.0),
                                  const Text('Metal',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0)),
                                ]),
                            isChecked: _isMetalChecked,
                            isError: _isError,
                            setStateFunction: () => setState(() {
                              _isMetalChecked = !_isMetalChecked;

                              if (_isMetalChecked) {
                                _trashBinTypes.add(TrashBinType.metal);
                              } else {
                                _trashBinTypes.remove(TrashBinType.metal);
                              }
                            }),
                          ),
                          const SizedBox(height: 10.0),
                          CommonCheckbox(
                            componentValue: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      'assets/logos/type_trash_bin_ewaste.svg',
                                      height: 16.0,
                                      width: 16.0),
                                  const SizedBox(width: 5.0),
                                  const Text('E Waste',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.0)),
                                ]),
                            isChecked: _isEWasteChecked,
                            isError: _isError,
                            setStateFunction: () => setState(() {
                              _isEWasteChecked = !_isEWasteChecked;

                              if (_isEWasteChecked) {
                                _trashBinTypes.add(TrashBinType.eWaste);
                              } else {
                                _trashBinTypes.remove(TrashBinType.eWaste);
                              }
                            }),
                          ),
                        ],
                      ),
                      _isError
                          ? const SizedBox(height: 5.0)
                          : const SizedBox(height: 0.0),
                      Text(
                          _isError ? 'One trash bin type must be selected' : '',
                          style: TextStyle(
                              color: Colors.red.shade900, fontSize: 12.0)),
                      _isFull
                          ? Container(
                              height: 40.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFF75BC7B),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: InkWell(
                                  onTap: () {
                                    setState(() => _isFull = false);
                                  },
                                  child: const Center(
                                      child: Text('Empty Trash Bin',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0)))),
                            )
                          : const SizedBox(height: 5.0),
                    ])),
          ));
    }
  }

  String generateRandomString(int length) {
    final random = Random();
    const availableChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final randomString = List.generate(length,
            (index) => availableChars[random.nextInt(availableChars.length)])
        .join();

    return randomString;
  }
}
