import 'dart:convert';
import 'dart:developer';

import 'package:app_architecture_example/constants.dart';
import 'package:app_architecture_example/models/app_base_response.dart';
import 'package:http/http.dart';
import 'package:app_architecture_example/utils/request_type.dart';

class ApiRequester {
  ApiRequester._privateConstructor();

  static final ApiRequester instance = ApiRequester._privateConstructor();

  Map<String, String> get header => {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer here_should_be_token"
      };

  Future<AppBaseResponse?> makeRequest({
    required RequestType type,
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      ///useful if in future appears need in additional checks or refreshing token
      return await _handleRequest(type: type, url: url, body: body);
    } catch (e) {
      rethrow;
    }
  }

  Future<AppBaseResponse?> _handleRequest({
    required RequestType type,
    required String url,
    Map<String, dynamic>? body,
  }) async {
    log('~~\n\nrequest $url, type: $type,\nrequest body: ${body ?? ''}');

    final Response response;
    switch (type) {
      case RequestType.get:
        response = await get(
          Uri.parse(url),
          headers: header,
        ).onError((e, stackTrace) {
          throw NoConnectionException(e.toString());
        }).timeout(const Duration(seconds: timeout), onTimeout: () async {
          throw NoConnectionException('Timeout');
        });
        break;
      case RequestType.post:
        response = await post(
          Uri.parse(url),
          headers: header,
          body: body != null ? json.encode(body) : '',
        ).onError((e, stackTrace) {
          throw NoConnectionException(e.toString());
        }).timeout(const Duration(seconds: timeout), onTimeout: () async {
          throw NoConnectionException('Timeout');
        });
        break;
      case RequestType.patch:
        response = await patch(
          Uri.parse(url),
          headers: header,
          body: body != null ? json.encode(body) : '',
        ).onError((e, stackTrace) {
          throw NoConnectionException(e.toString());
        }).timeout(const Duration(seconds: timeout), onTimeout: () async {
          throw NoConnectionException('Timeout');
        });
        break;
      case RequestType.put:
        response = await put(
          Uri.parse(url),
          headers: header,
          body: body != null ? json.encode(body) : '',
        ).onError((e, stackTrace) {
          throw NoConnectionException(e.toString());
        }).timeout(const Duration(seconds: timeout), onTimeout: () async {
          throw NoConnectionException('Timeout');
        });
        break;
      case RequestType.delete:
        response = await delete(
          Uri.parse(url),
          headers: header,
          body: body != null ? json.encode(body) : '',
        ).onError((e, stackTrace) {
          throw NoConnectionException(e.toString());
        }).timeout(const Duration(seconds: timeout), onTimeout: () async {
          throw NoConnectionException('Timeout');
        });
        break;
    }

    log('statusCode ${response.statusCode}\nresponse body\n~${response.body}~');

    if (response.statusCode == 200 || response.statusCode == 204 || response.statusCode == 201) {
      return AppBaseResponse(body: response.body, isSuccess: true);
    } else if (response.statusCode == 422) {
      return AppBaseResponse(
        errorText: 'there is possibility to parse error fields if it provided by backend',
      );
    } else {
      return AppBaseResponse(
        errorText: 'Something went wrong ${response.statusCode}',
      );
    }
  }
}

class NoConnectionException implements Exception {
  final String _message;

  NoConnectionException(this._message);

  @override
  String toString() {
    return _message;
  }
}
