import 'dashboard/dashboard.dart';

class SamIotWidgets {
  List<IotWidget> collection;

  static final SamIotWidgets _instance = SamIotWidgets._internal();

  factory SamIotWidgets({List<IotWidget> collection}) {
    if (collection != null) {
      _instance.collection = collection;
    }
    return _instance;
  }

  SamIotWidgets._internal();
}
