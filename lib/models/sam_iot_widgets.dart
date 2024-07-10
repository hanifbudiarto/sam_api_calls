part of sam_models;

class SamIotWidgets {
  final List<IotWidget> collection = [];

  static final SamIotWidgets instance = SamIotWidgets._internal();

  factory SamIotWidgets({List<IotWidget> widgets = const <IotWidget>[]}) {
    if (instance.collection.length == 0) {
      instance.collection.addAll(widgets);
    }
    return instance;
  }

  SamIotWidgets._internal();
}
