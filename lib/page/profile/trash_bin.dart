import 'package:dinacom_2024/components/loading.dart';
import 'package:dinacom_2024/components/profile/title_form_field.dart';
import 'package:dinacom_2024/components/common/checbox.dart';
import 'package:dinacom_2024/models/trash_bin_model.dart';
import 'package:dinacom_2024/services/select_image_service.dart';
import 'package:dinacom_2024/services/trash_bin_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class TrashBin extends StatefulWidget {
  final String trashBinID;

  const TrashBin({super.key, required this.trashBinID});

  @override
  State<TrashBin> createState() => _TrashBinState();
}

class _TrashBinState extends State<TrashBin> {
  late TrashBinModel? _future;

  final _formKey = GlobalKey<FormState>();

  final TrashBinService _trashBinService = TrashBinService();
  final SelectImageService _selectImageService = SelectImageService();

  String _trashBinPictureImagePath = '';
  String _trashBinLocation = '';
  List<TrashBinType> _trashBinTypes = [];

  bool isOrganicChecked = false;
  bool isPaperChecked = false;
  bool isChemicalChecked = false;
  bool isPlasticChecked = false;
  bool isGlassChecked = false;
  bool isMetalChecked = false;
  bool isEWasteChecked = false;
  bool isError = false;
  bool isFull = false;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  Future<void> _fetch() async {
    setState(() => loading = true);

    _future = await TrashBinService(tid: widget.trashBinID).trashBinModel;

    TrashBinModel trashBinModel = _future!;

    _trashBinPictureImagePath = trashBinModel.imagePath;
    _trashBinLocation = trashBinModel.createdLocation;
    _trashBinTypes = trashBinModel.types;

    isOrganicChecked = trashBinModel.types.contains(TrashBinType.organic);
    isPaperChecked = trashBinModel.types.contains(TrashBinType.paper);
    isChemicalChecked = trashBinModel.types.contains(TrashBinType.chemical);
    isPlasticChecked = trashBinModel.types.contains(TrashBinType.plastic);
    isGlassChecked = trashBinModel.types.contains(TrashBinType.glass);
    isMetalChecked = trashBinModel.types.contains(TrashBinType.metal);
    isEWasteChecked = trashBinModel.types.contains(TrashBinType.eWaste);

    setState(() => loading = false);
  }

  void saveDataOnPressed({
    required oldTrashBinPictureImagePath,
    required oldTrashBinCreatedLocation,
    required oldTrashBinTypes,
  }) async {
    setState(() => loading = true);

    try {
      await _trashBinService.updateTrashBin(
          tid: widget.trashBinID,
          imagePath: _trashBinPictureImagePath != ''
              ? _trashBinPictureImagePath
                : oldTrashBinPictureImagePath,
          createdLocation: _trashBinLocation != ''
              ? _trashBinLocation
              : oldTrashBinCreatedLocation,
          types: _trashBinTypes != [] ? _trashBinTypes : oldTrashBinTypes);

      if (context.mounted) {
        GoRouter.of(context).pop({
          'imagePath': _trashBinPictureImagePath != ''
              ? _trashBinPictureImagePath
              : oldTrashBinPictureImagePath,
          'createdLocation': _trashBinLocation != ''
              ? _trashBinLocation
              : oldTrashBinCreatedLocation,
          'types': _trashBinTypes != [] ? _trashBinTypes : oldTrashBinTypes,
        });
      }
    } catch (e) {
      // TODO: Handle error
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Loading();
    } else {
      TrashBinModel trashBinModel = _future!;

      ImageProvider image;

      if (_trashBinPictureImagePath != '') {
        image = NetworkImage(_trashBinPictureImagePath);
      } else if (trashBinModel.imagePath != '') {
        image = NetworkImage(trashBinModel.imagePath);
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
                      if (!isOrganicChecked &&
                          !isPaperChecked &&
                          !isChemicalChecked &&
                          !isPlasticChecked &&
                          !isGlassChecked &&
                          !isMetalChecked &&
                          !isEWasteChecked) {
                        setState(() => isError = true);
                      } else {
                        setState(() => isError = false);

                        if (_formKey.currentState!.validate()) {
                          saveDataOnPressed(
                            oldTrashBinPictureImagePath:
                                trashBinModel.imagePath,
                            oldTrashBinCreatedLocation:
                                trashBinModel.createdLocation,
                            oldTrashBinTypes: trashBinModel.types,
                          );
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
                                        setState(() => loading = true);
                                        String downloadURL =
                                            await _selectImageService
                                                .selectImage();
                                        setState(() {
                                          _trashBinPictureImagePath =
                                              downloadURL;
                                          loading = false;
                                        });
                                      }),
                                )))
                          ],
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Row(children: <Widget>[
                        const Text('Filled',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0)),
                        const SizedBox(width: 5.0),
                        Text('${trashBinModel.fillCount.toString()} times',
                            style: const TextStyle(
                                color: Color(0xFF9D9D9D), fontSize: 16.0)),
                      ]),
                      const SizedBox(height: 15.0),
                      TitleFormField(
                          formTitle: 'Location',
                          formValue: trashBinModel.createdLocation,
                          validatorFunction: (val) => val!.trim().isEmpty
                              ? 'Location cannot be empty'
                              : null,
                          onChangedFunction: (val) =>
                              setState(() => _trashBinLocation = val.trim())),
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
                            isChecked: isOrganicChecked,
                            isError: isError,
                            setStateFunction: () => setState(() {
                              isOrganicChecked = !isOrganicChecked;
                              if (isOrganicChecked) {
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
                            isChecked: isPaperChecked,
                            isError: isError,
                            setStateFunction: () => setState(() {
                              isPaperChecked = !isPaperChecked;
                              if (isPaperChecked) {
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
                            isChecked: isChemicalChecked,
                            isError: isError,
                            setStateFunction: () => setState(() {
                              isChemicalChecked = !isChemicalChecked;
                              if (isChemicalChecked) {
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
                            isChecked: isPlasticChecked,
                            isError: isError,
                            setStateFunction: () => setState(() {
                              isPlasticChecked = !isPlasticChecked;

                              if (isPlasticChecked) {
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
                            isChecked: isGlassChecked,
                            isError: isError,
                            setStateFunction: () => setState(() {
                              isGlassChecked = !isGlassChecked;

                              if (isGlassChecked) {
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
                            isChecked: isMetalChecked,
                            isError: isError,
                            setStateFunction: () => setState(() {
                              isMetalChecked = !isMetalChecked;

                              if (isMetalChecked) {
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
                            isChecked: isEWasteChecked,
                            isError: isError,
                            setStateFunction: () => setState(() {
                              isEWasteChecked = !isEWasteChecked;

                              if (isEWasteChecked) {
                                _trashBinTypes.add(TrashBinType.eWaste);
                              } else {
                                _trashBinTypes.remove(TrashBinType.eWaste);
                              }
                            }),
                          ),
                        ],
                      ),
                      isError
                          ? const SizedBox(height: 5.0)
                          : const SizedBox(height: 0.0),
                      Text(isError ? 'One trash bin type must be selected' : '',
                          style: TextStyle(
                              color: Colors.red.shade900, fontSize: 12.0)),
                      isFull
                          ? Container(
                              height: 40.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFF75BC7B),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: InkWell(
                                  onTap: () {
                                    setState(() => isFull = false);
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
}
