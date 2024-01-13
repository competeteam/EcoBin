import 'package:dinacom_2024/components/profile/profile_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();

  String displayPictureImagePath = 'assets/images/google_logo.svg';
  String displayName = 'Frankie Huang';
  String city = 'Bandung';
  String province = 'West Java';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 30.0),
                child: TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      GoRouter.of(context).pop();
                    }
                  },
                  child: const Text('Done',
                      style:
                          TextStyle(color: Color(0xFF75BC7B), fontSize: 16.0)),
                ),
              ),
            ],
            backgroundColor: const Color(0xFF222222),
            title: const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text('Edit Profile',
                  style: TextStyle(color: Colors.white, fontSize: 20.0)),
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          backgroundColor: const Color(0xFF222222),
          body: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
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
                          child: SvgPicture.asset(displayPictureImagePath,
                              height: 150.0, width: 150.0, fit: BoxFit.cover),
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
                  ProfileFormField(
                      formTitle: 'Name',
                      formValue: displayName,
                      validatorFunction: (val) =>
                          val!.trim().isEmpty ? 'Name cannot be empty' : null,
                      onChangedFunction: (val) =>
                          setState(() => displayName = val.trim())),
                  const SizedBox(height: 15.0),
                  ProfileFormField(
                      formTitle: 'City',
                      formValue: city,
                      validatorFunction: (val) =>
                          val!.trim().isEmpty ? 'City cannot be empty' : null,
                      onChangedFunction: (val) =>
                          setState(() => city = val.trim())),
                  const SizedBox(height: 15.0),
                  ProfileFormField(
                      formTitle: 'Province',
                      formValue: province,
                      validatorFunction: (val) => val!.trim().isEmpty
                          ? 'Province cannot be empty'
                          : null,
                      onChangedFunction: (val) =>
                          setState(() => province = val.trim())),
                ]),
          )),
    );
  }
}
