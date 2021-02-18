class ApiError {
  final String type;
  final String title;
  final String desc;
  final String request;

  ApiError({this.type, this.title, this.desc, this.request});

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
        type: json['type'],
        title: json['title'],
        desc: json['desc'],
        request: json['request']);
  }
}
