import 'dart:convert';
import 'dart:io';

import 'package:daeawt/core/api/status_code.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:daeawt/injector.dart' as injector;

import '../error/exceptions.dart';
import 'app_interceptors.dart';
import 'base_api_consumer.dart';
import 'end_points.dart';

class DioConsumer implements BaseApiConsumer {
  final Dio dioClient;

  DioConsumer({required this.dioClient}) {
    (dioClient.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    dioClient.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..receiveTimeout = 1000 * 60
      ..connectTimeout = 1000 * 60
      ..sendTimeout = 1000 * 60
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };

    dioClient.interceptors.add(injector.serviceLocator<AppInterceptors>());
    if (kDebugMode) {
      dioClient.interceptors.add(injector.serviceLocator<LogInterceptor>());
    }
  }

  @override
  Future get(String path,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      final response = await dioClient.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future post(String path,
      {Map<String, dynamic>? body,
      bool formDataIsEnabled = false,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    try {
      final response = await dioClient.post(
        path,
        data: formDataIsEnabled ? FormData.fromMap(body!) : body,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future put(String path,
      {Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    try {
      final response = await dioClient.put(
        path,
        data: body,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  dynamic _handleResponseAsJson(Response<dynamic> response) {
    final responseJson = jsonDecode(response.data);
    return responseJson;
  }

  dynamic _handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw const FetchDataException();
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case StatusCode.badRequest:
            throw const BadRequestException();
          case StatusCode.unauthorized:
            throw const UnauthorizedException();
          case StatusCode.forbidden:
          case StatusCode.notFound:
            throw const NotFoundException();
          case StatusCode.conflict:
            throw const ConflictException();
          case StatusCode.internalServerError:
            throw const InternalServerErrorException();
        }
        break;
      case DioErrorType.cancel:
      case DioErrorType.other:
        throw const NoInternetConnectionException();
    }
  }

  @override
  Future newPost(String path,
      {bool formDataIsEnabled = false,
      Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    try {
      final response = await dioClient.post(
        path,
        data: formDataIsEnabled ? FormData.fromMap(body!) : body,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future delete(String path,
      {bool formDataIsEnabled = false,
      Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {
    try {
      final response = await dioClient.delete(
        path,
        data: formDataIsEnabled ? FormData.fromMap(body!) : body,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }
}
