import 'package:sam_api_calls/models/models.dart';

abstract class AppService {
  Future<UserProfile> postNewUser(UserAccount user);

  Future<bool> putVerify(String userId, String verificationCode);

  Future<bool> putRequestResetPassword(UserAccount account);

  Future<bool> putResetPassword(UserAccount account, String verificationCode);

  Future<UserAccount> getUserAccountByEmail(String email);

  String getThrowsMessage(String defaultError, Map<String, dynamic> responseData);
}