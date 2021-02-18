import 'chart_action_type.dart';

class ChartOptions {
  List<Option> list;

  ChartOptions({this.list});

  factory ChartOptions.fromJson(Map<String, dynamic> json) {
    if (json['options'] != null || json['options'].toString() != "null") {
      List opts = new List<Option>();
      json['options'].forEach((v) {
        opts.add(new Option.fromJson(v, json["model"]));
      });

      return ChartOptions(list: opts);
    }

    return null;
  }

  List<Map<String, dynamic>> toJson() {
    if (this.list != null) {
      return this.list.map((v) => v.toJson()).toList();
    }
    return [];
  }
}

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

class ChartEvent {
  List<String> triggers;
  String enteredTrigger;
  List<String> operators;
  String enteredOperator;
  String enteredValue;
  String textInputType;

  ChartEvent(
      {this.triggers,
      this.enteredTrigger,
      this.operators,
      this.enteredOperator,
      this.enteredValue,
      this.textInputType});

  factory ChartEvent.fromJson(Map<String, dynamic> json) {
    return ChartEvent(
        triggers: json['triggers'].cast<String>(),
        enteredTrigger: json['entered_trigger'],
        operators: json['operators'].cast<String>(),
        enteredOperator: json['entered_operator'],
        enteredValue: json['entered_value'],
        textInputType: json['text_input_type']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['triggers'] = this.triggers;
    data['entered_trigger'] = this.enteredTrigger;
    data['operators'] = this.operators;
    data['entered_operator'] = this.enteredOperator;
    data['entered_value'] = this.enteredValue;
    data['text_input_type'] = this.textInputType;
    return data;
  }
}

class ChartAction {
  ChartActionType inputType;
  List<String> inputSource;
  String enteredValue;

  ChartAction({this.inputType, this.inputSource, this.enteredValue});

  static ChartActionType getAction(String type) {
    switch (type) {
      case "colorpicker":
        return ChartActionType.COLORPICKER;
      case "dropdown":
        return ChartActionType.DROPDOWN;
      case "radio":
        return ChartActionType.RADIO;
      case "number":
        return ChartActionType.NUMBER;
      case "range":
        return ChartActionType.RANGE;
      case "text":
        return ChartActionType.TEXT;
      default:
        return null;
    }
  }

  static String getActionString(ChartActionType type) {
    switch (type) {
      case ChartActionType.COLORPICKER:
        return "colorpicker";
      case ChartActionType.DROPDOWN:
        return "dropdown";
      case ChartActionType.RADIO:
        return "radio";
      case ChartActionType.NUMBER:
        return "number";
      case ChartActionType.RANGE:
        return "range";
      case ChartActionType.TEXT:
        return "text";
      default:
        return null;
    }
  }

  factory ChartAction.fromJson(Map<String, dynamic> json) {
    List<String> sources = [];
    if (json.containsKey('input_source') && json['input_source'] != null) {
      sources = json['input_source'].cast<String>();
    }

    return ChartAction(
      inputType: ChartAction.getAction(json['input_type']),
      inputSource: sources,
      enteredValue: json['entered_value'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['input_type'] = ChartAction.getActionString(this.inputType);
    data['entered_value'] = this.enteredValue;
    data['input_source'] = this.inputSource;
    return data;
  }
}
