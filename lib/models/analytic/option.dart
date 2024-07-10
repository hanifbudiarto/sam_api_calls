part of sam_models_analytics;

class Option {
  final List<String> parentIds;
  final String id;
  final String name;
  final ChartEvent event;
  final ChartAction action;

  Option({this.parentIds = const <String>[],
    required this.id,
    this.name = "",
    this.event = const ChartEvent(),
    this.action = const ChartAction()});

  Option.fromJson(Map<String, dynamic> json, String? model)
      : this.parentIds = json.containsKey("parent") && json['parent'] != null
      ? List.from(json["parent"])
      : model != null ? [model] : [],
        this.id = json['id'].toString(),
        this.name = ifNullReturnEmpty(json['name']),
        this.event = ChartEvent.fromJson(json['event']),
        this.action = ChartAction.fromJson(json['action']);

  Map<String, dynamic> toJson() =>
      {
        'parent': this.parentIds,
        'id': this.id,
        'name': this.name,
        'event': this.event.toJson(),
        'action': this.action.toJson()
      };
}
