import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sam_api_calls/contracts/contracts.dart';
import 'package:sam_api_calls/models/models.dart';

class AppInterceptor extends Interceptor {
  final Dio _dio;
  final AuthService _authService;

  AppInterceptor(Dio dio, AuthService authService)
      : this._dio = dio,
        this._authService = authService;

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
    if (error.response.statusCode == 401) {
      _dio.interceptors.requestLock.lock();
      _dio.interceptors.responseLock.lock();

      // Refresh app token
      String savedAppRefreshToken =
          await _authService.getSavedAppRefreshToken();
      AuthToken newAppToken =
          await _authService.refreshAppToken(savedAppRefreshToken);
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
    }

    return error;
  }
}
