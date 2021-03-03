import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sam_api_calls/contracts/contracts.dart';
import 'package:sam_api_calls/models/models.dart';

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
  Future onResponse(Response response) async {
    await _localService.clear(
        key: LocalServiceKeys.APP_INTERCEPTOR_ERROR_COUNTER);
    return response;
  }

  @override
  Future onError(DioError error) async {
    bool counterErrorExists = await _localService.isContainsKey(
        key: LocalServiceKeys.APP_INTERCEPTOR_ERROR_COUNTER);
    int counter = 0;
    if (counterErrorExists) {
      String counterStr = await _localService.read(
          key: LocalServiceKeys.APP_INTERCEPTOR_ERROR_COUNTER);
      counter = int.parse(counterStr);
    }

    if (error.response.statusCode == 401 && counter <= 2) {
      _dio.interceptors.requestLock.lock();
      _dio.interceptors.responseLock.lock();

      // Refresh app token
      String savedAppRefreshToken =
          await _authService.getSavedAppRefreshToken();
      AuthToken newAppToken =
          await _authService.refreshAppToken(savedAppRefreshToken);
      await _authService.saveTokens(appToken: newAppToken);

      await _localService.write(
          key: LocalServiceKeys.APP_INTERCEPTOR_ERROR_COUNTER,
          value: (counter + 1).toString());

      RequestOptions options = error.response.request;

      _dio.interceptors.requestLock.unlock();
      _dio.interceptors.responseLock.unlock();

      return await _dio.request(
        options.path,
        queryParameters: error.request.queryParameters,
        data: error.request.data,
        options: options,
      );
    }

    return error;
  }
}
