import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repo_viewer/app/app.router.dart';
import 'package:repo_viewer/ui/auth/login/login_view_model.dart';
import 'package:repo_viewer/ui/home/home_view.dart';
import 'package:repo_viewer/utils/shared_preferences.dart';
import 'package:repo_viewer/utils/widgets/custom_button.dart';
import 'package:stacked/stacked.dart';
import 'package:github_sign_in/github_sign_in.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
  }

  void signInWithGitHub(context, LoginViewModel model) async {
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: 'eccf81748be5072fcb37',
        clientSecret: '311d4ca14b67446a58bc07b8ee026502917a882e',
        redirectUrl:
            'https://github-json-reviewer.firebaseapp.com/__/auth/handler',
        title: 'GitHub Connection',
        centerTitle: false,
        scope: 'user,gist,user:email,repo,repo_public');
    final result = await gitHubSignIn.signIn(context);
    switch (result.status) {
      case GitHubSignInResultStatus.ok:
        log(result.token.toString());
        await Store.saveUser(result.token);
        await model.navigationService.clearStackAndShow(Routes.home);
        break;

      case GitHubSignInResultStatus.cancelled:
      case GitHubSignInResultStatus.failed:
        log(result.errorMessage.toLowerCase());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      onViewModelReady: (model) async {},
      viewModelBuilder: () => LoginViewModel(),
      builder: (ctx, model, child) => Scaffold(
        body: Column(
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
            CustomButton(onTap: () async {
              try {
                signInWithGitHub(context, model);
              } on FirebaseAuthException catch (e) {
                log(e.message.toString());
              }
            })
          ],
        ),
      ),
    );
  }
}
