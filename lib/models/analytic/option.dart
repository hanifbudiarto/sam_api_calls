import 'package:sam_api_calls/models/analytic/chart_action.dart';
import 'package:sam_api_calls/models/analytic/chart_event.dart';

class Option {
  List<String> parentIds;
  String id;
  String name;
  ChartEvent event;
  ChartAction action;

  Option({this.parentIds, this.id, this.name, this.event, this.action});

  factory Option.fromJson(Map<String, dynamic> json, String model) {
    ChartEvent event =
        json['event'] != null ? ChartEvent.fromJson(json['event']) : null;
    ChartAction action =
        json['action'] != null ? ChartAction.fromJson(json['action']) : null;

    List<String> parents = [model];

    if (json.containsKey("parent")) {
      parents = List.from(json["parent"]);
    }

    return Option(
        parentIds: parents,
        id: json['id'],
        name: json['name'],
        event: event,
        action: action);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parent'] = this.parentIds;
    data['id'] = this.id;
    data['name'] = this.name;
    data['event'] = this.event;
    if (this.event != null) {
      data['event'] = this.event.toJson();
    }
    if (this.action != null) {
      data['action'] = this.action.toJson();
    }
    return data;
  }
}
