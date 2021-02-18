import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../contracts/contracts.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final AuthService _authService;
  final VoidCallback _onRefreshedToken;

  AuthInterceptor({@required Dio dio, @required AuthService authService, @required VoidCallback onRefreshedToken})
      : this._dio = dio,
        this._authService = authService,
        this._onRefreshedToken = onRefreshedToken;

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
  Future onError(DioError error) async {
    if (error.response.statusCode == 401) {
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
