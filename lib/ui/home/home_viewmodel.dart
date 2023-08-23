import 'dart:developer';
import 'package:repo_viewer/app/app.locator.dart';
import 'package:repo_viewer/services/api.dart';
import 'package:repo_viewer/ui/pagesListView/pages_list_view.dart';
import 'package:repo_viewer/utils/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _api = stackedLocator<Api>();
  List repoList = [];
  dynamic response = {};
  final _navigationService = stackedLocator<NavigationService>();

  getTokenFromSPAndPassItToTheFunction() async {
    try {
      String? token = await Store.getUser();
      if (token != null) {
        getUserNameWithToken(token);
      } else {
        log("No Token found in SP");
      }
    } on Exception {
      log("No Token found in SP");
    }
  }

  void getUserNameWithToken(token) async {
    setBusy(true);
    var repoUrll = await _api.getUserNameWithToken(token);
    if (repoUrll['repos_url'] != "") {
      await getrepoList(repoUrll['repos_url']);
    } else {
      log("Some thing went wrong");
    }
    setBusy(false);
  }

  getrepoList(repoUrl) async {
    setBusy(true);
    repoList = await _api.getRepoList(repoUrl);
    setBusy(false);
  }

  goToPagesListPage(repoName){
    _navigationService.navigateToView(PagesList(repoName: repoName));
  }
}
