import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:repo_viewer/app/app.router.dart';
import 'package:repo_viewer/services/api.dart';
import 'package:repo_viewer/services/authentication_service.dart';
import 'package:repo_viewer/ui/auth/login/login_view.dart';
import 'package:repo_viewer/ui/home/home_view.dart';
import 'package:repo_viewer/ui/json_viewer/json_viewer.dart';
import 'package:repo_viewer/ui/splash/splash_view.dart';
import 'package:repo_viewer/utils/constants/constants.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  locatorName: "stackedLocator",
  locatorSetupName: "setupLocator",
  logger: StackedLogger(),
  dependencies: [
    LazySingleton(classType: AuthenticationService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: Api),
  ],
  routes: [
    MaterialRoute(page: LoginView),
    MaterialRoute(page: Home),
    MaterialRoute(page: JsonViewer),
    MaterialRoute(page: SplashScreen, initial: true),
  ],
)
class RepoViewer extends StatelessWidget {
  const RepoViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RepoViewer',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: colorGreen,
        scaffoldBackgroundColor: const Color(0xFFfcfcfc),
        iconTheme: const IconThemeData(color: colorGreen),
        colorScheme: const ColorScheme.light(
          primary: colorGreen,
          secondary: colorGreen,
        ),
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(color: colorGreen),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: GoogleFonts.ibmPlexSans(
            color: colorGreen,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: colorGreen,
          selectionColor: colorGreen.withOpacity(0.3),
          selectionHandleColor: colorGreen,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(primary: colorGreen),
      ),
      navigatorKey: StackedService.navigatorKey,
      initialRoute: Routes.splashScreen,
      onGenerateRoute: (settings) => StackedRouter().onGenerateRoute(settings),
    );
  }
}
