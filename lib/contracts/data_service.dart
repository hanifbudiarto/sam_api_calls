part of sam_contracts;

abstract class DataService {
  // dashboard
  Future<DashboardProfiles> getAllDashboards();

  Future<DashboardProfiles> getDashboardsById(String id);

  Future<DashboardProfile> postEmptyDashboardProfile(String name);

  Future<bool> putDashboard(DashboardProfile newProfile);

  Future<bool> deleteDashboard(String profileId);

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

  Future<bool> putClaimDevice(DeviceClaimParam param);

  Future<bool> putDevice(DeviceClaimParam param, DeviceOption options);

  Future<Devices> getAllDevices();

  Future<Devices> getDevices(
      {int limit = 0, int offset = 0, String keyword = ''});

  Future<SharedDevices> getSharedDevices();

  Future<bool> deleteDevice(String deviceId);

  Future<SharedUsers> getSharedUserByDeviceId(String deviceId);

  Future<bool> deleteUnlinkDeviceFromUser(String deviceId, String userId);

  Future<String> postShareDeviceViaEmail(
      String deviceId, String? destinationEmail);

  Future<bool> postAcceptSharedDevice(String deviceId, String vcode);

  Future<bool> postIgnoreSharedDevice(String deviceId, String vcode);

  Future<Devices> getDeviceById(String id);

  Future<Devices> getDeviceByVcodeId(String vcode, String id);

  // Analytics
  // get analytics for analytics screen
  Future<Analytics> getMyAnalytics();

  Future<Analytics> getAnalytics(
      {int limit = 0, int offset = 0, String keyword = ''});

  Future<SharedAnalytics> getSharedAnalytics();

  // add new analytic (title, model, type)
  Future<AnalyticWidget> postNewAnalytic(AnalyticWidgetParam param);

  // get analytic resources by analytic id
  Future<AnalyticsResources> getAnalyticsResources(String analyticId);

  // get devices logs data
  Future<DevicesLogs> getDevicesLogs(DevicesLogsParam param,
      {DateTime? timeStart});

  Future<StyledDevicesLogs> getStyledDevicesLogs(
      DevicesLogsParam param, LogsStyle style, int timeframeMinutes);

  // update analytic
  Future<bool> putAnalytic(String analyticId, AnalyticWidgetParam param);

  // update analytic resources
  Future<bool> postAnalyticsResources(AnalyticResource analyticResource);

  // delete analytic resource of analytic
  Future<bool> deleteAnalyticsResourcesByAnalytic(String analyticId);

  Future<bool> deleteAnalytic(String analyticId);

  Future<SharedUsers> getSharedUserByAnalyticId(String analyticId);

  Future<String> postShareAnalytic(String analyticId, String? destinationEmail);

  Future<bool> deleteUnlinkAnalyticFromUser(String analyticId, String userId);

  Future<bool> postAcceptSharedAnalytic(String analyticId, String vcode);

  Future<bool> postIgnoreSharedAnalytic(String analyticId, String vcode);

  Future<Analytics> getAnalyticById(String id);

  Future<Analytics> getAnalyticByVcodeId(String vcode, String id);

  String getThrowsMessage(
      String defaultError, Map<String, dynamic> responseData);
}
