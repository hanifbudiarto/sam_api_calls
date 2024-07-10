part of sam_models;

class ApiError {
  final String type;
  final String title;
  final String desc;
  final String request;

  ApiError(
      {required this.type,
      required this.title,
      required this.desc,
      required this.request});

  ApiError.fromJson(Map<String, dynamic> json)
      : this.type = ifNullReturnEmpty(json['type']),
        this.title = ifNullReturnEmpty(json['title']),
        this.desc = ifNullReturnEmpty(json['desc']),
        this.request = ifNullReturnEmpty(json['request']);
}
