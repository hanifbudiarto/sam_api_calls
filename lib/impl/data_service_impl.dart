part of sam_impl;

class DataServiceImpl extends DataService {
  static const String TAG = "DataServiceImpl";
  final Dio dio;
  final BaseLogger logger;
  final BrokerProperties broker;

  DataServiceImpl(
      {required this.dio, required this.logger, required this.broker});

  @override
  Future<bool> deleteDashboard(String profileId) async {
    try {
      return await dio
          .delete('${ApiEndpoints.DASHBOARDS}/$profileId')
          .then((value) => true);
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to delete dashboard profile',
          meta: {'profileId': profileId, 'method': 'deleteDashboard'});
    }
  }

  @override
  Future<DashboardProfiles> getAllDashboards() async {
    try {
      return await dio
          .get(ApiEndpoints.DASHBOARDS,
              queryParameters: {'limit': 1000000},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) {
        try {
          return DashboardProfiles.fromJson(value.data);
        } catch (e) {
          logger.error(TAG, e.toString(), {'method': 'getAllDashboards'});
        }

        return DashboardProfiles(list: []);
      });
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to get all dashboards',
          meta: {'method': 'getAllDashboards'});
    }
  }

  @override
  Future<DashboardProfiles> getDashboardsById(String id) async {
    try {
      return await dio
          .get('${ApiEndpoints.DASHBOARDS}/$id',
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) {
        try {
          return DashboardProfiles.fromJson(value.data);
        } catch (e) {
          logger.error(TAG, e.toString(), {'method': 'getDashboardsById'});
        }

        return DashboardProfiles(list: []);
      });
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to get dashboard by id $id',
          meta: {'id': id, 'method': 'getDashboardsById'});
    }
  }

  @override
  Future<DashboardProfile> postEmptyDashboardProfile(String name) async {
    try {
      final String body = json.encode({
        'name': name,
        'data': {'items': []}
      });
      return await dio
          .post(ApiEndpoints.DASHBOARDS, data: body)
          .then((value) => DashboardProfile.fromJson(value.data['body']));
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to create dashboard profile',
          meta: {'name': name, 'method': 'postEmptyDashboardProfile'});
    }
  }

  @override
  Future<bool> putDashboard(DashboardProfile newProfile) async {
    try {
      return await dio
          .put('${ApiEndpoints.DASHBOARDS}/${newProfile.id}',
              data: json.encode(newProfile))
          .then((value) => true);
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to update dashboard profile',
          meta: {'profileId': newProfile.id, 'method': 'putDashboard'});
    }
  }

  @override
  Future<Cities> getCitiesByKeyword(String keyword) async {
    try {
      return await dio
          .get(ApiEndpoints.CITIES,
              queryParameters: {'search': keyword},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) {
        try {
          return Cities.fromJson(value.data);
        } catch (e) {
          logger.error(TAG, e.toString(), {'method': 'getCitiesByKeyword'});
        }

        return Cities(list: []);
      });
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to get cities',
          meta: {'keyword': keyword, 'method': 'getCitiesByKeyword'});
    }
  }

  @override
  Future<Countries> getCountriesByCode(String code) async {
    try {
      return await dio
          .get('${ApiEndpoints.COUNTRIES}/$code',
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) {
        try {
          return Countries.fromJson(value.data);
        } catch (e) {
          logger.error(TAG, e.toString(), {'method': 'getCountriesByCode'});
        }

        return Countries(list: []);
      });
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to get countries',
          meta: {'code': code, 'method': 'getCountriesByCode'});
    }
  }

  @override
  Future<UserAvatar> getAvatar() async {
    try {
      return await dio
          .get(ApiEndpoints.USER_AVATAR)
          .then((value) => UserAvatar.fromJson(value.data));
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to get user avatar',
          meta: {'method': 'getAvatar'});
    }
  }

  @override
  Future<BrokerProperties> getBrokerProperties() async {
    return await Future.value(broker);
  }

  @override
  Future<UserAccount> getUserAccount() async {
    try {
      return await dio.get(ApiEndpoints.USER, queryParameters: {
        'profile': 2
      }).then((value) => UserAccount.fromJson(value.data['body']));
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to get user account',
          meta: {'method': 'getUserAccount'});
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

      return await dio
          .post(ApiEndpoints.USER_AVATAR, data: formData)
          .then((value) => true);
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to upload user avatar',
          meta: {'meta': 'postUploadAvatar'});
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

      return await dio
          .put('${ApiEndpoints.USER}/${organization.userId}',
              queryParameters: {'profile': 1}, data: body)
          .then((value) => true);
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to update user organization',
          meta: {'method': 'putUserOrganization'});
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

      return await dio
          .put('${ApiEndpoints.USER}/${profile.userId}',
              queryParameters: {'profile': 0}, data: body)
          .then((value) => true);
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to update user profile',
          meta: {
            'user_fname': '${profile.userFname}',
            'user_lname': '${profile.userLname}',
            'user_phone': '${profile.userPhone}',
            'user_email': '${profile.userEmail}',
            'method': 'putUserProfile'
          });
    }
  }

  @override
  Future<bool> deleteDevice(String deviceId) async {
    try {
      return await dio
          .delete('${ApiEndpoints.DEVICES}/$deviceId')
          .then((value) => true);
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to delete device',
          meta: {'id': deviceId, 'method': 'deleteDevice'});
    }
  }

  @override
  Future<bool> deleteUnlinkDeviceFromUser(
      String deviceId, String userId) async {
    try {
      return await dio.delete(
        '${ApiEndpoints.DEVICES_SHARED}/$deviceId',
        queryParameters: {'user_id': userId},
      ).then((value) => true);
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to delete unlinked device from user',
          meta: {
            'device': deviceId,
            'user': userId,
            'method': 'deleteUnlinkDeviceFromUser'
          });
    }
  }

  @override
  Future<Devices> getAllDevices() async {
    try {
      return await dio
          .get(ApiEndpoints.DEVICES,
              queryParameters: {'limit': 1000000},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) {
        try {
          return Devices.fromJson(value.data);
        } catch (e) {
          logger.error(TAG, e.toString(), {'method': 'getAllDevices'});
        }

        return Devices(list: []);
      });
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to get all devices',
          meta: {'method': 'getAllDevices'});
    }
  }

  @override
  Future<Devices> getDeviceById(String id) async {
    try {
      return await dio
          .get('${ApiEndpoints.DEVICES}/$id',
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) {
        try {
          return Devices.fromJson(value.data);
        } catch (e) {
          logger.error(TAG, e.toString(), {'method': 'getDeviceById'});
        }

        return Devices(list: []);
      });
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to get a device by id',
          meta: {'id': id, 'method': 'getDeviceById'});
    }
  }

  @override
  Future<Devices> getDeviceBySN(String sn) async {
    try {
      return await dio
          .get(ApiEndpoints.DEVICES,
              queryParameters: {'sn': sn, 'unclaim': 1},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) {
        try {
          return Devices.fromJson(value.data);
        } catch (e) {
          logger.error(TAG, e.toString(), {'method': 'getDeviceBySN'});
        }

        return Devices(list: []);
      });
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to get a device by serial number',
          meta: {'sn': sn, 'method': 'getDeviceBySN'});
    }
  }

  @override
  Future<Devices> getDeviceByVcodeId(String vcode, String id) async {
    try {
      return await dio
          .get(ApiEndpoints.DEVICES,
              queryParameters: {'vcode': vcode, 'device_id': id},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) {
        try {
          return Devices.fromJson(value.data);
        } catch (e) {
          logger.error(TAG, e.toString(), {'method': 'getDeviceByVcodeId'});
        }

        return Devices(list: []);
      });
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to get a device by verification code id',
          meta: {'device': id, 'vcode': vcode, 'method': 'getDeviceByVcodeId'});
    }
  }

  @override
  Future<Devices> getDevices(
      {int limit = 0, int offset = 0, String keyword = ''}) async {
    try {
      return await dio
          .get(ApiEndpoints.DEVICES,
              queryParameters: {
                'limit': limit,
                'offset': offset,
                'search': keyword
              },
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) {
        try {
          return Devices.fromJson(value.data);
        } catch (e) {
          logger.error(TAG, e.toString(), {'method': 'getDevices'});
        }

        return Devices(list: []);
      });
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to get devices',
          meta: {'method': 'getDevices'});
    }
  }

  @override
  Future<SharedDevices> getSharedDevices() async {
    try {
      return await dio
          .get('${ApiEndpoints.SHARE}/0',
              queryParameters: {'limit': 1000},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) {
        try {
          return SharedDevices.fromJson(value.data);
        } catch (e) {
          logger.error(TAG, e.toString(), {'method': 'getSharedDevices'});
        }

        return SharedDevices(list: []);
      });
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to all shared devices',
          meta: {'method': 'getSharedDevices'});
    }
  }

  @override
  Future<SharedUsers> getSharedUserByDeviceId(String deviceId) async {
    try {
      return await dio
          .get('${ApiEndpoints.DEVICES_SHARED}/$deviceId',
              queryParameters: {'limit': 1000},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) {
        try {
          return SharedUsers.fromJson(value.data);
        } catch (e) {
          logger
              .error(TAG, e.toString(), {'method': 'getSharedUserByDeviceId'});
        }

        return SharedUsers(list: []);
      });
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to all shared users',
          meta: {'device': deviceId, 'method': 'getSharedUserByDeviceId'});
    }
  }

  @override
  Future<bool> postAcceptSharedDevice(String deviceId, String vcode) async {
    try {
      final String body = json.encode({'device_id': deviceId, 'vcode': vcode});
      return await dio
          .post('${ApiEndpoints.SHARE}/2', data: body)
          .then((value) => true);
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to accept this shared device',
          meta: {
            'device': deviceId,
            'vcode': vcode,
            'method': 'postAcceptSharedDevice'
          });
    }
  }

  @override
  Future<bool> postIgnoreSharedDevice(String deviceId, String vcode) async {
    try {
      final String body = json.encode({'device_id': deviceId, 'vcode': vcode});
      return await dio
          .post('${ApiEndpoints.SHARE}/3', data: body)
          .then((value) => true);
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to discard this shared device',
          meta: {
            'device': deviceId,
            'vcode': vcode,
            'method': 'postIgnoreSharedDevice'
          });
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
      return await dio
          .post('${ApiEndpoints.SHARE}/0', data: body)
          .then((value) => value.data['vcode']);
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to share this device via email',
          meta: {
            'device': deviceId,
            'email': (destinationEmail != null) ? destinationEmail : '',
            'method': 'postShareDeviceViaEmail'
          });
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
      return await dio
          .put('${ApiEndpoints.DEVICES}/${param.id}', data: body)
          .then((value) => true);
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to claim this device',
          meta: {'sn': param.sn, 'method': 'putClaimDevice'});
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
      return await dio
          .put('${ApiEndpoints.DEVICES}/${param.id}', data: body)
          .then((value) => true);
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to update this device properties',
          meta: {'sn': param.sn, 'method': 'putDevice'});
    }
  }

  @override
  Future<bool> deleteAnalytic(String analyticId) async {
    try {
      return await dio
          .delete('${ApiEndpoints.ANALYTICS}/$analyticId')
          .then((value) => true);
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to delete this widget resources',
          meta: {'widget': analyticId, 'method': 'deleteAnalytic'});
    }
  }

  @override
  Future<bool> deleteAnalyticsResourcesByAnalytic(String analyticId) async {
    try {
      return await dio
          .delete('${ApiEndpoints.ANALYTICS_RESOURCES}/$analyticId')
          .then((value) => true);
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to delete this widget resources',
          meta: {
            'widget': analyticId,
            'method': 'deleteAnalyticsResourcesByAnalytic'
          });
    }
  }

  @override
  Future<bool> deleteUnlinkAnalyticFromUser(
      String analyticId, String userId) async {
    try {
      return await dio.delete(
        '${ApiEndpoints.ANALYTICS_SHARED}/$analyticId',
        queryParameters: {'user_id': userId},
      ).then((value) => true);
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to unlink this user from the widget',
          meta: {
            'widget': analyticId,
            'user': userId,
            'method': 'deleteUnlinkAnalyticFromUser'
          });
    }
  }

  @override
  Future<Analytics> getAnalyticById(String id) async {
    try {
      return await dio
          .get('${ApiEndpoints.ANALYTICS}/$id',
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) {
        try {
          return Analytics.fromJson(value.data);
        } catch (e) {
          logger.error(TAG, e.toString(), {'method': 'getAnalyticById'});
        }

        return Analytics(list: []);
      });
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to get widget by id',
          meta: {'widget': id, 'method': 'getAnalyticById'});
    }
  }

  @override
  Future<Analytics> getAnalyticByVcodeId(String vcode, String id) async {
    try {
      return await dio
          .get(ApiEndpoints.ANALYTICS,
              queryParameters: {'vcode': vcode, 'analytic_id': id},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) {
        try {
          return Analytics.fromJson(value.data);
        } catch (e) {
          logger.error(TAG, e.toString(), {'method': 'getAnalyticByVcodeId'});
        }

        return Analytics(list: []);
      });
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to get widget by vcode id',
          meta: {
            'widget': id,
            'vcode': vcode,
            'method': 'getAnalyticByVcodeId'
          });
    }
  }

  @override
  Future<Analytics> getAnalytics(
      {int limit = 0, int offset = 0, String keyword = ''}) async {
    try {
      return await dio
          .get(ApiEndpoints.ANALYTICS,
              queryParameters: {
                'limit': limit,
                'offset': offset,
                'search': keyword
              },
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) {
        try {
          return Analytics.fromJson(value.data);
        } catch (e) {
          logger.error(TAG, e.toString(), {'method': 'getAnalytics'});
        }

        return Analytics(list: []);
      });
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: 'Failed to get widgets with that keyword',
          meta: {'method': 'getAnalytics'});
    }
  }

  @override
  Future<AnalyticsResources> getAnalyticsResources(String analyticId) async {
    try {
      return await dio
          .get('${ApiEndpoints.ANALYTICS_RESOURCES}/$analyticId',
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) {
        try {
          return AnalyticsResources.fromJson(value.data);
        } catch (e) {
          logger.error(TAG, e.toString(), {'method': 'getAnalyticsResources'});
        }

        return AnalyticsResources(list: []);
      });
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: "Failed to get this widget's resources",
          meta: {'widget': analyticId, 'method': 'getAnalyticsResources'});
    }
  }

  @override
  Future<DevicesLogs> getDevicesLogs(DevicesLogsParam param,
      {DateTime? timeStart}) async {
    try {
      // if (timeStart == null) {
      //   timeStart = DateTime.now().subtract(Duration(days: 30)).toUtc();
      // }

      Map<String, dynamic> queryParameters = {
        'parameter': param.deviceParameter,
        'communication': 'mqtt',
        'limit': param.limit,
        'sortorder': 'desc'
      };

      if (timeStart != null) {
        queryParameters['ts'] = timeStart.toIso8601String();
      }

      return await dio
          .get('${ApiEndpoints.DEVICES_LOGS}/${param.deviceId}',
              queryParameters: queryParameters,
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
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: "Failed to get this device logs",
          meta: {
            'id': param.deviceId,
            'param': param.deviceParameter,
            'method': 'getDevicesLogs'
          });
    }
  }

  @override
  Future<Analytics> getMyAnalytics() async {
    try {
      return await dio
          .get(ApiEndpoints.ANALYTICS,
              queryParameters: {'limit': 1000000},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) {
        try {
          return Analytics.fromJson(value.data);
        } catch (e) {
          logger.error(TAG, e.toString(), {'method': 'getMyAnalytics'});
        }

        return Analytics(list: []);
      });
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: "Failed to get all widgets",
          meta: {'method': 'getMyAnalytics'});
    }
  }

  @override
  Future<SharedAnalytics> getSharedAnalytics() async {
    try {
      return await dio
          .get('${ApiEndpoints.SHARE}/1',
              queryParameters: {'limit': 1000},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) {
        try {
          return SharedAnalytics.fromJson(value.data);
        } catch (e) {
          logger.error(TAG, e.toString(), {'method': 'getSharedAnalytics'});
        }

        return SharedAnalytics(list: []);
      });
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: "Failed to get all shared widgets",
          meta: {'method': 'getSharedAnalytics'});
    }
  }

  @override
  Future<SharedUsers> getSharedUserByAnalyticId(String analyticId) async {
    try {
      return await dio
          .get('${ApiEndpoints.ANALYTICS_SHARED}/$analyticId',
              queryParameters: {'limit': 1000},
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) {
        try {
          return SharedUsers.fromJson(value.data);
        } catch (e) {
          logger.error(
              TAG, e.toString(), {'method': 'getSharedUserByAnalyticId'});
        }

        return SharedUsers(list: []);
      });
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: "Failed to get shared users",
          meta: {'widget': analyticId, 'method': 'getSharedUserByAnalyticId'});
    }
  }

  @override
  Future<StyledDevicesLogs> getStyledDevicesLogs(
      DevicesLogsParam param, LogsStyle style, int timeframeMinutes) async {
    try {
      return await dio
          .get('${ApiEndpoints.DEVICES_LOGS}/${param.deviceId}',
              queryParameters: {
                'parameter': param.deviceParameter,
                'communication': 'mqtt',
                'limit': param.limit,
                'sortorder': 'desc',
                'style': style.name,
                'tf': timeframeMinutes
              },
              options: Options(
                  validateStatus: (status) => status == 200 || status == 404))
          .then((value) {
        try {
          return StyledDevicesLogs.fromJson(value.data);
        } catch (e) {
          logger.error(TAG, e.toString(), {'method': 'getStyledDevicesLogs'});
        }

        return StyledDevicesLogs(list: []);
      });
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: "Failed to get devices logs",
          meta: {
            'id': param.deviceId,
            'param': param.deviceParameter,
            'method': 'getStyledDevicesLogs'
          });
    }
  }

  @override
  Future<bool> postAcceptSharedAnalytic(String analyticId, String vcode) async {
    try {
      final String body =
          json.encode({'analytic_id': analyticId, 'vcode': vcode});

      return await dio
          .post('${ApiEndpoints.SHARE}/2', data: body)
          .then((value) => true);
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: "Failed to accept this widget",
          meta: {
            'widget': analyticId,
            'vcode': vcode,
            'method': 'postAcceptSharedAnalytic'
          });
    }
  }

  @override
  Future<bool> postAnalyticsResources(AnalyticResource analyticResource) async {
    try {
      final String body = json.encode({
        'analytic_id': analyticResource.analyticId,
        'resources': analyticResource.resources
      });
      return await dio
          .post('${ApiEndpoints.ANALYTICS_RESOURCES}', data: body)
          .then((value) => true);
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: "Failed to update this widget resources",
          meta: {
            'widget': analyticResource.analyticId,
            'method': 'postAnalyticsResources'
          });
    }
  }

  @override
  Future<bool> postIgnoreSharedAnalytic(String analyticId, String vcode) async {
    try {
      final String body =
          json.encode({'analytic_id': analyticId, 'vcode': vcode});
      return await dio
          .post('${ApiEndpoints.SHARE}/3', data: body)
          .then((value) => true);
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: "Failed to discard this shared widget",
          meta: {
            'widget': analyticId,
            'vcode': vcode,
            'method': 'postIgnoreSharedAnalytic'
          });
    }
  }

  @override
  Future<AnalyticWidget> postNewAnalytic(AnalyticWidgetParam param) async {
    try {
      final String body = json.encode(param.toJson());

      return await dio
          .post(ApiEndpoints.ANALYTICS, data: body)
          .then((value) => AnalyticWidget.fromJson(value.data['body']));
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: "Failed to create a new widget",
          meta: {'method': 'postNewAnalytic'});
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
      return await dio
          .post('${ApiEndpoints.SHARE}/1', data: body)
          .then((value) => value.data['vcode']);
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: "Failed to share this widget",
          meta: {
            'widget': analyticId,
            'email': (destinationEmail != null) ? destinationEmail : '',
            'method': 'postShareAnalytic'
          });
    }
  }

  @override
  Future<bool> putAnalytic(String analyticId, AnalyticWidgetParam param) async {
    try {
      final String body = json.encode({
        'title': param.title,
        'model': param.model,
        'options': param.options
      });
      return await dio
          .put('${ApiEndpoints.ANALYTICS}/$analyticId', data: body)
          .then((value) => true);
    } on Exception catch (e) {
      throw HttpHelper.decodeErrorResponse(e,
          tag: TAG,
          logger: logger,
          defaultErrorMessage: "Failed to update this widget",
          meta: {'widget': analyticId, 'method': 'putAnalytic'});
    }
  }
}
