
import 'package:sam_api_calls/models/analytic/chart_action_type.dart';

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