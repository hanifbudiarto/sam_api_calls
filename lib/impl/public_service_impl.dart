part of sam_impl;

class PublicServiceImpl extends PublicService {
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
