import 'map_settings.dart';

class OptionResource {
  int elementIndex;
  String rule;
  num threshold;
  bool notify;
  bool alert;
  String text;
  MapSettings mapSettings;

  OptionResource(
      {this.elementIndex = -1,
      this.rule = "=",
      this.threshold = 0,
      this.notify = false,
      this.alert = false,
      this.text = "",
      MapSettings mapSettings})
      : this.mapSettings = mapSettings == null ? MapSettings() : mapSettings;

  factory OptionResource.fromJson(Map<String, dynamic> json) {
    return OptionResource(
        elementIndex: json.containsKey("index") ? json["index"] : -1,
        rule: json["rule"],
        threshold: json["threshold"],
        notify: json["notify"],
        alert: json["alert"],
        text: json["text"],
        mapSettings: json.containsKey("map_settings")
            ? MapSettings.fromJson(json["map_settings"])
            : MapSettings());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.elementIndex;
    data['rule'] = this.rule;
    data['threshold'] = this.threshold;
    data['notify'] = this.notify;
    data['alert'] = this.alert;
    data['text'] = this.text;
    data['map_settings'] = this.mapSettings;
    return data;
  }
}
