part of sam_models_analytics;

class ChartAction {
  final ChartActionType inputType;
  final List<String> inputSource;
  final String enteredValue;

  const ChartAction({this.inputType = ChartActionType.TEXT, this.inputSource = const <String>[], this.enteredValue = ""});

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

  ChartAction.fromJson(Map<String, dynamic> json)
      : this.inputType = ChartAction.getAction(json['input_type']),
        this.inputSource =
            json.containsKey('input_source') && json['input_source'] != null
                ? List<String>.from(json['input_source'])
                : [],
        this.enteredValue = ifNullReturnEmpty(json['entered_value']);

  Map<String, dynamic> toJson() => {
        'input_type': ChartAction.getActionString(this.inputType),
        'entered_value': this.enteredValue,
        'input_source': this.inputSource
      };
}
