part of sam_impl;

class AuthServiceImpl extends AuthService {
  static const String TAG = "AuthServiceImpl";
  final Dio dio;
  final BaseLogger logger;
  final LocalService storage;
  AuthToken userToken = AuthToken(accessToken: '', refreshToken: '');
  AuthToken appToken = AuthToken(accessToken: '', refreshToken: '');
  AuthToken deviceToken = AuthToken(accessToken: '', refreshToken: '');

  AuthServiceImpl({
    required Dio dio,
    required this.storage,
    required this.logger,
    List<Interceptor> interceptors = const <Interceptor>[],
  }) : this.dio = dio..interceptors.addAll(interceptors);

  @override
  Future<AuthToken> generateAppToken(String key, String password) async {
    try {
      return await dio
          .get(ApiEndpoints.AUTH,
              options: Options(headers: {
                HttpHeaders.authorizationHeader:
                    ApiHelper.buildEncodedBasicAuth(key, password)
              }))
          .then((value) => AuthToken.fromConcatenatedString(value.data));
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: "Failed to authenticate app");
    }
  }

  @override
  Future<AuthToken> generateDeviceToken(String key, String password) async {
    try {
      return await dio
          .get(ApiEndpoints.AUTH,
              options: Options(headers: {
                HttpHeaders.authorizationHeader:
                    ApiHelper.buildEncodedBasicAuth(key, password)
              }))
          .then((value) => AuthToken.fromConcatenatedString(value.data));
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: "Failed to authenticate device");
    }
  }

  @override
  Future<AuthToken> refreshAppToken(String appRefreshToken) async {
    try {
      return await dio
          .get(ApiEndpoints.AUTH,
              options:
                  Options(headers: {ApiHelper.HEADER_API_KEY: appRefreshToken}))
          .then((value) => AuthToken(
              accessToken: value.data, refreshToken: appRefreshToken));
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: "Failed to refresh app");
    }
  }

  @override
  Future<AuthToken> refreshDeviceToken(String deviceRefreshToken) async {
    try {
      return await dio
          .get(ApiEndpoints.AUTH,
              options: Options(
                  headers: {ApiHelper.HEADER_API_KEY: deviceRefreshToken}))
          .then((value) => AuthToken(
              accessToken: value.data, refreshToken: deviceRefreshToken));
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: "Failed to refresh device");
    }
  }

  @override
  Future<AuthToken> refreshUserToken(
      String userRefreshToken, String appAccessToken) async {
    try {
      return await dio
          .get(ApiEndpoints.AUTH,
              options: Options(headers: {
                HttpHeaders.authorizationHeader:
                    ApiHelper.buildBearerAuth(userRefreshToken),
                ApiHelper.HEADER_API_KEY: appAccessToken
              }))
          .then((value) => AuthToken(
              accessToken: value.data, refreshToken: userRefreshToken));
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: "Failed to refresh user token");
    }
  }

  @override
  Future<AuthToken> generateUserToken(
      String username, String password, String appAccessToken) async {
    try {
      return await dio
          .get(ApiEndpoints.AUTH,
              options: Options(headers: {
                HttpHeaders.authorizationHeader:
                    ApiHelper.buildEncodedBasicAuth(username, password),
                ApiHelper.HEADER_API_KEY: appAccessToken
              }))
          .then((value) => AuthToken.fromConcatenatedString(value.data));
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: "Failed to authenticate user");
    }
  }

  @override
  Future<bool> saveTokens(
      {AuthToken? appToken,
      AuthToken? userToken,
      AuthToken? deviceToken}) async {
    try {
      if (userToken != null) {
        this.userToken = AuthToken(
            accessToken: userToken.accessToken,
            refreshToken: userToken.refreshToken);
        await saveUserRefreshToken(userToken.refreshToken);
      }

      if (appToken != null) {
        this.appToken = AuthToken(
            accessToken: appToken.accessToken,
            refreshToken: appToken.refreshToken);
        ;
        await saveAppRefreshToken(appToken.refreshToken);
      }

      if (deviceToken != null) {
        this.deviceToken = AuthToken(
            accessToken: deviceToken.accessToken,
            refreshToken: deviceToken.refreshToken);

        await saveDeviceRefreshToken(deviceToken.refreshToken);
      }
      return await Future.value(true);
    } catch (e) {
      logger.error(TAG, e.toString());
    }

    return await Future.value(false);
  }

  @override
  Future<String> getCurrentAppAccessToken() async {
    return await Future.value(appToken.accessToken);
  }

  @override
  Future<String> getSavedAppRefreshToken() async {
    String? token =
        await storage.read(key: LocalServiceKeys.ARGUMENT_REFRESH_TOKEN_APP);
    if (token == null) return "";
    return token;
  }

  @override
  Future<String> getCurrentUserAccessToken() async {
    return await Future.value(userToken.accessToken);
  }

  @override
  Future<String> getSavedUserRefreshToken() async {
    String? token =
        await storage.read(key: LocalServiceKeys.ARGUMENT_REFRESH_TOKEN_USER);
    if (token == null) return "";
    return token;
  }

  @override
  Future<String> getCurrentDeviceAccessToken() async {
    return await Future.value(deviceToken.accessToken);
  }

  @override
  Future<String> getSavedDeviceRefreshToken() async {
    String? token =
        await storage.read(key: LocalServiceKeys.ARGUMENT_REFRESH_TOKEN_DEVICE);
    if (token == null) return "";
    return token;
  }

  @override
  Future<BasicAuth> getAppCredential(String username, String password) async {
    return BasicAuth(username: username, password: password);
  }

  @override
  Future<BasicAuth> getDeviceCredential(
      String username, String password) async {
    return BasicAuth(username: username, password: password);
  }

  @override
  Future<bool> saveAppRefreshToken(String token) async {
    return await storage.write(
        key: LocalServiceKeys.ARGUMENT_REFRESH_TOKEN_APP, value: token);
  }

  @override
  Future<bool> saveDeviceRefreshToken(String token) async {
    return await storage.write(
        key: LocalServiceKeys.ARGUMENT_REFRESH_TOKEN_DEVICE, value: token);
  }

  @override
  Future<bool> saveUserRefreshToken(String token) async {
    return await storage.write(
        key: LocalServiceKeys.ARGUMENT_REFRESH_TOKEN_USER, value: token);
  }
}
