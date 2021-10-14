part of sam_models_analytics;

class ChartAction {
  late final ChartActionType inputType;
  List<String>? inputSource;
  String? enteredValue;

  ChartAction(
      {required this.inputType, this.inputSource, this.enteredValue});

  static ChartActionType getAction(String type) {
    switch (type) {
      case 'colorpicker':
        return ChartActionType.COLORPICKER;
      case 'dropdown':
        return ChartActionType.DROPDOWN;
      case 'radio':
        return ChartActionType.RADIO;
      case 'number':
        return ChartActionType.NUMBER;
      case 'range':
        return ChartActionType.RANGE;
      case 'text':
      default:
        return ChartActionType.TEXT;
    }
  }

  static String getActionString(ChartActionType type) {
    switch (type) {
      case ChartActionType.COLORPICKER:
        return 'colorpicker';
      case ChartActionType.DROPDOWN:
        return 'dropdown';
      case ChartActionType.RADIO:
        return 'radio';
      case ChartActionType.NUMBER:
        return 'number';
      case ChartActionType.RANGE:
        return 'range';
      case ChartActionType.TEXT:
      default:
        return 'text';
    }
  }

  ChartAction.fromJson(Map<String, dynamic> json) {
    List<String> sources = [];
    if (json.containsKey('input_source') && json['input_source'] != null) {
      sources = List<String>.from(json['input_source']);
    }

    this.inputType = ChartAction.getAction(json['input_type']);
    this.inputSource = sources;
    this.enteredValue = json['entered_value'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['input_type'] = ChartAction.getActionString(this.inputType);
    data['entered_value'] = this.enteredValue;
    data['input_source'] = this.inputSource;
    return data;
  }
}
