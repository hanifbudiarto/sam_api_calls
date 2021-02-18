import 'dart:io';

import 'package:flutter/material.dart';

import '../models/models.dart';

abstract class DataService {
  // dashboard
  Future<DashboardProfiles> getAllDashboards();

  Future<DashboardProfiles> getDashboardsById(String id);

  Future<DashboardProfile> postEmptyDashboardProfile(String name);

  Future<bool> putDashboard(DashboardProfile newProfile);

  Future<bool> deleteDashboard(DashboardProfile profile);

  // etc
  Future<Cities> getCitiesByKeyword(String keyword);

  Future<Countries> getCountriesByCode(String code);

  // user

  Future<BrokerProperties> getBrokerProperties();

  Future<UserAccount> getUserAccount();

  Future<bool> putUserProfile(UserProfile profile);

  Future<bool> putUserOrganization(UserOrganization organization);

  Future<bool> postUploadAvatar(File image);

  Future<UserAvatar> getAvatar();

  // Devices
  Future<Devices> getDeviceBySN(String sn);

  Future<bool> putClaimDevice(DeviceIot device, UserAccount account);

  Future<bool> putDevice(DeviceIot device);

  Future<Devices> getAllDevices();

  Future<Devices> getDevices(
      {int limit = 0, int offset = 0, String keyword = ""});

  Future<SharedDevices> getSharedDevices();

  Future<bool> deleteDevice(DeviceIot device);

  Future<SharedUsers> getSharedUserByDeviceId(DeviceIot device);

  Future<bool> deleteUnlinkDeviceFromUser(DeviceIot device, UserAccount user);

  Future<String> postShareDeviceViaEmail(
      DeviceIot device, UserAccount destinationAccount);

  Future<bool> postAcceptSharedDevice(
      DeviceIot device, String verificationCode);

  Future<bool> postIgnoreSharedDevice(SharedDevice sharedDevice);

  Future<Devices> getDeviceById(String id);

  Future<Devices> getDeviceByVcodeId(String vcode, String id);

  // Analytics
  // get analytics for analytics screen
  Future<Analytics> getMyAnalytics();

  Future<Analytics> getAnalytics(
      {int limit = 0, int offset = 0, String keyword = ""});

  Future<SharedAnalytics> getSharedAnalytics();

  // add new analytic (title, model, type)
  Future<AnalyticWidget> postNewAnalytic(AnalyticWidget analytic);

  // get analytic resources by analytic id
  Future<AnalyticsResources> getAnalyticsResources(AnalyticWidget analytic);

  // get devices logs data
  Future<DevicesLogs> getDevicesLogs(Resource resource,
      {@required int limit, DateTime timeStart});

  Future<StyledDevicesLogs> getStyledDevicesLogs(Resource resource,
      {@required int limit, @required String style, int timeframe});

  // update analytic
  Future<bool> putAnalytic(AnalyticWidget analytic);

  // update analytic resources
  Future<bool> postAnalyticsResources(AnalyticResource analyticResource);

  // delete analytic resource of analytic
  Future<bool> deleteAnalyticsResourcesByAnalytic(AnalyticWidget analytic);

  Future<bool> deleteAnalytic(AnalyticWidget analytic);

  Future<SharedUsers> getSharedUserByAnalyticId(AnalyticWidget analytic);

  Future<String> postShareAnalytic(
      AnalyticWidget analytic, UserAccount destinationAccount);

  Future<bool> deleteUnlinkAnalyticFromUser(
      AnalyticWidget analytic, UserAccount user);

  Future<bool> postAcceptSharedAnalytic(
      AnalyticWidget analytic, String verificationCode);

  Future<bool> postIgnoreSharedAnalytic(SharedAnalytic sharedAnalytic);

  Future<Analytics> getAnalyticById(String id);

  Future<Analytics> getAnalyticByVcodeId(String vcode, String id);

  String getThrowsMessage(
      String defaultError, Map<String, dynamic> responseData);
}
