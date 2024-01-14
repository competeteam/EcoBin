import 'package:dinacom_2024/page/profile/login.dart';
import 'package:dinacom_2024/page/profile/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dinacom_2024/models/user_model.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    if (user == null) {
      return const Login();
    } else {
      return UserProfile(user: user);
    }
  }
}
