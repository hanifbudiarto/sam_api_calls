part of sam_models_analytics;

class OptionResource {
  final int elementIndex;
  final String rule;
  final String threshold;
  final bool notify;
  final bool alert;
  final String text;
  final MapSettings mapSettings;
  final OptionRun run;
  final RoundingSettings rounding;

  const OptionResource(
      {this.elementIndex = -1,
      this.rule = "==",
      this.threshold = "-999999",
      this.notify = false,
      this.alert = false,
      this.text = "",
      this.mapSettings = const MapSettings(),
      this.run = const OptionRun(),
      this.rounding = const RoundingSettings()});

  OptionResource.fromJson(Map<String, dynamic> json)
      : this.elementIndex = json.containsKey("index") ? json["index"] : -1,
        this.rule = ifNullReturnEmpty(json['rule']),
        this.threshold = json['threshold'].toString(),
        this.notify = json['notify'] == true,
        this.alert = json['alert'] == true,
        this.text = ifNullReturnEmpty(json['text']),
        this.mapSettings = json['map_settings'].runtimeType != Null ||
                json['map_settings'] != null ||
                json['map_settings'].toString() != 'null'
            ? MapSettings.fromJson(json["map_settings"])
            : MapSettings(),
        run = json['run'].runtimeType != Null ||
                json['run'] != null ||
                json['run'].toString() != 'null'
            ? new OptionRun.fromJson(json['run'])
            : new OptionRun(),
        rounding = json['rounding'].runtimeType != Null ||
            json['rounding'] != null ||
            json['rounding'].toString() != 'null'
            ? new RoundingSettings.fromJson(json['rounding'])
            : new RoundingSettings();

  Map<String, dynamic> toJson() => {
        'index': this.elementIndex,
        'rule': this.rule,
        'threshold': this.threshold,
        'notify': this.notify,
        'alert': this.alert,
        'text': this.text,
        'map_settings': this.mapSettings.toJson(),
        'run': this.run.toJson(),
        'rounding': this.rounding.toJson()
      };
}
