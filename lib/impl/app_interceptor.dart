part of sam_impl;

class AppInterceptor extends Interceptor {
  final Dio _dio;
  final AuthService _authService;

  AppInterceptor({required Dio dio, required AuthService authService})
      : this._dio = dio,
        this._authService = authService;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? appAccessToken = await _authService.getCurrentAppAccessToken();

    if (appAccessToken != null) {
      options.headers.remove(HttpHeaders.authorizationHeader);
      options.headers[HttpHeaders.authorizationHeader] =
          'Bearer ' + appAccessToken;
    }

    return handler.next(options);
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) async {
    _dio.interceptors.requestLock.lock();
    _dio.interceptors.responseLock.lock();

    if (error.response?.statusCode == 401) {
      // Refresh app token
      await _authService
          .getSavedAppRefreshToken()
          .then((savedAppRefreshToken) async {
        await _authService
            .refreshAppToken(savedAppRefreshToken)
            .then((newAppToken) async {
          await _authService.saveTokens(appToken: newAppToken);

          RequestOptions options = error.response!.requestOptions;

          _dio.interceptors.requestLock.unlock();
          _dio.interceptors.responseLock.unlock();

          return await _dio.request(
            options.path,
            queryParameters: error.requestOptions.queryParameters,
            data: error.requestOptions.data,
            options: Options(
                method: options.method,
                headers: options.headers,
                extra: options.extra,
                sendTimeout: options.sendTimeout,
                receiveTimeout: options.receiveTimeout,
                responseType: options.responseType,
                validateStatus: options.validateStatus,
                receiveDataWhenStatusError: options.receiveDataWhenStatusError,
                followRedirects: options.followRedirects,
                maxRedirects: options.maxRedirects,
                requestEncoder: options.requestEncoder,
                responseDecoder: options.responseDecoder,
                listFormat: options.listFormat,
                contentType: options.contentType),
          );
        });
      }).catchError((e) {
        print(e.toString());
      });
    }

    _dio.interceptors.requestLock.unlock();
    _dio.interceptors.responseLock.unlock();

    return handler.next(error);
  }
}
