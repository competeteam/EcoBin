import 'package:dinacom_2024/page/profile/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import 'login.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel?>(context);

    if (user == null) {
      return const Login();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: const Center(
          child: Text('Profile'),
        ),
      );
    }
  }
}