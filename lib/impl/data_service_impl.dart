import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

import '../contracts/contracts.dart';
import '../models/models.dart';
import '../util/util.dart';
import 'api_endpoints.dart';

class DataServiceImpl extends DataService {
  static const String BROKER = "iot.samelement.com";
  static const String BROKER_SSL = "ssl";
  static const int BROKER_PORT = 8883;
  final Dio _dio;

  DataServiceImpl({@required Dio dio}) : this._dio = dio;

  @override
  Future<bool> deleteDashboard(DashboardProfile profile) async {
    try {
      return await _dio
          .delete("${ApiEndpoints.DASHBOARDS}/${profile.id}")
          .then((value) => true);
    } on DioError catch (_) {
      throw "Failed to delete dashboard profile";
    }
  }

  @override
  Future<DashboardProfiles> getAllDashboards() async {
    try {
      return await _dio
          .get(ApiEndpoints.DASHBOARDS,
              queryParameters: {"limit": 1000},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) {
        try {
          return DashboardProfiles.fromJson(value.data);
        } catch (e) {}

        return DashboardProfiles(list: []);
      });
    } on DioError catch (_) {
      throw "Failed to get all dashboards";
    }
  }

  @override
  Future<DashboardProfiles> getDashboardsById(String id) async {
    try {
      return await _dio
          .get("${ApiEndpoints.DASHBOARDS}/$id",
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => DashboardProfiles.fromJson(value.data));
    } on DioError catch (_) {
      throw "Failed to get dashboard by id $id";
    }
  }

  @override
  Future<DashboardProfile> postEmptyDashboardProfile(String name) async {
    try {
      final String body = json.encode({
        "name": name,
        "data": {"items": []}
      });
      return await _dio
          .post(ApiEndpoints.DASHBOARDS, data: body)
          .then((value) => DashboardProfile.fromJson(value.data["body"]));
    } on DioError catch (_) {
      throw "Failed to create dashboard profile";
    }
  }

  @override
  Future<bool> putDashboard(DashboardProfile newProfile) async {
    try {
      return await _dio
          .put("${ApiEndpoints.DASHBOARDS}/${newProfile.id}",
              data: json.encode(newProfile))
          .then((value) => true);
    } on DioError catch (_) {
      throw "Failed to update dashboard profile";
    }
  }

  @override
  Future<Cities> getCitiesByKeyword(String keyword) async {
    try {
      return await _dio
          .get(ApiEndpoints.CITIES,
              queryParameters: {"search": keyword},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => Cities.fromJson(value.data));
    } on DioError catch (_) {
      throw "Failed to get cities";
    }
  }

  @override
  Future<Countries> getCountriesByCode(String code) async {
    try {
      return await _dio
          .get("${ApiEndpoints.COUNTRIES}/$code",
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => Countries.fromJson(value.data));
    } on DioError catch (_) {
      throw "Failed to get countries";
    }
  }

  @override
  Future<UserAvatar> getAvatar() async {
    try {
      return await _dio
          .get(ApiEndpoints.USER_AVATAR)
          .then((value) => UserAvatar.fromJson(value.data));
    } on DioError catch (_) {
      throw "Failed to get user avatar";
    }
  }

  @override
  Future<BrokerProperties> getBrokerProperties() async {
    return await Future.value(BrokerProperties(
        address: BROKER, protocol: BROKER_SSL, port: BROKER_PORT));
  }

  @override
  Future<UserAccount> getUserAccount() async {
    try {
      return await _dio.get(ApiEndpoints.USER, queryParameters: {
        "profile": 2
      }).then((value) => UserAccount.fromJson(value.data["body"]));
    } on DioError catch (_) {
      throw "Failed to get user account";
    }
  }

  @override
  Future<bool> postUploadAvatar(File image) async {
    try {
      FormData formData = FormData.fromMap({
        "user_avatar": await MultipartFile.fromFile(
          image.path,
          filename: basename(image.path),
        ),
      });

      return await _dio
          .post(ApiEndpoints.USER_AVATAR, data: formData)
          .then((value) => true);
    } on DioError catch (_) {
      throw "Failed to upload user avatar";
    }
  }

  @override
  Future<bool> putUserOrganization(UserOrganization organization) async {
    try {
      final String body = json.encode({
        "org_name": "${organization.orgName}",
        "org_addr1": "${organization.orgAddr1}",
        "org_addr2": "${organization.orgAddr2}",
        "org_city": "${organization.orgCity}",
        "org_province": "${organization.orgProvince}",
        "org_country": "${organization.orgCountry}",
        "org_zip": "${organization.orgZip}",
        "org_web": "${organization.orgWeb}",
        "org_email": "${organization.orgEmail}",
        "org_phone": "${organization.orgPhone}"
      });

      return await _dio
          .put("${ApiEndpoints.USER}/${organization.userId}",
              queryParameters: {"profile": 1}, data: body)
          .then((value) => true);
    } on DioError catch (_) {
      throw "Failed to update user organization";
    }
  }

  @override
  Future<bool> putUserProfile(UserProfile profile) async {
    try {
      final String body = json.encode({
        "user_fname": "${profile.userFname}",
        "user_lname": "${profile.userLname}",
        "user_phone": "${profile.userPhone}",
        "user_email": "${profile.userEmail}"
      });

      return await _dio
          .put("${ApiEndpoints.USER}/${profile.userId}",
              queryParameters: {"profile": 0}, data: body)
          .then((value) => true);
    } on DioError catch (_) {
      throw "Failed to update user profile";
    }
  }

  @override
  Future<bool> deleteDevice(DeviceIot device) async {
    try {
      return await _dio
          .delete("${ApiEndpoints.DEVICES}/${device.id}")
          .then((value) => true);
    } on DioError catch (_) {
      throw "Failed to delete device";
    }
  }

  @override
  Future<bool> deleteUnlinkDeviceFromUser(
      DeviceIot device, UserAccount user) async {
    try {
      return await _dio.delete(
        "${ApiEndpoints.DEVICES_SHARED}/${device.id}",
        queryParameters: {"user_id": user.userId},
      ).then((value) => true);
    } on DioError catch (_) {
      throw "Failed to delete unlinked device from user";
    }
  }

  @override
  Future<Devices> getAllDevices() async {
    try {
      return await _dio
          .get(ApiEndpoints.DEVICES,
              queryParameters: {"limit": 1000},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => Devices.fromJson(value.data));
    } on DioError catch (_) {
      throw "Failed to get all devices";
    }
  }

  @override
  Future<Devices> getDeviceById(String id) async {
    try {
      return await _dio
          .get("${ApiEndpoints.DEVICES}/$id",
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => Devices.fromJson(value.data));
    } on DioError catch (_) {
      throw "Failed to get a device by id";
    }
  }

  @override
  Future<Devices> getDeviceBySN(String sn) async {
    try {
      return await _dio
          .get(ApiEndpoints.DEVICES,
              queryParameters: {"sn": sn, "unclaim": 1},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => Devices.fromJson(value.data));
    } on DioError catch (_) {
      throw "Failed to get a device by serial number";
    }
  }

  @override
  Future<Devices> getDeviceByVcodeId(String vcode, String id) async {
    try {
      return await _dio
          .get(ApiEndpoints.DEVICES,
              queryParameters: {"vcode": vcode, "device_id": id},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => Devices.fromJson(value.data));
    } on DioError catch (_) {
      throw "Failed to get a device by verification code id";
    }
  }

  @override
  Future<Devices> getDevices(
      {int limit = 0, int offset = 0, String keyword = ""}) async {
    try {
      return await _dio
          .get(ApiEndpoints.DEVICES,
              queryParameters: {
                "limit": limit,
                "offset": offset,
                "search": keyword
              },
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => Devices.fromJson(value.data));
    } on DioError catch (_) {
      throw "Failed to get devices";
    }
  }

  @override
  Future<SharedDevices> getSharedDevices() async {
    try {
      return await _dio
          .get("${ApiEndpoints.SHARE}/0",
              queryParameters: {"limit": 1000},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => SharedDevices.fromJson(value.data));
    } on DioError catch (_) {
      throw "Failed to all shared devices";
    }
  }

  @override
  Future<SharedUsers> getSharedUserByDeviceId(DeviceIot device) async {
    try {
      return await _dio
          .get("${ApiEndpoints.DEVICES_SHARED}/${device.id}",
              queryParameters: {"limit": 1000},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => SharedUsers.fromJson(value.data));
    } on DioError catch (_) {
      throw "Failed to all shared users";
    }
  }

  @override
  Future<bool> postAcceptSharedDevice(
      DeviceIot device, String verificationCode) async {
    try {
      final String body = json
          .encode({"device_id": "${device.id}", "vcode": "$verificationCode"});
      return await _dio
          .post("${ApiEndpoints.SHARE}/2", data: body)
          .then((value) => true);
    } on DioError catch (_) {
      throw getThrowsMessage(
          "Failed to accept this shared device", _.response.data);
    }
  }

  @override
  Future<bool> postIgnoreSharedDevice(SharedDevice sharedDevice) async {
    try {
      final String body = json.encode({
        "device_id": "${sharedDevice.sharedItem.id}",
        "vcode": "${sharedDevice.vcode}"
      });
      return await _dio
          .post("${ApiEndpoints.SHARE}/3", data: body)
          .then((value) => true);
    } on DioError catch (_) {
      throw getThrowsMessage(
          "Failed to discard this shared device", _.response.data);
    }
  }

  @override
  Future<String> postShareDeviceViaEmail(
      DeviceIot device, UserAccount destinationAccount) async {
    try {
      final String body = json.encode({
        "device_id": "${device.id}",
        "email": (destinationAccount != null)
            ? "${destinationAccount.userEmail}"
            : ""
      });
      return await _dio
          .post("${ApiEndpoints.SHARE}/0", data: body)
          .then((value) => value.data["vcode"]);
    } on DioError catch (_) {
      throw "Failed to share this device via email";
    }
  }

  @override
  Future<bool> putClaimDevice(DeviceIot device, UserAccount account) async {
    try {
      final String body = json.encode({
        "sn": "${device.sn}",
        "model": "${device.model}",
        "name": "${device.name}",
        "desc": "${device.desc}",
        "map_lat": "${device.mapLat}",
        "map_lng": "${device.mapLng}",
        "logo": "${device.logo}",
        "admin_id": "${account.userId}",
        "status": "${device.status}",
        "unclaim": "0"
      });
      return await _dio
          .put("${ApiEndpoints.DEVICES}/${device.id}", data: body)
          .then((value) => true);
    } on DioError catch (_) {
      throw "Failed to claim this device";
    }
  }

  @override
  Future<bool> putDevice(DeviceIot device) async {
    try {
      final String body = json.encode({
        "sn": "${device.sn}",
        "model": "${device.model}",
        "name": "${device.name}",
        "desc": "${device.desc}",
        "map_lat": "${device.mapLat}",
        "map_lng": "${device.mapLng}",
        "logo": "${device.logo}",
        "admin_id": "${device.adminId}",
        "status": "${device.status}",
        "options": device.options
      });
      return await _dio
          .put("${ApiEndpoints.DEVICES}/${device.id}", data: body)
          .then((value) => true);
    } on DioError catch (_) {
      throw "Failed to update this device properties";
    }
  }

  @override
  Future<bool> deleteAnalytic(AnalyticWidget analytic) async {
    try {
      return await _dio
          .delete("${ApiEndpoints.ANALYTICS}/${analytic.id}")
          .then((value) => true);
    } on DioError catch (_) {
      throw "Failed to delete this widget resources";
    }
  }

  @override
  Future<bool> deleteAnalyticsResourcesByAnalytic(
      AnalyticWidget analytic) async {
    try {
      return await _dio
          .delete("${ApiEndpoints.ANALYTICS_RESOURCES}/${analytic.id}")
          .then((value) => true);
    } on DioError catch (_) {
      throw "Failed to delete this widget resources";
    }
  }

  @override
  Future<bool> deleteUnlinkAnalyticFromUser(
      AnalyticWidget analytic, UserAccount user) async {
    try {
      return await _dio.delete(
        "${ApiEndpoints.ANALYTICS_SHARED}/${analytic.id}",
        queryParameters: {"user_id": user.userId},
      ).then((value) => true);
    } on DioError catch (_) {
      throw "Failed to unlink this user from the widget";
    }
  }

  @override
  Future<Analytics> getAnalyticById(String id) async {
    try {
      return await _dio
          .get("${ApiEndpoints.ANALYTICS}/$id",
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => Analytics.fromJson(value.data));
    } on DioError catch (_) {
      throw "Failed to get widget by id";
    }
  }

  @override
  Future<Analytics> getAnalyticByVcodeId(String vcode, String id) async {
    try {
      return await _dio
          .get(ApiEndpoints.ANALYTICS,
              queryParameters: {"vcode": vcode, "analytic_id": id},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => Analytics.fromJson(value.data));
    } on DioError catch (_) {
      throw "Failed to get widget by vcode id";
    }
  }

  @override
  Future<Analytics> getAnalytics(
      {int limit = 0, int offset = 0, String keyword = ""}) async {
    try {
      return await _dio
          .get(ApiEndpoints.ANALYTICS,
              queryParameters: {
                "limit": limit,
                "offset": offset,
                "search": keyword
              },
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => Analytics.fromJson(value.data));
    } on DioError catch (_) {
      throw "Failed to get widgets with that keyword";
    }
  }

  @override
  Future<AnalyticsResources> getAnalyticsResources(
      AnalyticWidget analytic) async {
    try {
      return await _dio
          .get("${ApiEndpoints.ANALYTICS_RESOURCES}/${analytic.id}",
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => AnalyticsResources.fromJson(value.data));
    } on DioError catch (_) {
      throw "Failed to get this widget's resources";
    }
  }

  @override
  Future<DevicesLogs> getDevicesLogs(Resource resource,
      {int limit, DateTime timeStart}) async {
    try {
      DateFormat formatter = DateFormat("yyyy-MM-dd HH:mm:ss");
      if (timeStart == null) {
        timeStart = DateTime.now().subtract(Duration(days: 30)).toUtc();
      }

      Property prop = DevicePropertiesHelper.getPropertyByDeviceParameter(
          resource.deviceParameter, resource.device);

      return await _dio
          .get("${ApiEndpoints.DEVICES_LOGS}/${resource.deviceId}",
              queryParameters: {
                "parameter": resource.deviceParameter,
                "communication": "mqtt",
                "limit": limit,
                "ts": formatter.format(timeStart),
                "sortorder": "desc"
              },
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => DevicesLogs.fromJson(value.data, prop));
    } on DioError catch (_) {
      throw "Failed to get this device logs";
    }
  }

  @override
  Future<Analytics> getMyAnalytics() async {
    try {
      return await _dio
          .get(ApiEndpoints.ANALYTICS,
              queryParameters: {"limit": 1000},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => Analytics.fromJson(value.data));
    } on DioError catch (_) {
      throw "Failed to get all widgets";
    }
  }

  @override
  Future<SharedAnalytics> getSharedAnalytics() async {
    try {
      return await _dio
          .get("${ApiEndpoints.SHARE}/1",
              queryParameters: {"limit": 1000},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => SharedAnalytics.fromJson(value.data));
    } on DioError catch (_) {
      throw "Failed to get all shared widgets";
    }
  }

  @override
  Future<SharedUsers> getSharedUserByAnalyticId(AnalyticWidget analytic) async {
    try {
      return await _dio
          .get("${ApiEndpoints.ANALYTICS_SHARED}/${analytic.id}",
              queryParameters: {"limit": 1000},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => SharedUsers.fromJson(value.data));
    } on DioError catch (_) {
      throw "Failed to get shared users";
    }
  }

  @override
  Future<StyledDevicesLogs> getStyledDevicesLogs(Resource resource,
      {int limit, String style, int timeframe}) async {
    try {
      return await _dio
          .get("${ApiEndpoints.DEVICES_LOGS}/${resource.deviceId}",
              queryParameters: {
                "parameter": resource.deviceParameter,
                "communication": "mqtt",
                "limit": limit,
                "sortorder": "desc",
                "style": style,
                "tf": timeframe
              },
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => StyledDevicesLogs.fromJson(value.data));
    } on DioError catch (_) {
      throw "Failed to get devices logs";
    }
  }

  @override
  Future<bool> postAcceptSharedAnalytic(
      AnalyticWidget analytic, String verificationCode) async {
    try {
      final String body = json.encode(
          {"analytic_id": "${analytic.id}", "vcode": "$verificationCode"});

      return await _dio
          .post("${ApiEndpoints.SHARE}/2", data: body)
          .then((value) => true);
    } on DioError catch (_) {
      throw getThrowsMessage("Failed to accept this widget", _.response.data);
    }
  }

  @override
  Future<bool> postAnalyticsResources(AnalyticResource analyticResource) async {
    try {
      final String body = json.encode({
        "analytic_id": analyticResource.analyticId,
        "resources": analyticResource.resources
      });
      return await _dio
          .post("${ApiEndpoints.ANALYTICS_RESOURCES}", data: body)
          .then((value) => true);
    } on DioError catch (_) {
      throw "Failed to update this widget resources";
    }
  }

  @override
  Future<bool> postIgnoreSharedAnalytic(SharedAnalytic sharedAnalytic) async {
    try {
      final String body = json.encode({
        "analytic_id": "${sharedAnalytic.sharedItem.id}",
        "vcode": "${sharedAnalytic.vcode}"
      });
      return await _dio
          .post("${ApiEndpoints.SHARE}/3", data: body)
          .then((value) => true);
    } on DioError catch (_) {
      throw getThrowsMessage(
          "Failed to discard this shared widget", _.response.data);
    }
  }

  @override
  Future<AnalyticWidget> postNewAnalytic(AnalyticWidget analytic) async {
    try {
      final String body = json.encode(analytic.toJson());

      return await _dio
          .post(ApiEndpoints.ANALYTICS, data: body)
          .then((value) => AnalyticWidget.fromJson(value.data["body"]));
    } on DioError catch (_) {
      throw "Failed to create a new widget";
    }
  }

  @override
  Future<String> postShareAnalytic(
      AnalyticWidget analytic, UserAccount destinationAccount) async {
    try {
      final String body = json.encode({
        "analytic_id": "${analytic.id}",
        "email": (destinationAccount != null)
            ? "${destinationAccount.userEmail}"
            : ""
      });
      return await _dio
          .post("${ApiEndpoints.SHARE}/1", data: body)
          .then((value) => value.data["vcode"]);
    } on DioError catch (_) {
      throw "Failed to share this widget";
    }
  }

  @override
  Future<bool> putAnalytic(AnalyticWidget analytic) async {
    try {
      final String body = json.encode({
        "title": analytic.title,
        "model": analytic.model,
        "options": analytic.options
      });
      return await _dio
          .put("${ApiEndpoints.ANALYTICS}/${analytic.id}", data: body)
          .then((value) => true);
    } on DioError catch (_) {
      throw "Failed to update this widget";
    }
  }

  @override
  String getThrowsMessage(
      String defaultError, Map<String, dynamic> responseData) {
    try {
      ApiError apiError = ApiError.fromJson(responseData);
      defaultError = apiError.desc;
    } catch (e) {}

    return defaultError;
  }
}
