import 'shared_user.dart';

class SharedUsers {
  List<SharedUser> list;

  SharedUsers({this.list});

  factory SharedUsers.fromJson(List<dynamic> json) {
    List<SharedUser> newList = [];

    if (json.contains("body")) {
      newList.addAll(json.map((dev) => SharedUser.fromJson(dev)).toList());
    }
    return SharedUsers(list: newList);
  }
}
