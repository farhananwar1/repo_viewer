import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Store {
  static const String _userKey = "user";

  static Future<String?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userString = prefs.getString(_userKey);
    return userString != null ? json.decode(userString) : null;
  }

  static Future<bool> saveUser(String? token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_userKey, json.encode(token!));
  }

    static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userString = prefs.getString(_userKey);
    return userString != null ? json.decode(userString) : null;
  }
}

class SharedPreferencesBuilder<T> extends StatelessWidget {
  final String pref;
  final AsyncWidgetBuilder<dynamic> builder;

  const SharedPreferencesBuilder(
      {Key? key, required this.pref, required this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) => FutureBuilder<dynamic>(
      future: _future(),
      builder: (context, snapshot) => builder(context, snapshot));

  Future<dynamic> _future() async =>
      (await SharedPreferences.getInstance()).get(pref);
}
