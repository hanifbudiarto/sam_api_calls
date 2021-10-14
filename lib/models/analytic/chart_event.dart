part of sam_models_analytics;

class ChartEvent {
  late final List<String> triggers;
  String? enteredTrigger;
  List<String>? operators;
  String? enteredOperator;
  String? enteredValue;
  String? textInputType;

  ChartEvent(
      {required this.triggers,
      this.enteredTrigger,
      this.operators,
      this.enteredOperator,
      this.enteredValue,
      this.textInputType});

  ChartEvent.fromJson(Map<String, dynamic> json) {
    List<String> listTriggers = [];
    listTriggers = List<String>.from(json['triggers']);

    this.triggers = listTriggers;
    this.enteredTrigger = json['entered_trigger'];

    List<String> listOperators = [];
    if (json['operators'] != null) {
      listOperators = List<String>.from(json['operators']);
    }
    this.operators = listOperators;
    this.enteredOperator = json['entered_operator'];
    this.enteredValue = json['entered_value'];
    this.textInputType = json['text_input_type'];
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
