part of sam_impl;

class PublicServiceImpl extends PublicService {
  late Dio _dio;

  PublicServiceImpl({List<Interceptor>? interceptors}) {
    _dio = Dio();
    if (interceptors != null && interceptors.length > 0) {
      _dio.interceptors.addAll(interceptors);
    }
  }

  // resources/json/sam_iot_widgets.json
  @override
  Future<List<IotWidget>> getWidgetsCollection({String? jsonString}) async {
    if (jsonString != null) {
      try {
        var list = json.decode(jsonString) as List;
        return list.map((wgt) => IotWidget.fromJson(wgt)).toList();
      } catch (_) {
        throw 'Failed to get widgets collection';
      }
    }

    return [];
  }
}
