import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repo_viewer/ui/splash/splash_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      onViewModelReady: (model) async {
        model.checkUserLoggedIn(context);
      },
      viewModelBuilder: () => SplashViewModel(),
      builder: (ctx, model, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login With Github",
                style: GoogleFonts.ibmPlexSans(
                    color: Colors.deepPurple,
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
              ),
              Image.asset(
                "assets/images/github_icon.png",
                width: 200.w,
                height: 300.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}