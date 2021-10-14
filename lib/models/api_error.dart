part of sam_models;

class ApiError {
  late final String type;
  late final String title;
  late final String desc;
  late final String request;

  ApiError(
      {required this.type,
      required this.title,
      required this.desc,
      required this.request});

  ApiError.fromJson(Map<String, dynamic> json) {
    this.type = json['type'];
    this.title = json['title'];
    this.desc = json['desc'];
    this.request = json['request'];
  }
}
