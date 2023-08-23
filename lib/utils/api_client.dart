import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:repo_viewer/utils/failure.dart';

final client = http.Client();

enum HttpCallType { get, post, delete }

class SecureApiClient {
  static Future<http.Response> invoke({
    required HttpCallType callType,
    required String url,
    Map<String, String>? headers,
    String? body,
  }) async {
    http.Response res = await _invokeApi(
      callType: callType,
      url: url,
      headers: headers,
      body: body,
    );

    if (res.statusCode == 401) {
      res = await _invokeApi(callType: callType, url: url, body: body);
    }
    return res;
  }

  static Future<http.Response> _invokeApi({
    required HttpCallType callType,
    required String url,
    Map<String, String>? headers,
    String? body,
  }) async {
    try {
      http.Response? response;

      Uri uri = Uri.parse(url);
      headers ??= <String, String>{};
      if (callType == HttpCallType.post) {
        headers['Content-Type'] = 'application/json';
      }

      if (callType == HttpCallType.get) {
        response = await client.get(uri, headers: headers);
      } else if (callType == HttpCallType.post) {
        response = await client.post(uri, body: body, headers: headers);
      } else if (callType == HttpCallType.delete) {
        response = await client.delete(uri, headers: headers);
      }

      if (response!.statusCode == 200) {
        return response;
      } else if (response.statusCode == 401) {
        return response;
      } else if (response.statusCode == 404) {
        return response;
      } else {
        throw Failure(json.decode(response.body)["error"]);
      }
    } on SocketException {
      throw Failure('No Internet connection or fatal error');
    } on HttpException {
      throw Failure("Couldn't find the post");
    } on FormatException {
      throw Failure("Bad response format");
    } catch (e) {
      rethrow;
    }
  }
}
