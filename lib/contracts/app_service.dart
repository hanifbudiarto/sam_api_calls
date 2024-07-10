part of sam_contracts;
/*
* Null Safety Rules :
* - arguments should not be null
* - throws exception if something happens, prevent null checking
* - return a default value for String
*/

abstract class AppService {
  Future<UserProfile> postNewUser(UserProfile user, String password);

  Future<bool> putVerify(String userId, String verificationCode);

  Future<bool> putRequestResetPassword(String accountId);

  Future<bool> putResetPassword(
      String accountId, String verificationCode, String newPassword);

  Future<UserAccount> getUserAccountByEmail(String email);

  Future<WhiteLabel> getWhiteLabel();
}
