part of sam_models_auth;

class AuthToken {
  late final String accessToken;
  late final String refreshToken;

  AuthToken({required this.accessToken, required this.refreshToken});

  AuthToken.fromConcatenatedString(String? concatString) {
    var tokenAccess = "";
    var tokenRefresh = "";

    if (concatString != null && concatString.length > 0) {
      if (concatString.contains("|")) {
        var tokenArr = concatString.split("|");
        if (tokenArr.length > 1) {
          tokenAccess = tokenArr[0];
          tokenRefresh = tokenArr[1];
        }
      } else {
        tokenAccess = concatString;
      }
    }

    this.accessToken = tokenAccess;
    this.refreshToken = tokenRefresh;
  }
}
