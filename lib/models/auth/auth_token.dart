import 'package:flutter/material.dart';

class AuthToken {
  final String accessToken;
  final String refreshToken;

  AuthToken({@required this.accessToken, @required this.refreshToken});

  factory AuthToken.fromConcatenatedString(String concatString) {
    if (concatString == null || concatString.length == 0) return null;

    var tokenAccess = "";
    var tokenRefresh = "";

    if (concatString.contains("|")) {
      var tokenArr = concatString.split("|");
      if (tokenArr.length > 1) {
        tokenAccess = tokenArr[0];
        tokenRefresh = tokenArr[1];
      }
    } else {
      tokenAccess = concatString;
    }

    return AuthToken(accessToken: tokenAccess, refreshToken: tokenRefresh);
  }
}
