part of sam_impl;

class DataServiceImpl extends DataService {
  static const String BROKER = 'iot.samelement.com';
  static const String BROKER_SSL = 'ssl';
  static const int BROKER_PORT = 8883;
  final Dio _dio;

  DataServiceImpl({required Dio dio}) : this._dio = dio;

  @override
  Future<bool> deleteDashboard(String profileId) async {
    try {
      return await _dio
          .delete('${ApiEndpoints.DASHBOARDS}/$profileId')
          .then((value) => true);
    } on DioError catch (_) {
      throw 'Failed to delete dashboard profile';
    }
  }

  @override
  Future<DashboardProfiles> getAllDashboards() async {
    try {
      return await _dio
          .get(ApiEndpoints.DASHBOARDS,
              queryParameters: {'limit': 1000},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) {
        try {
          return DashboardProfiles.fromJson(value.data);
        } catch (e) {}

        return DashboardProfiles(list: []);
      });
    } on DioError catch (_) {
      throw 'Failed to get all dashboards';
    }
  }

  @override
  Future<DashboardProfiles> getDashboardsById(String id) async {
    try {
      return await _dio
          .get('${ApiEndpoints.DASHBOARDS}/$id',
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => DashboardProfiles.fromJson(value.data));
    } on DioError catch (_) {
      throw 'Failed to get dashboard by id $id';
    }
  }

  @override
  Future<DashboardProfile> postEmptyDashboardProfile(String name) async {
    try {
      final String body = json.encode({
        'name': name,
        'data': {'items': [] }
      });
      return await _dio
          .post(ApiEndpoints.DASHBOARDS, data: body)
          .then((value) => DashboardProfile.fromJson(value.data['body']));
    } on DioError catch (_) {
      throw 'Failed to create dashboard profile';
    }
  }

  @override
  Future<bool> putDashboard(DashboardProfile newProfile) async {
    try {
      return await _dio
          .put('${ApiEndpoints.DASHBOARDS}/${newProfile.id}',
              data: json.encode(newProfile))
          .then((value) => true);
    } on DioError catch (_) {
      throw 'Failed to update dashboard profile';
    }
  }

  @override
  Future<Cities> getCitiesByKeyword(String keyword) async {
    try {
      return await _dio
          .get(ApiEndpoints.CITIES,
              queryParameters: {'search': keyword},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => Cities.fromJson(value.data));
    } on DioError catch (_) {
      throw 'Failed to get cities';
    }
  }

  @override
  Future<Countries> getCountriesByCode(String code) async {
    try {
      return await _dio
          .get('${ApiEndpoints.COUNTRIES}/$code',
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => Countries.fromJson(value.data));
    } on DioError catch (_) {
      throw 'Failed to get countries';
    }
  }

  @override
  Future<UserAvatar> getAvatar() async {
    try {
      return await _dio
          .get(ApiEndpoints.USER_AVATAR)
          .then((value) => UserAvatar.fromJson(value.data));
    } on DioError catch (_) {
      throw 'Failed to get user avatar';
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
        'profile': 2
      }).then((value) => UserAccount.fromJson(value.data['body']));
    } on DioError catch (_) {
      throw 'Failed to get user account';
    }
  }

  @override
  Future<bool> postUploadAvatar(File image) async {
    try {
      FormData formData = FormData.fromMap({
        'user_avatar': await MultipartFile.fromFile(
          image.path,
          filename: basename(image.path),
        ),
      });

      return await _dio
          .post(ApiEndpoints.USER_AVATAR, data: formData)
          .then((value) => true);
    } on DioError catch (_) {
      throw 'Failed to upload user avatar';
    }
  }

  @override
  Future<bool> putUserOrganization(UserOrganization organization) async {
    try {
      final String body = json.encode({
        'org_name': '${organization.orgName}',
        'org_addr1': '${organization.orgAddr1}',
        'org_addr2': '${organization.orgAddr2}',
        'org_city': '${organization.orgCity}',
        'org_province': '${organization.orgProvince}',
        'org_country': '${organization.orgCountry}',
        'org_zip': '${organization.orgZip}',
        'org_web': '${organization.orgWeb}',
        'org_email': '${organization.orgEmail}',
        'org_phone': '${organization.orgPhone}'
      });

      return await _dio
          .put('${ApiEndpoints.USER}/${organization.userId}',
              queryParameters: {'profile': 1}, data: body)
          .then((value) => true);
    } on DioError catch (_) {
      throw 'Failed to update user organization';
    }
  }

  @override
  Future<bool> putUserProfile(UserProfile profile) async {
    try {
      final String body = json.encode({
        'user_fname': '${profile.userFname}',
        'user_lname': '${profile.userLname}',
        'user_phone': '${profile.userPhone}',
        'user_email': '${profile.userEmail}'
      });

      return await _dio
          .put('${ApiEndpoints.USER}/${profile.userId}',
              queryParameters: {'profile': 0}, data: body)
          .then((value) => true);
    } on DioError catch (_) {
      throw 'Failed to update user profile';
    }
  }

  @override
  Future<bool> deleteDevice(String deviceId) async {
    try {
      return await _dio
          .delete('${ApiEndpoints.DEVICES}/$deviceId')
          .then((value) => true);
    } on DioError catch (_) {
      throw 'Failed to delete device';
    }
  }

  @override
  Future<bool> deleteUnlinkDeviceFromUser(
      String deviceId, String userId) async {
    try {
      return await _dio.delete(
        '${ApiEndpoints.DEVICES_SHARED}/$deviceId',
        queryParameters: {'user_id': userId},
      ).then((value) => true);
    } on DioError catch (_) {
      throw 'Failed to delete unlinked device from user';
    }
  }

  @override
  Future<Devices> getAllDevices() async {
    try {
      return await _dio
          .get(ApiEndpoints.DEVICES,
              queryParameters: {'limit': 1000},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => Devices.fromJson(value.data));
    } on DioError catch (_) {
      throw 'Failed to get all devices';
    }
  }

  @override
  Future<Devices> getDeviceById(String id) async {
    try {
      return await _dio
          .get('${ApiEndpoints.DEVICES}/$id',
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => Devices.fromJson(value.data));
    } on DioError catch (_) {
      throw 'Failed to get a device by id';
    }
  }

  @override
  Future<Devices> getDeviceBySN(String sn) async {
    try {
      return await _dio
          .get(ApiEndpoints.DEVICES,
              queryParameters: {'sn': sn, 'unclaim': 1},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => Devices.fromJson(value.data));
    } on DioError catch (_) {
      throw 'Failed to get a device by serial number';
    }
  }

  @override
  Future<Devices> getDeviceByVcodeId(String vcode, String id) async {
    try {
      return await _dio
          .get(ApiEndpoints.DEVICES,
              queryParameters: {'vcode': vcode, 'device_id': id},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => Devices.fromJson(value.data));
    } on DioError catch (_) {
      throw 'Failed to get a device by verification code id';
    }
  }

  @override
  Future<Devices> getDevices(
      {int limit = 0, int offset = 0, String keyword = ''}) async {
    try {
      return await _dio
          .get(ApiEndpoints.DEVICES,
              queryParameters: {
                'limit': limit,
                'offset': offset,
                'search': keyword
              },
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => Devices.fromJson(value.data));
    } on DioError catch (_) {
      throw 'Failed to get devices';
    }
  }

  @override
  Future<SharedDevices> getSharedDevices() async {
    try {
      return await _dio
          .get('${ApiEndpoints.SHARE}/0',
              queryParameters: {'limit': 1000},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => SharedDevices.fromJson(value.data));
    } on DioError catch (_) {
      throw 'Failed to all shared devices';
    }
  }

  @override
  Future<SharedUsers> getSharedUserByDeviceId(String deviceId) async {
    try {
      return await _dio
          .get('${ApiEndpoints.DEVICES_SHARED}/$deviceId',
              queryParameters: {'limit': 1000},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => SharedUsers.fromJson(value.data));
    } on DioError catch (_) {
      throw 'Failed to all shared users';
    }
  }

  @override
  Future<bool> postAcceptSharedDevice(String deviceId, String vcode) async {
    try {
      final String body = json.encode({'device_id': deviceId, 'vcode': vcode});
      return await _dio
          .post('${ApiEndpoints.SHARE}/2', data: body)
          .then((value) => true);
    } on DioError catch (_) {
      throw getThrowsMessage(
          'Failed to accept this shared device', _.response!.data);
    }
  }

  @override
  Future<bool> postIgnoreSharedDevice(String deviceId, String vcode) async {
    try {
      final String body = json.encode({'device_id': deviceId, 'vcode': vcode});
      return await _dio
          .post('${ApiEndpoints.SHARE}/3', data: body)
          .then((value) => true);
    } on DioError catch (_) {
      throw getThrowsMessage(
          'Failed to discard this shared device', _.response!.data);
    }
  }

  @override
  Future<String> postShareDeviceViaEmail(
      String deviceId, String? destinationEmail) async {
    try {
      final String body = json.encode({
        'device_id': deviceId,
        'email': (destinationEmail != null) ? destinationEmail : ''
      });
      return await _dio
          .post('${ApiEndpoints.SHARE}/0', data: body)
          .then((value) => value.data['vcode']);
    } on DioError catch (_) {
      throw 'Failed to share this device via email';
    }
  }

  @override
  Future<bool> putClaimDevice(DeviceClaimParam param) async {
    try {
      final String body = json.encode({
        'sn': '${param.sn}',
        'model': '${param.model}',
        'name': '${param.name}',
        'desc': '${param.desc}',
        'map_lat': '${param.mapLat}',
        'map_lng': '${param.mapLng}',
        'logo': '${param.logo}',
        'admin_id': '${param.userId}',
        'status': '${param.status}',
        'unclaim': '0'
      });
      return await _dio
          .put('${ApiEndpoints.DEVICES}/${param.id}', data: body)
          .then((value) => true);
    } on DioError catch (_) {
      throw 'Failed to claim this device';
    }
  }

  @override
  Future<bool> putDevice(DeviceClaimParam param, DeviceOption options) async {
    try {
      final String body = json.encode({
        'sn': '${param.sn}',
        'model': '${param.model}',
        'name': '${param.name}',
        'desc': '${param.desc}',
        'map_lat': '${param.mapLat}',
        'map_lng': '${param.mapLng}',
        'logo': '${param.logo}',
        'admin_id': '${param.userId}',
        'status': '${param.status}',
        'options': options
      });
      return await _dio
          .put('${ApiEndpoints.DEVICES}/${param.id}', data: body)
          .then((value) => true);
    } on DioError catch (_) {
      throw 'Failed to update this device properties';
    }
  }

  @override
  Future<bool> deleteAnalytic(String analyticId) async {
    try {
      return await _dio
          .delete('${ApiEndpoints.ANALYTICS}/$analyticId')
          .then((value) => true);
    } on DioError catch (_) {
      throw 'Failed to delete this widget resources';
    }
  }

  @override
  Future<bool> deleteAnalyticsResourcesByAnalytic(String analyticId) async {
    try {
      return await _dio
          .delete('${ApiEndpoints.ANALYTICS_RESOURCES}/$analyticId')
          .then((value) => true);
    } on DioError catch (_) {
      throw 'Failed to delete this widget resources';
    }
  }

  @override
  Future<bool> deleteUnlinkAnalyticFromUser(
      String analyticId, String userId) async {
    try {
      return await _dio.delete(
        '${ApiEndpoints.ANALYTICS_SHARED}/$analyticId',
        queryParameters: {'user_id': userId},
      ).then((value) => true);
    } on DioError catch (_) {
      throw 'Failed to unlink this user from the widget';
    }
  }

  @override
  Future<Analytics> getAnalyticById(String id) async {
    try {
      return await _dio
          .get('${ApiEndpoints.ANALYTICS}/$id',
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => Analytics.fromJson(value.data));
    } on DioError catch (_) {
      throw 'Failed to get widget by id';
    }
  }

  @override
  Future<Analytics> getAnalyticByVcodeId(String vcode, String id) async {
    try {
      return await _dio
          .get(ApiEndpoints.ANALYTICS,
              queryParameters: {'vcode': vcode, 'analytic_id': id},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => Analytics.fromJson(value.data));
    } on DioError catch (_) {
      throw 'Failed to get widget by vcode id';
    }
  }

  @override
  Future<Analytics> getAnalytics(
      {int limit = 0, int offset = 0, String keyword = ''}) async {
    try {
      return await _dio
          .get(ApiEndpoints.ANALYTICS,
              queryParameters: {
                'limit': limit,
                'offset': offset,
                'search': keyword
              },
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => Analytics.fromJson(value.data));
    } on DioError catch (_) {
      throw 'Failed to get widgets with that keyword';
    }
  }

  @override
  Future<AnalyticsResources> getAnalyticsResources(String analyticId) async {
    try {
      return await _dio
          .get('${ApiEndpoints.ANALYTICS_RESOURCES}/$analyticId',
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => AnalyticsResources.fromJson(value.data));
    } on DioError catch (_) {
      throw "Failed to get this widget's resources";
    }
  }

  @override
  Future<DevicesLogs> getDevicesLogs(DevicesLogsParam param,
      {DateTime? timeStart}) async {
    try {
      DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
      if (timeStart == null) {
        timeStart = DateTime.now().subtract(Duration(days: 30)).toUtc();
      }

      return await _dio
          .get('${ApiEndpoints.DEVICES_LOGS}/${param.deviceId}',
              queryParameters: {
                'parameter': param.deviceParameter,
                'communication': 'mqtt',
                'limit': 1000000000,
                'ts': formatter.format(timeStart).substring(0, 10),
                'sortorder': 'desc'
              },
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) {
        Property? prop = DevicePropertiesHelper.getPropertyByDeviceParameter(
            param.deviceParameter, param.device);
        if (prop != null) {
          var devicesLogs = DevicesLogs.fromJson(value.data, prop);
          int maxLimit = param.limit > devicesLogs.list.length
              ? devicesLogs.list.length
              : param.limit;

          return DevicesLogs(
              list: devicesLogs.list.getRange(0, maxLimit).toList());
        }
        return DevicesLogs(list: <SensorData>[]);
      });
    } on DioError catch (_) {
      throw 'Failed to get this device logs';
    }
  }

  @override
  Future<Analytics> getMyAnalytics() async {
    try {
      return await _dio
          .get(ApiEndpoints.ANALYTICS,
              queryParameters: {'limit': 1000},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => Analytics.fromJson(value.data));
    } on DioError catch (_) {
      throw 'Failed to get all widgets';
    }
  }

  @override
  Future<SharedAnalytics> getSharedAnalytics() async {
    try {
      return await _dio
          .get('${ApiEndpoints.SHARE}/1',
              queryParameters: {'limit': 1000},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => SharedAnalytics.fromJson(value.data));
    } on DioError catch (_) {
      throw 'Failed to get all shared widgets';
    }
  }

  @override
  Future<SharedUsers> getSharedUserByAnalyticId(String analyticId) async {
    try {
      return await _dio
          .get('${ApiEndpoints.ANALYTICS_SHARED}/$analyticId',
              queryParameters: {'limit': 1000},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => SharedUsers.fromJson(value.data));
    } on DioError catch (_) {
      throw 'Failed to get shared users';
    }
  }

  @override
  Future<StyledDevicesLogs> getStyledDevicesLogs(
      DevicesLogsParam param, LogsStyle style, int timeframeMinutes,
      {int? limit}) async {
    try {
      return await _dio
          .get('${ApiEndpoints.DEVICES_LOGS}/${param.deviceId}',
              queryParameters: {
                'parameter': param.deviceParameter,
                'communication': 'mqtt',
                'limit': limit,
                'sortorder': 'desc',
                'style': style.name,
                'tf': timeframeMinutes
              },
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) => StyledDevicesLogs.fromJson(value.data));
    } on DioError catch (_) {
      throw 'Failed to get devices logs';
    }
  }

  @override
  Future<bool> postAcceptSharedAnalytic(String analyticId, String vcode) async {
    try {
      final String body =
          json.encode({'analytic_id': analyticId, 'vcode': vcode});

      return await _dio
          .post('${ApiEndpoints.SHARE}/2', data: body)
          .then((value) => true);
    } on DioError catch (_) {
      throw getThrowsMessage('Failed to accept this widget', _.response!.data);
    }
  }

  @override
  Future<bool> postAnalyticsResources(AnalyticResource analyticResource) async {
    try {
      final String body = json.encode({
        'analytic_id': analyticResource.analyticId,
        'resources': analyticResource.resources
      });
      return await _dio
          .post('${ApiEndpoints.ANALYTICS_RESOURCES}', data: body)
          .then((value) => true);
    } on DioError catch (_) {
      throw 'Failed to update this widget resources';
    }
  }

  @override
  Future<bool> postIgnoreSharedAnalytic(String analyticId, String vcode) async {
    try {
      final String body =
          json.encode({'analytic_id': analyticId, 'vcode': vcode});
      return await _dio
          .post('${ApiEndpoints.SHARE}/3', data: body)
          .then((value) => true);
    } on DioError catch (_) {
      throw getThrowsMessage(
          'Failed to discard this shared widget', _.response!.data);
    }
  }

  @override
  Future<AnalyticWidget> postNewAnalytic(AnalyticWidgetParam param) async {
    try {
      final String body = json.encode(param.toJson());

      return await _dio
          .post(ApiEndpoints.ANALYTICS, data: body)
          .then((value) => AnalyticWidget.fromJson(value.data['body']));
    } on DioError catch (_) {
      throw 'Failed to create a new widget';
    }
  }

  @override
  Future<String> postShareAnalytic(
      String analyticId, String? destinationEmail) async {
    try {
      final String body = json.encode({
        'analytic_id': analyticId,
        'email': (destinationEmail != null) ? destinationEmail : ''
      });
      return await _dio
          .post('${ApiEndpoints.SHARE}/1', data: body)
          .then((value) => value.data['vcode']);
    } on DioError catch (_) {
      throw 'Failed to share this widget';
    }
  }

  @override
  Future<bool> putAnalytic(String analyticId, AnalyticWidgetParam param) async {
    try {
      final String body = json.encode(
          {'title': param.title, 'model': param.model, 'options': param.options});
      return await _dio
          .put('${ApiEndpoints.ANALYTICS}/$analyticId', data: body)
          .then((value) => true);
    } on DioError catch (_) {
      throw 'Failed to update this widget';
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
