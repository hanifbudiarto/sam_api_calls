part of sam_impl;

class AppServiceImpl extends AppService {
  final Dio _dio;

  AppServiceImpl({required Dio dio}) : this._dio = dio;

  @override
  Future<UserAccount> getUserAccountByEmail(String email) async {
    try {
      return await _dio.get(ApiEndpoints.USER, queryParameters: {
        'user_email': email,
        'profile': 2
      }).then((value) => UserAccount.fromJson(value.data['body']));
    } on DioError catch (_) {
      throw 'Failed to get user account by email';
    }
  }

  @override
  Future<UserProfile> postNewUser(UserProfile user, String password) async {
    try {
      final String body = json.encode({
        'user_fname': '${user.userFname}',
        'user_lname': '${user.userLname}',
        'user_email': '${user.userEmail}',
        'user_pwd': password,
        'user_phone': ''
      });

      return await _dio
          .post(ApiEndpoints.USER, queryParameters: {'profile': 0}, data: body)
          .then((value) {
            if (value.data.containsKey('body')) {
              return UserProfile.fromJson(value.data['body']);
            }
            throw 'Results not valid';
      });
    } on DioError catch (_) {
      throw getThrowsMessage('Failed to register new user', _.response!.data);
    }
  }

  @override
  Future<bool> putRequestResetPassword(String accountId) async {
    try {
      return await _dio.put('${ApiEndpoints.USER}/$accountId',
          queryParameters: {'profile': 5}).then((value) => true);
    } on DioError catch (_) {
      throw 'Failed to request password reset';
    }
  }

  @override
  Future<bool> putResetPassword(
      String accountId, String verificationCode, String newPassword) async {
    try {
      final String body = json.encode(
          {'vcode': '$verificationCode', 'user_newpwd': '$newPassword'});

      return await _dio
          .put('${ApiEndpoints.USER}/$accountId',
              queryParameters: {'profile': 5}, data: body)
          .then((value) => true);
    } on DioError catch (_) {
      throw 'Failed to reset password';
    }
  }

  @override
  Future<bool> putVerify(String userId, String verificationCode) async {
    try {
      final String body = json.encode({'vcode': '$verificationCode'});

      return await _dio
          .put('${ApiEndpoints.USER}/$userId',
              queryParameters: {'profile': 3}, data: body)
          .then((value) => true);
    } on DioError catch (_) {
      throw 'Failed to verify user';
    }
  }

  @override
  String getThrowsMessage(
      String defaultError, Map<String, dynamic>? responseData) {
    if (responseData != null) {
      try {
        ApiError apiError = ApiError.fromJson(responseData);
        return apiError.desc;
      } catch (e) {}
    }

    return defaultError;
  }
}
