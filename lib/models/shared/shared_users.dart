part of sam_models_shared;

class SharedUsers {
  late final List<SharedUser> list;

  SharedUsers({required this.list});
  
  SharedUsers.fromJson(Map<String, dynamic> json) {
    List<SharedUser> newList = [];

    if (json.containsKey('body')) {
	  var results = json['body'] as List;
      newList.addAll(results.map((dev) => SharedUser.fromJson(dev)).toList());
    }

    this.list = newList;
  }
}
