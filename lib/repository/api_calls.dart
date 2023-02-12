import 'dart:convert';
import 'dart:typed_data';

import 'package:handover_app/utils.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

const _baseApiUrl = 'http://127.0.0.1:8000';

class ProductsListCall {
  static Future<ApiCallResponse> call({
    int? page = 0,
    int? size = 30,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Products List',
      apiUrl: '$_baseApiUrl/products',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'page': page,
        'size': size,
      },
      returnBody: true,
      encodeBodyUtf8: true,
      decodeUtf8: true,
      cache: false,
    );
  }

  static dynamic products(dynamic response) => getJsonField(
        response,
        r'''$.content''',
        true,
      );
  static dynamic productId(dynamic response) => getJsonField(
        response,
        r'''$.content[:].id''',
        true,
      );
  static dynamic sellerName(dynamic response) => getJsonField(
        response,
        r'''$.content[:].seller.name''',
        true,
      );
  static dynamic sellerUid(dynamic response) => getJsonField(
        response,
        r'''$.content[:].seller.uid''',
        true,
      );
  static dynamic sellerMannerDegree(dynamic response) => getJsonField(
        response,
        r'''$.content[:].seller.mannerDegree''',
        true,
      );
  static dynamic sellerProfileUrl(dynamic response) => getJsonField(
        response,
        r'''$.content[:].seller.profileUrl''',
        true,
      );
  static dynamic title(dynamic response) => getJsonField(
        response,
        r'''$.content[:].name''',
        true,
      );
  static dynamic desc(dynamic response) => getJsonField(
        response,
        r'''$.content[:].desc''',
        true,
      );
  static dynamic reservedDate(dynamic response) => getJsonField(
        response,
        r'''$.content[:].reservedDate''',
        true,
      );
  static dynamic originalPrice(dynamic response) => getJsonField(
        response,
        r'''$.content[:].originalPrice''',
        true,
      );
  static dynamic handoverPrice(dynamic response) => getJsonField(
        response,
        r'''$.content[:].handoverPrice''',
        true,
      );
  static dynamic status(dynamic response) => getJsonField(
        response,
        r'''$.content[:].status''',
        true,
      );
  static dynamic defaultimage(dynamic response) => getJsonField(
        response,
        r'''$.content[:].defaultimage''',
        true,
      );
  static dynamic images(dynamic response) => getJsonField(
        response,
        r'''$.content[:].images''',
        true,
      );
  static dynamic originStatus(dynamic response) => getJsonField(
        response,
        r'''$.content[:].originStatus''',
        true,
      );
  static dynamic writtenAt(dynamic response) => getJsonField(
        response,
        r'''$.content[:].writtenAt''',
        true,
      );
  static dynamic writtenAddr(dynamic response) => getJsonField(
        response,
        r'''$.content[:].writtenAddr''',
        true,
      );
  static dynamic originId(dynamic response) => getJsonField(
        response,
        r'''$.content[:].originId''',
        true,
      );
  static dynamic productUrl(dynamic response) => getJsonField(
        response,
        r'''$.content[:].url''',
        true,
      );
}

class ProductsListSearchCall {
  static Future<ApiCallResponse> call({
    int? page = 0,
    int? size = 30,
    String? search = '',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Products List Search',
      apiUrl: '$_baseApiUrl/products',
      callType: ApiCallType.GET,
      headers: {},
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

  static dynamic products(dynamic response) => getJsonField(
        response,
        r'''$.content''',
        true,
      );
  static dynamic productId(dynamic response) => getJsonField(
        response,
        r'''$.content[:].id''',
        true,
      );
  static dynamic sellerName(dynamic response) => getJsonField(
        response,
        r'''$.content[:].seller.name''',
        true,
      );
  static dynamic sellerUid(dynamic response) => getJsonField(
        response,
        r'''$.content[:].seller.uid''',
        true,
      );
  static dynamic sellerMannerDegree(dynamic response) => getJsonField(
        response,
        r'''$.content[:].seller.mannerDegree''',
        true,
      );
  static dynamic sellerProfileUrl(dynamic response) => getJsonField(
        response,
        r'''$.content[:].seller.profileUrl''',
        true,
      );
  static dynamic title(dynamic response) => getJsonField(
        response,
        r'''$.content[:].title''',
        true,
      );
  static dynamic desc(dynamic response) => getJsonField(
        response,
        r'''$.content[:].desc''',
        true,
      );
  static dynamic reservedDate(dynamic response) => getJsonField(
        response,
        r'''$.content[:].reservedDate''',
        true,
      );
  static dynamic originalPrice(dynamic response) => getJsonField(
        response,
        r'''$.content[:].originalPrice''',
        true,
      );
  static dynamic handoverPrice(dynamic response) => getJsonField(
        response,
        r'''$.content[:].handoverPrice''',
        true,
      );
  static dynamic status(dynamic response) => getJsonField(
        response,
        r'''$.content[:].status''',
        true,
      );
  static dynamic defaultimage(dynamic response) => getJsonField(
        response,
        r'''$.content[:].default_image''',
        true,
      );
  static dynamic images(dynamic response) => getJsonField(
        response,
        r'''$.content[:].images''',
        true,
      );
  static dynamic originStatus(dynamic response) => getJsonField(
        response,
        r'''$.content[:].originStatus''',
        true,
      );
  static dynamic writtenAt(dynamic response) => getJsonField(
        response,
        r'''$.content[:].writtenAt''',
        true,
      );
  static dynamic writtenAddr(dynamic response) => getJsonField(
        response,
        r'''$.content[:].writtenAddr''',
        true,
      );
  static dynamic originId(dynamic response) => getJsonField(
        response,
        r'''$.content[:].originId''',
        true,
      );
  static dynamic productUrl(dynamic response) => getJsonField(
        response,
        r'''$.content[:].url''',
        true,
      );
}

class ProductDetailCall {
  static Future<ApiCallResponse> call({
    int? productId = 1,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'Product Detail',
      apiUrl: 'http://13.209.56.121/product/${productId}',
      callType: ApiCallType.GET,
      headers: {},
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

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar) {
  jsonVar ??= {};
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return '{}';
  }
}
