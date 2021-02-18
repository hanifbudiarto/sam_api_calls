class ApiEndpoints {
  static const String HOST = "https://iot.samelement.com";
  static const String BASE_URL = "$HOST/api/en";

  // user
  static const String USER = "/user";
  static const String TOKENS = "/tokens";
  static const String USER_AVATAR = "/useravatar";
  static const String CITIES = "/cities";
  static const String COUNTRIES = "/countries";

  // device
  static const String DEVICES = "/devices";
  static const String DEVICES_SHARED = "/devicesshared";
  static const String DEVICES_LOGS = "/deviceslogs";

  // analytic
  static const String ANALYTICS = "/analytics";
  static const String ANALYTICS_SHARED = "/analyticsshared";
  static const String ANALYTICS_RESOURCES = "/analyticsresources";

  // share
  static const String SHARE = "/share";

  // dashboards
  static const String DASHBOARDS = "/dashboards";

  // oauth
  static const String AUTH = "/auth";
}