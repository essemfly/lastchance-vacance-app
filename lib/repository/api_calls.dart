import 'dart:convert';
import 'dart:typed_data';

import 'package:handover_app/initializers/app.dart';
import 'package:handover_app/utils.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

// const _baseApiUrl = 'http://52.79.251.236';
const String _baseApiUrl = 'http://127.0.0.1:8000';

class ProductsListCall {
  static Future<ApiCallResponse> call({
    int page = 0,
    int size = 100,
    String? search = "",
  }) async {
    String token = await getAccessToken();
    return ApiManager.instance.makeApiCall(
      callName: 'Products List',
      apiUrl: '$_baseApiUrl/api/products',
      callType: ApiCallType.GET,
      headers: {
        "Authorization": "Bearer " + token,
      },
      params: {
        'page': page,
        'size': size,
        'search': search,
      },
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
    );
  }
}

class ProductDetailCall {
  static Future<ApiCallResponse> call({
    String? productId = "",
  }) async {
    String token = await getAccessToken();
    return ApiManager.instance.makeApiCall(
      callName: 'Product Detail',
      apiUrl: '$_baseApiUrl/api/product/${productId}',
      callType: ApiCallType.GET,
      headers: {
        "Authorization": "Bearer " + token,
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

class UserDeviceCall {
  static Future<ApiCallResponse> call({
    String? deviceId = "",
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'User Device Call',
      apiUrl: '$_baseApiUrl/user',
      callType: ApiCallType.POST,
      headers: {},
      params: {"deviceuuid": deviceId},
      body: deviceId,
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class LikeProductCall {
  static Future<ApiCallResponse> call({
    String? productId = "",
  }) async {
    String token = await getAccessToken();
    return ApiManager.instance.makeApiCall(
      callName: 'Like Product Call',
      apiUrl: '$_baseApiUrl/api/user/like',
      callType: ApiCallType.POST,
      headers: {
        "Authorization": "Bearer " + token,
      },
      params: {"productid": productId},
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class ListLikeProductsCall {
  static Future<ApiCallResponse> call() async {
    String token = await getAccessToken();
    return ApiManager.instance.makeApiCall(
      callName: 'Like Product Call',
      apiUrl: '$_baseApiUrl/api/user/likes',
      callType: ApiCallType.GET,
      headers: {
        "Authorization": "Bearer " + token,
      },
      body: "",
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class ListOrdersCall {
  static Future<ApiCallResponse> call() async {
    String token = await getAccessToken();
    return ApiManager.instance.makeApiCall(
      callName: 'List Orders Call',
      apiUrl: '$_baseApiUrl/api/user/orders',
      callType: ApiCallType.GET,
      headers: {
        "Authorization": "Bearer " + token,
      },
      body: "",
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class CreateOrderCall {
  static Future<ApiCallResponse> call({
    String? productId = "",
    String? mobile = "",
  }) async {
    String token = await getAccessToken();
    return ApiManager.instance.makeApiCall(
      callName: 'Create Order Call',
      apiUrl: '$_baseApiUrl/api/user/order',
      callType: ApiCallType.POST,
      headers: {
        "Authorization": "Bearer " + token,
      },
      params: {
        "producid": productId,
        "mobile": mobile,
      },
      body: "",
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}
