import 'package:dinacom_2024/components/error_page.dart';
import 'package:dinacom_2024/components/loading.dart';
import 'package:dinacom_2024/components/profile/title_form_field.dart';
import 'package:dinacom_2024/models/user_model.dart';
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

  // TODO: CHANGE PICTURE
  String _displayPictureImagePath = '';
  String _displayName = '';
  String _city = '';
  String _province = '';

  bool loading = false;

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

  void saveDataOnPressed(String oldDisplayPictureImagePath,
      String oldDisplayName, String oldCity, String oldProvince) async {
    setState(() => loading = true);

    if (_displayPictureImagePath == '') {
      _displayPictureImagePath = oldDisplayPictureImagePath;
    }
    if (_displayName == '') {
      _displayName = oldDisplayName;
    }
    if (_city == '') {
      _city = oldCity;
    }
    if (_province == '') {
      _province = oldProvince;
    }

    try {
      await _userService.updateUser(
        uid: widget.user.uid,
        displayName: _displayName,
        city: _city,
        province: _province,
      );

      if (context.mounted) {
        GoRouter.of(context).pop({
          "displayName": _displayName,
          "city": _city,
          "province": _province,
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

              UserModel? userModel = snapshot.data;

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
                                  userModel!.photoURL,
                                  userModel.displayName,
                                  userModel.city,
                                  userModel.province);
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
                                    child: Image(
                                      image: AssetImage(userModel!
                                              .photoURL.isNotEmpty
                                          ? userModel.photoURL
                                          : 'assets/images/default_profile_picture.png'),
                                      width: 150.0,
                                      height: 150.0,
                                      fit: BoxFit.cover,
                                    ),
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
                                          onPressed: () {},
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
                            TitleFormField(
                                formTitle: 'City',
                                formValue: userModel.city,
                                validatorFunction: (val) => val!.trim().isEmpty
                                    ? 'City cannot be empty'
                                    : null,
                                onChangedFunction: (val) =>
                                    setState(() => _city = val.trim())),
                            const SizedBox(height: 15.0),
                            TitleFormField(
                                formTitle: 'Province',
                                formValue: userModel.province,
                                validatorFunction: (val) => val!.trim().isEmpty
                                    ? 'Province cannot be empty'
                                    : null,
                                onChangedFunction: (val) =>
                                    setState(() => _province = val.trim())),
                          ]),
                    )),
              );
            });
  }
}
