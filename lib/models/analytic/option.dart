part of sam_models_analytics;

class Option {
  late final List<String> parentIds;
  late final String id;
  late final String name;
  late final ChartEvent event;
  late final ChartAction action;

  Option(
      {required this.parentIds,
      required this.id,
      required this.name,
      required this.event,
      required this.action});

  Option.fromJson(Map<String, dynamic> json, String model) {
    ChartEvent event = ChartEvent.fromJson(json['event']);
    ChartAction action = ChartAction.fromJson(json['action']);

    List<String> parents = [model];

    if (json.containsKey("parent")) {
      parents = List.from(json["parent"]);
    }

    this.parentIds = parents;
    this.id = json['id'];
    this.name = json['name'];
    this.event = event;
    this.action = action;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parent'] = this.parentIds;
    data['id'] = this.id;
    data['name'] = this.name;
    data['event'] = this.event.toJson();
    data['action'] = this.action.toJson();
    return data;
  }
}
