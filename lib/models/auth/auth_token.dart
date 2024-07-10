part of sam_models_auth;

class AuthToken {
  final String accessToken;
  final String refreshToken;

  AuthToken({required this.accessToken, required this.refreshToken});

  AuthToken.fromConcatenatedString(String? concatString)
      : this.accessToken = getAccessToken(concatString),
        this.refreshToken = getRefreshToken(concatString);

  static String getAccessToken(String? concatString) {
    var tokenAccess = "";

    if (concatString != null && concatString.length > 0) {
      if (concatString.contains("|")) {
        var tokenArr = concatString.split("|");
        if (tokenArr.length > 1) {
          tokenAccess = tokenArr[0];
        }
      } else {
        tokenAccess = concatString;
      }
    }

    return tokenAccess;
  }

  static String getRefreshToken(String? concatString) {
    var tokenRefresh = "";

    if (concatString != null && concatString.length > 0) {
      if (concatString.contains("|")) {
        var tokenArr = concatString.split("|");
        if (tokenArr.length > 1) {
          tokenRefresh = tokenArr[1];
        }
      }
    }

    return tokenRefresh;
  }
}
