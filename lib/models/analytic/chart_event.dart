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

