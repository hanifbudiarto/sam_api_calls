part of sam_impl;

class AppServiceImpl extends AppService {
  static const String TAG = "AppServiceImpl";
  final Dio dio;
  final BaseLogger logger;

  AppServiceImpl({required this.dio, required this.logger});

  @override
  Future<UserAccount> getUserAccountByEmail(String email) async {
    try {
      return await dio.get(ApiEndpoints.USER, queryParameters: {
        'user_email': email,
        'profile': 2
      }).then((value) => UserAccount.fromJson(value.data['body']));
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to get user account by email',
          meta: {'email': email});
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

      return await dio
          .post(ApiEndpoints.USER, queryParameters: {'profile': 0}, data: body)
          .then((value) {
        if (value.data.containsKey('body')) {
          return UserProfile.fromJson(value.data['body']);
        }
        logger.debug(TAG, "Results not valid postNewUser", {
          'user_fname': '${user.userFname}',
          'user_lname': '${user.userLname}',
          'user_email': '${user.userEmail}'
        });
        throw 'Results not valid';
      });
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to register new user',
          meta: {
            'user_fname': '${user.userFname}',
            'user_lname': '${user.userLname}',
            'user_email': '${user.userEmail}'
          });
    }
  }

  @override
  Future<bool> putRequestResetPassword(String accountId) async {
    try {
      return await dio.put('${ApiEndpoints.USER}/$accountId',
          queryParameters: {'profile': 5}).then((value) => true);
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to request password reset',
          meta: {'user': accountId});
    }
  }

  @override
  Future<bool> putResetPassword(
      String accountId, String verificationCode, String newPassword) async {
    try {
      final String body = json.encode(
          {'vcode': '$verificationCode', 'user_newpwd': '$newPassword'});

      return await dio
          .put('${ApiEndpoints.USER}/$accountId',
              queryParameters: {'profile': 5}, data: body)
          .then((value) => true);
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to reset password',
          meta: {'user': accountId});
    }
  }

  @override
  Future<bool> putVerify(String userId, String verificationCode) async {
    try {
      final String body = json.encode({'vcode': '$verificationCode'});

      return await dio
          .put('${ApiEndpoints.USER}/$userId',
              queryParameters: {'profile': 3}, data: body)
          .then((value) => true);
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to verify user',
          meta: {'user': userId});
    }
  }

  @override
  Future<WhiteLabel> getWhiteLabel() async {
    try {
      return await dio
          .get(ApiEndpoints.WHITE_LABEL)
          .then((value) => WhiteLabel.fromJson(value.data['body']));
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to get white label');
    }
  }
}
