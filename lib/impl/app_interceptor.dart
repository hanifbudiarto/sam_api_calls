part of sam_impl;

class AppInterceptor extends QueuedInterceptorsWrapper {
  static const String TAG = "AppInterceptor";
  final BaseLogger logger;
  final AuthService authService;

  AppInterceptor({required this.authService, required this.logger});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String appAccessToken = await authService.getCurrentAppAccessToken();

    options.headers.remove(HttpHeaders.authorizationHeader);
    options.headers[HttpHeaders.authorizationHeader] =
        'Bearer ' + appAccessToken;

    handler.next(options);
  }

  Future<bool> refreshAppToken() async {
    final savedAppRefreshToken = await authService.getSavedAppRefreshToken();

    bool isRefreshed = false;
    await authService
        .refreshAppToken(savedAppRefreshToken)
        .then((appToken) async {
      logger.debug(TAG, 'Successfully refresh app token');

      isRefreshed = await authService.saveTokens(appToken: appToken);
    }).catchError((e) {
      logger.error(TAG, e.toString());
    });

    return isRefreshed;
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == 401) {
      logger.debug(TAG, 'The token has expired, need to receive new token');

      await refreshAppToken().then((refreshed) async {
        RequestOptions options = error.response!.requestOptions;
        logger.debug(TAG, 'Is successfully refresh token : $refreshed');

        if (refreshed) {
          String accessToken = await authService.getCurrentAppAccessToken();

          options.headers.remove(HttpHeaders.authorizationHeader);
          options.headers[HttpHeaders.authorizationHeader] =
              "Bearer " + accessToken;

          final Dio dioRefresh = Dio(
            BaseOptions(baseUrl: options.baseUrl),
          );
          final Response response = await dioRefresh.request(
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
          return handler.resolve(response);
        } else {
          return handler.next(error);
        }
      });
    } else {
      return handler.next(error);
    }
  }
}
