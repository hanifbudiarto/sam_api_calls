part of sam_models_dashboards;

class IotWidgetElement {
  late final String id;
  late final String title;
  late final String icon;
  late final bool settable;
  late final bool retained;
  late final int numOfParameters;
  late final List<String> acceptedParameters;

  IotWidgetElement(
      {required this.id,
      required this.title,
      required this.icon,
      required this.settable,
      required this.retained,
      required this.numOfParameters,
      required this.acceptedParameters});

  IotWidgetElement.fromJson(Map<String, dynamic> json) {
    var acceptedParams = json['accepted_parameters'] as List;

    this.id = json['id'];
    this.title = json['title'];
    this.icon = json['icon'];
    this.settable = json['settable'];
    this.retained = json['retained'];
    this.numOfParameters = json['num_of_parameters'];
    this.acceptedParameters = acceptedParams.map((a) => a.toString()).toList();
  }
}
