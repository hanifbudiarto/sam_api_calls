part of sam_models_dashboards;

class AcceptedParameter {
  final String parameter;
  final String dataType;

  AcceptedParameter({required this.parameter, required this.dataType});

  AcceptedParameter.fromJson(Map<String, dynamic> json)
    : this.parameter = json['parameter'].toString(),
      this.dataType = json['datatype'].toString();
}