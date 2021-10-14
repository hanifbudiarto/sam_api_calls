part of sam_impl;

class ApiEndpoints {
  static const String HOST = 'https://iot.samelement.com';
  static const String BASE_URL = '$HOST/api/en';

  //#region User
  static const String USER = '/user';
  static const String TOKENS = '/tokens';
  static const String USER_AVATAR = '/useravatar';
  static const String CITIES = '/cities';
  static const String COUNTRIES = '/countries';
  //#endregion

  //#region Device
  static const String DEVICES = '/devices';
  static const String DEVICES_SHARED = '/devicesshared';
  static const String DEVICES_LOGS = '/deviceslogs';
  //#endregion

  //#region Analytic
  static const String ANALYTICS = '/analytics';
  static const String ANALYTICS_SHARED = '/analyticsshared';
  static const String ANALYTICS_RESOURCES = '/analyticsresources';
  //#endregion

  //#region Share
  static const String SHARE = '/share';
  //#endregion

  //#region Dashboards
  static const String DASHBOARDS = '/dashboards';
  //#endregion

  //#region Auth
  static const String AUTH = '/auth';
  //#endregion
}