import 'package:sam_api_calls/models/models.dart';

abstract class PublicService {
  Future<List<IotWidget>> getWidgetsCollection({String path});
}
