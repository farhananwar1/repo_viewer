import 'dart:convert';
import 'dart:developer';
import 'package:repo_viewer/utils/api_client.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = "https://api.github.com/user";
  static const jsonViewerBaseUrl = "https://raw.githubusercontent.com";
  Future<http.Response> clientGet(String url, {Map<String, String>? headers}) {
    log(url);
    log(headers.toString());

    return SecureApiClient.invoke(callType: HttpCallType.get, url: url,headers: headers);
  } 

  Future getUserNameWithToken(token) async {
    Map<String, String> headers = {
      "Accept": "application/vnd.github+json",
      "Authorization": "Bearer $token",
      "X-GitHub-Api-Version": "2022-11-28",
      };

    var response = await clientGet(baseUrl, headers: headers);
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      return responseData;
    } else if (response.statusCode == 404) {
      return null;
    } else {
      log('Request ${response.request!.url} failed with status: ${response.statusCode}.');
      return null;
    }
  }

    Future getRepoList(repoUrl) async {
    var response = await clientGet(repoUrl);
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      return responseData;
    } else if (response.statusCode == 404) {
      return null;
    } else {
      log('Request ${response.request!.url} failed with status: ${response.statusCode}.');
      return null;
    }
  }

  Future viewJson(repo) async {
    var response = await clientGet('$jsonViewerBaseUrl/$repo/main/json');
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      return responseData;
    } else if (response.statusCode == 404) {
      return null;
    } else {
      log('Request ${response.request!.url} failed with status: ${response.statusCode}.');
      return null;
    }
  }
}
