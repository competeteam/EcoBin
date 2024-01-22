import 'package:country_picker_plus/country_picker_plus.dart';
import 'package:dinacom_2024/components/error_page.dart';
import 'package:dinacom_2024/components/loading.dart';
import 'package:dinacom_2024/components/profile/title_form_field.dart';
import 'package:dinacom_2024/models/user_model.dart';
import 'package:dinacom_2024/services/select_image_service.dart';
import 'package:dinacom_2024/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Settings extends StatefulWidget {
  final UserModel user;

  const Settings({required this.user, super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<UserModel?>? _future;

  final _formKey = GlobalKey<FormState>();

  final UserService _userService = UserService();
  final SelectImageService _selectImageService = SelectImageService();

  String _displayPictureImagePath = '';
  String _displayName = '';
  String _city = '';
  String _province = '';

  bool loading = false;

  var fieldDecoration = CPPFDecoration(
    requiredErrorMessage: 'Province not selected',
    labelStyle: const TextStyle(color: Color(0xFF9D9D9D), fontSize: 14.0),
    hintStyle: const TextStyle(color: Colors.white, fontSize: 14.0),
    textStyle: const TextStyle(color: Colors.white, fontSize: 14.0),
    suffixColor: Colors.white,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Color(0xFF646464)),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(color: Colors.red.shade900),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: const BorderSide(color: Color(0xFF646464)),
    ),
  );

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  @override
  void didUpdateWidget(covariant Settings oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.user != widget.user) _fetch();
  }

  void _fetch() async {
    _future = UserService(uid: widget.user.uid).userModel;
  }

  void saveDataOnPressed(
      {required String oldDisplayPictureImagePath,
      required String oldDisplayName,
      required String oldCity,
      required String oldProvince}) async {
    setState(() => loading = true);

    try {
      await _userService.updateUser(
        uid: widget.user.uid,
        photoURL: _displayPictureImagePath != ''
            ? _displayPictureImagePath
            : oldDisplayPictureImagePath,
        displayName: _displayName != '' ? _displayName : oldDisplayName,
        city: _city != '' ? _city : oldCity,
        province: _province != '' ? _province : oldProvince,
      );

      if (context.mounted) {
        GoRouter.of(context).pop({
          "displayPictureImagePath": _displayPictureImagePath != ''
              ? _displayPictureImagePath
              : oldDisplayPictureImagePath,
          "displayName": _displayName != '' ? _displayName : oldDisplayName,
          "city": _city != '' ? _city : oldCity,
          "province": _province != '' ? _province : oldProvince,
        });
      }
    } catch (e) {
      // TODO: HANDLE ERROR
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : FutureBuilder<UserModel?>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loading();
              }

              if (snapshot.hasError) {
                return const ErrorPage();
              }

              UserModel userModel = snapshot.data!;

              ImageProvider image;

              if (_displayPictureImagePath != '') {
                image = NetworkImage(_displayPictureImagePath);
              } else if (userModel.photoURL != '') {
                image = NetworkImage(userModel.photoURL);
              } else {
                image = const AssetImage(
                    'assets/images/default_profile_picture.png');
              }

              return Form(
                key: _formKey,
                child: Scaffold(
                    appBar: AppBar(
                      actions: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 20.0, right: 30.0),
                          child: TextButton(
                            onPressed: () async {
                              saveDataOnPressed(
                                  oldDisplayPictureImagePath:
                                      userModel.photoURL,
                                  oldDisplayName: userModel.displayName,
                                  oldCity: userModel.city,
                                  oldProvince: userModel.province);
                            },
                            child: const Text('Done',
                                style: TextStyle(
                                    color: Color(0xFF75BC7B), fontSize: 16.0)),
                          ),
                        ),
                      ],
                      title: const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text('Edit Profile',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0)),
                      ),
                      backgroundColor: const Color(0xFF222222),
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
                                              _displayPictureImagePath =
                                                  downloadURL;
                                              loading = false;
                                            });
                                          },
                                        ),
                                      )))
                                ],
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            TitleFormField(
                                formTitle: 'Name',
                                formValue: userModel.displayName,
                                validatorFunction: (val) => val!.trim().isEmpty
                                    ? 'Name cannot be empty'
                                    : null,
                                onChangedFunction: (val) =>
                                    setState(() => _displayName = val.trim())),
                            const SizedBox(height: 15.0),
                            const Text('Location',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0)),
                            const SizedBox(height: 5.0),
                            CountryPickerPlus.state(
                                country: 'Indonesia',
                                isRequired: true,
                                label: 'Province',
                                hintText: _province != ''
                                    ? _province
                                    : userModel.province != ''
                                        ? userModel.province
                                        : 'Select Province',
                                decoration: fieldDecoration,
                                onSelected: (val) {
                                  setState(() {
                                    _province = val;
                                    _city = '';
                                  });
                                }),
                            const SizedBox(height: 5.0),
                            _province != '' || userModel.province != ''
                                ? CountryPickerPlus.city(
                                    country: 'Indonesia',
                                    state: _province,
                                    isRequired: true,
                                    label: 'City',
                                    hintText: _city != ''
                                        ? _city
                                        : userModel.city != ''
                                            ? userModel.city
                                            : 'Select City / Regency',
                                    decoration: fieldDecoration,
                                    onSelected: (val) {
                                      setState(() => _city = val);
                                    })
                                : const SizedBox(),
                          ]),
                    )),
              );
            });
  }
}
