part of sam_contracts;

abstract class PublicService {
  Future<List<IotWidget>> getWidgetsCollection({String? jsonString});
}
