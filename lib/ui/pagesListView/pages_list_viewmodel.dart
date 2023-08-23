import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:repo_viewer/app/app.locator.dart';
import 'package:repo_viewer/services/api.dart';
import 'package:repo_viewer/ui/json_viewer/json_viewer.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PagesListViewModel extends BaseViewModel {
  final _api = stackedLocator<Api>();
  final _navigationService = stackedLocator<NavigationService>();
  dynamic response = {};
    List pagesList = [];

  viewJson(repo, BuildContext context) async {
    setBusy(true);
    response = await _api.viewJson(repo);
    if (response.isNotEmpty) {
      await _navigationService.navigateToView(JsonViewer(response: response));
      log(response.toString());
    }
    setBusy(false);
  }

    getPagesList(repoUrl) async {
    setBusy(true);
    pagesList = await _api.getRepoContent(repoUrl);
    setBusy(false);
  }
}
