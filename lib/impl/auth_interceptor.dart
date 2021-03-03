import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sam_api_calls/contracts/contracts.dart';
import 'package:sam_api_calls/models/local_service_keys.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final AuthService _authService;
  final LocalService _localService;
  final VoidCallback _onRefreshedToken;

  AuthInterceptor(
      {@required Dio dio,
      @required AuthService authService,
      @required VoidCallback onRefreshedToken,
      @required LocalService localService})
      : this._dio = dio,
        this._authService = authService,
        this._onRefreshedToken = onRefreshedToken,
        this._localService = localService;

  @override
  Future onRequest(RequestOptions options) async {
    String accessToken = await _authService.getCurrentUserAccessToken();

    if (accessToken != null) {
      options.headers.remove(HttpHeaders.authorizationHeader);
      options.headers[HttpHeaders.authorizationHeader] =
          "Bearer " + accessToken;
    }

    return options;
  }

  @override
  Future onResponse(Response response) async {
    await _localService.clear(
        key: LocalServiceKeys.AUTH_INTERCEPTOR_ERROR_COUNTER);
    return response;
  }

  @override
  Future onError(DioError error) async {
    bool counterErrorExists = await _localService.isContainsKey(
        key: LocalServiceKeys.AUTH_INTERCEPTOR_ERROR_COUNTER);
    int counter = 0;
    if (counterErrorExists) {
      String counterStr = await _localService.read(
          key: LocalServiceKeys.AUTH_INTERCEPTOR_ERROR_COUNTER);
      counter = int.parse(counterStr);
    }

    if (error.response.statusCode == 401 && counter <= 2) {
      _dio.interceptors.requestLock.lock();
      _dio.interceptors.responseLock.lock();

      await _authService
          .refreshAppToken(await _authService.getSavedAppRefreshToken())
          .then((appToken) async {
        await _authService
            .refreshDeviceToken(await _authService.getSavedDeviceRefreshToken())
            .then((deviceToken) async {
          await _authService
              .refreshUserToken(await _authService.getSavedUserRefreshToken(),
                  appToken.accessToken)
              .then((userToken) async {
            await _authService.saveTokens(
                appToken: appToken,
                userToken: userToken,
                deviceToken: deviceToken);
            await _localService.write(
                key: LocalServiceKeys.AUTH_INTERCEPTOR_ERROR_COUNTER,
                value: (counter + 1).toString());

            _onRefreshedToken();
          });
        });
      });

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
