part of sam_models_shared;

class SharedUsers {
  final List<SharedUser> list;

  SharedUsers({this.list = const <SharedUser>[]});

  SharedUsers.fromJson(Map<String, dynamic> json)
      : this.list = json.containsKey('body') ? getNewList(json) : [];

  static List<SharedUser> getNewList(Map<String, dynamic> json) {
    List<SharedUser> newList = [];
    var results = json['body'] as List;
    newList.addAll(results.map((dev) => SharedUser.fromJson(dev)).toList());
    return newList;
  }
}
