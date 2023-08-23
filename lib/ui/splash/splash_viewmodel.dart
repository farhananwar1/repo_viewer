import 'package:repo_viewer/app/app.locator.dart';
import 'package:repo_viewer/app/app.router.dart';
import 'package:repo_viewer/utils/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends BaseViewModel {
  final _navigationService = stackedLocator<NavigationService>();

  Future checkUserLoggedIn(context) async {
    try {
      String? user = await Store.getUser();
      if (user != null) {
        await _navigationService.clearStackAndShow(Routes.home);
      } else {
        await _navigationService.clearStackAndShow(Routes.loginView);
      }
    } on Exception {
      stackedLocator<NavigationService>().clearStackAndShow(Routes.loginView);
    }
  }
}
