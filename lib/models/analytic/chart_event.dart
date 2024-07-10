part of sam_models_analytics;

class ChartEvent {
  final List<String> triggers;
  final String enteredTrigger;
  final List<String> operators;
  final String enteredOperator;
  final String enteredValue;
  final String textInputType;

  const ChartEvent(
      {this.triggers = const <String>[],
      this.enteredTrigger = "",
      this.operators = const <String>[],
      this.enteredOperator = "",
      this.enteredValue = "",
      this.textInputType = ""});

  ChartEvent.fromJson(Map<String, dynamic> json)
      : this.triggers = List<String>.from(json['triggers']),
        this.enteredTrigger = ifNullReturnEmpty(json['entered_trigger']),
        this.operators = json['operators'] != null
            ? List<String>.from(json['operators'])
            : [],
        this.enteredOperator = ifNullReturnEmpty(json['entered_operator']),
        this.enteredValue = ifNullReturnEmpty(json['entered_value']),
        this.textInputType = ifNullReturnEmpty(json['text_input_type']);

  Map<String, dynamic> toJson() => {
        'triggers': this.triggers,
        'entered_trigger': this.enteredTrigger,
        'operators': this.operators,
        'entered_operator': this.enteredOperator,
        'entered_value': this.enteredValue,
        'text_input_type': this.textInputType
      };
}
