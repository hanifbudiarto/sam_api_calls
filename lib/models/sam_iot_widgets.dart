part of sam_models;

class SamIotWidgets {
  late final List<IotWidget> collection;

  static late final SamIotWidgets instance = SamIotWidgets._internal();

  factory SamIotWidgets({List<IotWidget> collection = const <IotWidget>[]}) {
    instance.collection = collection;
    return instance;
  }

  SamIotWidgets._internal();
}
