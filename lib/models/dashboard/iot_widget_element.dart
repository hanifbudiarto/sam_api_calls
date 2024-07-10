part of sam_models_dashboards;

class IotWidgetElement {
  final String id;
  final String title;
  final String icon;
  final bool settable;
  final bool retained;
  final int numOfParameters;
  final List<AcceptedParameter> acceptedParameters;

  IotWidgetElement(
      {required this.id,
      this.title = "",
      this.icon = "",
      this.settable = false,
      this.retained = false,
      this.numOfParameters = 0,
      this.acceptedParameters = const <AcceptedParameter>[]});

  IotWidgetElement.fromJson(Map<String, dynamic> json)
      : this.id = json['id'].toString(),
        this.title = ifNullReturnEmpty(json['title']),
        this.icon = ifNullReturnEmpty(json['icon']),
        this.settable = json['settable'] == true,
        this.retained = json['retained'] == true,
        this.numOfParameters = json['num_of_parameters'],
        this.acceptedParameters = (json['accepted_parameters'] as List)
            .map((a) => AcceptedParameter.fromJson(a))
            .toList();
}
