part of sam_impl;

class AuthInterceptor extends QueuedInterceptorsWrapper {
  static const String TAG = "AuthInterceptor";
  final BaseLogger logger;
  final AuthService authService;
  final Function onRefreshedToken;

  AuthInterceptor(
      {required this.logger,
      required this.authService,
      required this.onRefreshedToken});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String accessToken = await authService.getCurrentUserAccessToken();
    options.headers.remove(HttpHeaders.authorizationHeader);
    options.headers[HttpHeaders.authorizationHeader] =
        "Bearer " + accessToken;

    handler.next(options);
  }

  Future<bool> refreshToken() async {
    final savedAppRefreshToken = await authService.getSavedAppRefreshToken();
    final savedDeviceRefreshToken =
        await authService.getSavedDeviceRefreshToken();
    final savedUserRefreshToken = await authService.getSavedUserRefreshToken();

    bool isRefreshed = false;
    await authService
        .refreshAppToken(savedAppRefreshToken)
        .then((appToken) async {
      logger.debug(TAG, 'Successfully refresh app token');

      await authService
          .refreshDeviceToken(savedDeviceRefreshToken)
          .then((deviceToken) async {
        logger.debug(TAG, 'Successfully refresh device token');

        await authService
            .refreshUserToken(savedUserRefreshToken, appToken.accessToken)
            .then((userToken) async {
          logger.debug(TAG, 'Successfully refresh user token');

          isRefreshed = await authService.saveTokens(
              appToken: appToken,
              userToken: userToken,
              deviceToken: deviceToken);
        });
      });
    }).catchError((e) {
      logger.error(TAG, e.toString());
    });

    return isRefreshed;
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode == 401) {
      logger.debug(TAG, 'The token has expired, need to receive new token');

      await refreshToken().then((refreshed) async {
        RequestOptions options = error.response!.requestOptions;

        logger.debug(TAG, 'Is successfully refresh token', {'refresh' : refreshed});

        if (refreshed) {
          onRefreshedToken();

          String accessToken = await authService.getCurrentUserAccessToken();

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
        }
        else {
          return handler.next(error);
        }
      });
    } else {
      return handler.next(error);
    }
  }
}
