import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:auto_parts/constants/constant.dart';
import 'package:auto_parts/models/exceptions/app_exceptions.dart';
import 'package:http/http.dart' as http;

class HttpDataHandler {
  //GET
  Future<dynamic> get(String baseUrl, String api) async {
    var uri = Uri.parse(baseUrl + api);

    try {
      var response = await http
          .get(uri)
          .timeout(Duration(seconds: Constant.RQ_TIME_OUT_SECONDS));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('Error while loading data', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  //POST
  Future<dynamic> post(String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    var payload = json.decode(payloadObj);

    try {
      var response = await http
          .post(uri, body: payload)
          .timeout(Duration(seconds: Constant.RQ_TIME_OUT_SECONDS));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('Error while loading data', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return utf8.decode(response.bodyBytes);
        break;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request.url.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured with code: ${response.statusCode}',
            response.request.url.toString());
    }
  }
}
