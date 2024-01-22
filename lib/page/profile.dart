import 'package:dinacom_2024/features/profile/login.dart';
import 'package:dinacom_2024/features/profile/user_profile.dart';
import 'package:dinacom_2024/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
