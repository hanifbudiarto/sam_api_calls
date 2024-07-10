part of sam_utils;

class HttpHelper {
  static String decodeErrorResponse(dynamic e,
      {required String tag,
      required BaseLogger logger,
      required String defaultErrorMessage,
      Map<String, dynamic>? meta}) {
    Map data = {"statusCode": -1, "message": defaultErrorMessage};
    if (e is DioError) {
      print("DioError thrown, ${e.type}");
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        data["message"] = "Your request has timed out. Please try again later";
        data["statusCode"] = 408;
      } else if (e.type == DioErrorType.connectionError || e.error is SocketException) {
        data["message"] =
            "Connection failed. Please check your internet connection!";
      } else if (e.type == DioErrorType.badResponse) {
        Response? response = e.response;
        if (response != null && response.data != null) {
          try {
            ApiError apiError = ApiError.fromJson(response.data);
            data["message"] = apiError.desc;
            data["statusCode"] = response.statusCode;
          } catch (error) {
            data["message"] = "Response error, ${error.toString()}";
          }
        } else {
          data["message"] = "Unknown error, ${e.toString()}";
        }
      } else if (e.type == DioErrorType.badCertificate) {
        data["message"] = "Invalid certificate";
      } else if (e.type == DioErrorType.unknown) {
        data["message"] = "Unknown error, ${e.toString()}";
      }
    }

    logger.error(tag, data["message"], meta);

    return data["message"];
  }
}
