part of sam_utils;

class ApiHelper {
  static const String HEADER_API_KEY = "Api-Key";

  static String buildEncodedBasicAuth(String username, String password) {
    return "Basic " + base64Encode(utf8.encode("$username:$password"));
  }

  static String buildBearerAuth(String token) {
    return "Bearer " + token;
  }
}
