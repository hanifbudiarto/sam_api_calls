part of sam_contracts;

abstract class AuthService {
  Future<AuthToken> generateAppToken(String key, String password);

  Future<AuthToken> refreshAppToken(String appRefreshToken);

  Future<AuthToken> generateUserToken(
      String username, String password, String appAccessToken);

  Future<AuthToken> refreshUserToken(
      String userRefreshToken, String appAccessToken);

  Future<AuthToken> generateDeviceToken(String key, String password);

  Future<AuthToken> refreshDeviceToken(String deviceRefreshToken);

  Future<bool> saveTokens(
      {AuthToken? appToken, AuthToken? userToken, AuthToken? deviceToken});

  Future<String> getCurrentUserAccessToken();

  Future<String> getCurrentAppAccessToken();

  Future<String> getCurrentDeviceAccessToken();

  Future<String> getSavedUserRefreshToken();

  Future<String> getSavedAppRefreshToken();

  Future<String> getSavedDeviceRefreshToken();

  Future<BasicAuth> getAppCredential(String username, String password);

  Future<BasicAuth> getDeviceCredential(String username, String password);

  Future<bool> saveUserRefreshToken(String token);

  Future<bool> saveAppRefreshToken(String token);

  Future<bool> saveDeviceRefreshToken(String token);
}
