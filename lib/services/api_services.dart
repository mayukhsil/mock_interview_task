import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mock_interview_task/services/exceptions.dart';

abstract class API {
  dynamic returnResponse(http.Response response);
  Future<dynamic> getData(String url);
  Future<dynamic> postData(String url, {Map<String, dynamic> body});
}

class APIService implements API {
  APIService._();
  static final instance = APIService._();
  static const String _baseURL = 'https://dummyjson.com';

  @override
  Future<dynamic> getData(
      String? url, {
        Map<String, dynamic>? queryParams,
      }) async {
    dynamic responseJson;
    try {
      log('response from $_baseURL$url');
      var queryString = '';
      var finalPath = '$_baseURL$url';
      if (queryParams != null) {
        queryString = Uri(queryParameters: queryParams).query;
        finalPath += '?$queryString';
      }
      final response = await http.get(
        Uri.parse(finalPath),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  @override
  Future<dynamic> postData(
      String? url, {
        Map<String, dynamic>? body,
      }) async {
    dynamic responseJson;
    try {
      log('response from $url');
      final response = await http.post(
        Uri.parse('$_baseURL$url'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body),
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  @override
  dynamic returnResponse(http.Response response) {
    final dynamic responseJson = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        return responseJson;
      case 201:
        return responseJson;
      case 400:
        throw BadRequestException();
      case 401:
        throw UnauthorizedException(response.body);
      case 403:
        throw UnauthorizedException(response.body);
      case 404:
        throw ResourceNotFoundException();
      case 500:
        throw InternalServerException();
      default:
        throw FetchDataException(
          'Error occurred while Communication with Server with StatusCode : '
              '${response.statusCode}',
        );
    }
  }
}
