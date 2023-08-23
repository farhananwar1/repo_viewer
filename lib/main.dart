import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:repo_viewer/app/app.dart';
import 'package:repo_viewer/app/app.locator.dart';
import 'package:repo_viewer/firebase_options.dart';

void main() async {
  await setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.remove();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ScreenUtilInit(
        splitScreenMode: true,
        minTextAdapt: true,
        builder: (context, child) {
          return const RepoViewer();
        }),
  );
}
