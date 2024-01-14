import 'package:dinacom_2024/firebase_options.dart';
import 'package:dinacom_2024/router/app_navigation.dart';
import 'package:dinacom_2024/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'models/user_model.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  GoRouter.optionURLReflectsImperativeAPIs = true;

  await Permission.locationWhenInUse.isDenied.then((valueOfPermission) {
    if (valueOfPermission) {
      Permission.locationWhenInUse.request();
    }
  });

  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return StreamProvider<UserModel?>.value(
        value: AuthService().user,
        initialData: null,
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.interTextTheme(),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          routerConfig: AppNavigation.getRouter(),
        )
    );
  }
}