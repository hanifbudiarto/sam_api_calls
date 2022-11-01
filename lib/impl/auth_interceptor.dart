part of sam_impl;

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final AuthService _authService;
  final Function _onRefreshedToken;

  AuthInterceptor(
      {required Dio dio,
      required AuthService authService,
      required Function onRefreshedToken})
      : this._dio = dio,
        this._authService = authService,
        this._onRefreshedToken = onRefreshedToken;

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? accessToken = await _authService.getCurrentUserAccessToken();

    if (accessToken != null) {
      options.headers.remove(HttpHeaders.authorizationHeader);
      options.headers[HttpHeaders.authorizationHeader] =
          "Bearer " + accessToken;
    }

    return handler.next(options);
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) async {
    _dio.interceptors.requestLock.lock();
    _dio.interceptors.responseLock.lock();

    if (error.response?.statusCode == 401) {
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
                  receiveDataWhenStatusError:
                      options.receiveDataWhenStatusError,
                  followRedirects: options.followRedirects,
                  maxRedirects: options.maxRedirects,
                  requestEncoder: options.requestEncoder,
                  responseDecoder: options.responseDecoder,
                  listFormat: options.listFormat,
                  contentType: options.contentType),
            );
          });
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
