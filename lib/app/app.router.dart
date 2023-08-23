// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i6;
import 'package:flutter/material.dart';
import 'package:repo_viewer/ui/auth/login/login_view.dart' as _i2;
import 'package:repo_viewer/ui/home/home_view.dart' as _i3;
import 'package:repo_viewer/ui/json_viewer/json_viewer.dart' as _i4;
import 'package:repo_viewer/ui/splash/splash_view.dart' as _i5;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i7;

class Routes {
  static const loginView = '/login-view';

  static const home = '/Home';

  static const jsonViewer = '/json-viewer';

  static const splashScreen = '/';

  static const all = <String>{
    loginView,
    home,
    jsonViewer,
    splashScreen,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.loginView,
      page: _i2.LoginView,
    ),
    _i1.RouteDef(
      Routes.home,
      page: _i3.Home,
    ),
    _i1.RouteDef(
      Routes.jsonViewer,
      page: _i4.JsonViewer,
    ),
    _i1.RouteDef(
      Routes.splashScreen,
      page: _i5.SplashScreen,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.LoginView: (data) {
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.LoginView(),
        settings: data,
      );
    },
    _i3.Home: (data) {
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.Home(),
        settings: data,
      );
    },
    _i4.JsonViewer: (data) {
      final args = data.getArgs<JsonViewerArguments>(nullOk: false);
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i4.JsonViewer(key: args.key, response: args.response),
        settings: data,
      );
    },
    _i5.SplashScreen: (data) {
      return _i6.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.SplashScreen(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class JsonViewerArguments {
  const JsonViewerArguments({
    this.key,
    required this.response,
  });

  final _i6.Key? key;

  final dynamic response;

  @override
  String toString() {
    return '{"key": "$key", "response": "$response"}';
  }

  @override
  bool operator ==(covariant JsonViewerArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.response == response;
  }

  @override
  int get hashCode {
    return key.hashCode ^ response.hashCode;
  }
}

extension NavigatorStateExtension on _i7.NavigationService {
  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHome([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.home,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToJsonViewer({
    _i6.Key? key,
    required dynamic response,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.jsonViewer,
        arguments: JsonViewerArguments(key: key, response: response),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSplashScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHome([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.home,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithJsonViewer({
    _i6.Key? key,
    required dynamic response,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.jsonViewer,
        arguments: JsonViewerArguments(key: key, response: response),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
