part of sam_models_analytics;

class OptionResource {
  late int elementIndex;
  late String rule;
  late num threshold;
  late bool notify;
  late bool alert;
  late String text;
  late MapSettings mapSettings;

  OptionResource(
      {this.elementIndex = -1,
      this.rule = "=",
      this.threshold = 0,
      this.notify = false,
      this.alert = false,
      this.text = "",
      MapSettings? mapSettings})
      : this.mapSettings = mapSettings == null ? MapSettings() : mapSettings;

  OptionResource.fromJson(Map<String, dynamic> json) {
    this.elementIndex = json.containsKey("index") ? json["index"] : -1;
    this.rule = json['rule'];
    this.threshold = json['threshold'];
    this.notify = json['notify'];
    this.alert = json['alert'];
    this.text = json['text'];
    this.mapSettings= json.containsKey("map_settings")
    ? MapSettings.fromJson(json["map_settings"])
        : MapSettings();
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
