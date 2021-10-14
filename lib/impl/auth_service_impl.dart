part of sam_impl;

class AuthServiceImpl extends AuthService {
  late Dio _dio;
  late LocalService _storage;
  AuthToken? _userToken, _appToken, _deviceToken;

  AuthServiceImpl(
      {required Dio dio, required LocalService storage, List<Interceptor>? interceptors}) {
    this._dio = dio;

    if (interceptors != null && interceptors.length > 0) {
      _dio.interceptors.addAll(interceptors);
    }

    this._storage = storage;
  }

  @override
  Future<AuthToken> generateAppToken(String key, String password) async {
    try {
      return await _dio
          .get(ApiEndpoints.AUTH,
              options: Options(headers: {
                HttpHeaders.authorizationHeader:
                    ApiHelper.buildEncodedBasicAuth(key, password)
              }))
          .then((value) => AuthToken.fromConcatenatedString(value.data));
    } on DioError catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<AuthToken> generateDeviceToken(String key, String password) async {
    try {
      return await _dio
          .get(ApiEndpoints.AUTH,
              options: Options(headers: {
                HttpHeaders.authorizationHeader:
                    ApiHelper.buildEncodedBasicAuth(key, password)
              }))
          .then((value) => AuthToken.fromConcatenatedString(value.data));
    } on DioError catch (_) {
      throw "Failed to authenticate device";
    }
  }

  @override
  Future<AuthToken> refreshAppToken(String appRefreshToken) async {
    try {
      return await _dio
          .get(ApiEndpoints.AUTH,
              options:
                  Options(headers: {ApiHelper.HEADER_API_KEY: appRefreshToken}))
          .then((value) => AuthToken(
              accessToken: value.data, refreshToken: appRefreshToken));
    } on DioError catch (_) {
      throw "Failed to refresh application token";
    }
  }

  @override
  Future<AuthToken> refreshDeviceToken(String deviceRefreshToken) async {
    try {
      return await _dio
          .get(ApiEndpoints.AUTH,
              options: Options(
                  headers: {ApiHelper.HEADER_API_KEY: deviceRefreshToken}))
          .then((value) => AuthToken(
              accessToken: value.data, refreshToken: deviceRefreshToken));
    } on DioError catch (_) {
      throw "Failed to refresh device token";
    }
  }

  @override
  Future<AuthToken> refreshUserToken(
      String userRefreshToken, String? appAccessToken) async {
    try {
      return await _dio
          .get(ApiEndpoints.AUTH,
              options: Options(headers: {
                HttpHeaders.authorizationHeader:
                    ApiHelper.buildBearerAuth(userRefreshToken),
                ApiHelper.HEADER_API_KEY: appAccessToken
              }))
          .then((value) => AuthToken(
              accessToken: value.data, refreshToken: userRefreshToken));
    } on DioError catch (_) {
      throw "Failed to refresh user token";
    }
  }

  @override
  Future<AuthToken> generateUserToken(
      String username, String password, String appAccessToken) async {
    try {
      return await _dio
          .get(ApiEndpoints.AUTH,
              options: Options(headers: {
                HttpHeaders.authorizationHeader:
                    ApiHelper.buildEncodedBasicAuth(username, password),
                ApiHelper.HEADER_API_KEY: appAccessToken
              }))
          .then((value) => AuthToken.fromConcatenatedString(value.data));
    } on DioError catch (_) {
      throw "Failed to authenticate user";
    }
  }

  @override
  Future<bool> saveTokens(
      {AuthToken? appToken,
      AuthToken? userToken,
      AuthToken? deviceToken}) async {
    try {
      if (userToken != null) {
        this._userToken = userToken;
        await saveUserRefreshToken(userToken.refreshToken);
      }

      if (appToken != null) {
        this._appToken = appToken;
        await saveAppRefreshToken(appToken.refreshToken);
      }

      if (deviceToken != null) {
        this._deviceToken = deviceToken;
        await saveDeviceRefreshToken(deviceToken.refreshToken);
      }
      return await Future.value(true);
    } catch (e) {}

    return await Future.value(false);
  }

  @override
  Future<String?> getCurrentAppAccessToken() async {
    if (_appToken == null) return null;

    return await Future.value(_appToken!.accessToken);
  }

  @override
  Future<String> getSavedAppRefreshToken() async {
    String? token =
        await _storage.read(key: LocalServiceKeys.ARGUMENT_REFRESH_TOKEN_APP);
    if (token == null) return "";
    return token;
  }

  @override
  Future<String?> getCurrentUserAccessToken() async {
    if (_userToken == null) return null;

    return await Future.value(_userToken!.accessToken);
  }

  @override
  Future<String> getSavedUserRefreshToken() async {
    String? token =
        await _storage.read(key: LocalServiceKeys.ARGUMENT_REFRESH_TOKEN_USER);
    if (token == null) return "";
    return token;
  }

  @override
  Future<String?> getCurrentDeviceAccessToken() async {
    if (_deviceToken == null) return null;

    return await Future.value(_deviceToken!.accessToken);
  }

  @override
  Future<String> getSavedDeviceRefreshToken() async {
    String? token = await _storage.read(
        key: LocalServiceKeys.ARGUMENT_REFRESH_TOKEN_DEVICE);
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
    return await _storage.write(
        key: LocalServiceKeys.ARGUMENT_REFRESH_TOKEN_APP, value: token);
  }

  @override
  Future<bool> saveDeviceRefreshToken(String token) async {
    return await _storage.write(
        key: LocalServiceKeys.ARGUMENT_REFRESH_TOKEN_DEVICE, value: token);
  }

  @override
  Future<bool> saveUserRefreshToken(String token) async {
    return await _storage.write(
        key: LocalServiceKeys.ARGUMENT_REFRESH_TOKEN_USER, value: token);
  }
}
