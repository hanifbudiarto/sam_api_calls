import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sam_api_calls/contracts/contracts.dart';

class AppInterceptor extends Interceptor {
  final Dio _dio;
  final AuthService _authService;
  final LocalService _localService;

  AppInterceptor(
      {@required Dio dio,
      @required AuthService authService,
      @required LocalService localService})
      : this._dio = dio,
        this._authService = authService,
        this._localService = localService;

  @override
  Future onRequest(RequestOptions options) async {
    String appAccessToken = await _authService.getCurrentAppAccessToken();

    if (appAccessToken != null) {
      options.headers.remove(HttpHeaders.authorizationHeader);
      options.headers[HttpHeaders.authorizationHeader] =
          "Bearer " + appAccessToken;
    }

    return options;
  }

  @override
  Future onError(DioError error) async {
    _dio.interceptors.requestLock.lock();
    _dio.interceptors.responseLock.lock();

    if (error.response.statusCode == 401) {
      // Refresh app token
      await _authService
          .getSavedAppRefreshToken()
          .then((savedAppRefreshToken) async {
        await _authService
            .refreshAppToken(savedAppRefreshToken)
            .then((newAppToken) async {
          await _authService.saveTokens(appToken: newAppToken);

          RequestOptions options = error.response.request;

          _dio.interceptors.requestLock.unlock();
          _dio.interceptors.responseLock.unlock();

          return await _dio.request(
            options.path,
            queryParameters: error.request.queryParameters,
            data: error.request.data,
            options: options,
          );
        });
      }).catchError((e) {
        print(e.toString());
      });
    }

    _dio.interceptors.requestLock.unlock();
    _dio.interceptors.responseLock.unlock();

    return error;
  }
}
