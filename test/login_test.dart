import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sam_api_calls/impl/impl.dart';
import 'package:sam_api_calls/models/models.dart';

void main() {
  test("Test login", () async {
    final Dio userDio = Dio(BaseOptions(baseUrl: ApiEndpoints.BASE_URL));
    (userDio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };

      return client;
    };

    final dataService = DataServiceImpl(dio: userDio);

    final localService = LocalServiceImpl();
    final authService =
        AuthServiceImpl(storage: localService, interceptors: []);
    final authInterceptor = AuthInterceptor(
        dio: userDio,
        authService: authService,
        onRefreshedToken: () async {});
    userDio.interceptors.addAll([authInterceptor]);

    final Dio appDio = Dio(BaseOptions(baseUrl: ApiEndpoints.BASE_URL));
    (appDio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };

      return client;
    };
    final appInterceptor = AppInterceptor(
        dio: appDio, authService: authService);
    appDio.interceptors.addAll([appInterceptor]);

    // final appService = AppServiceImpl(dio: appDio);
    // final publicService = PublicServiceImpl();

    final BasicAuth appAuth = BasicAuth(
        username: "",
        password:
            "");
    final appToken =
        await authService.generateAppToken(appAuth.username, appAuth.password);
    print(appToken.accessToken);

    final userToken = await authService.generateUserToken(
        "", "", appToken.accessToken);
    print(userToken.accessToken);

    UserAccount userAccount = await dataService.getUserAccount().then((value) {
      return value;
    }).catchError((e) {
      print(e.toString());
      return null;
    });

    print(userAccount != null);
  });
}
