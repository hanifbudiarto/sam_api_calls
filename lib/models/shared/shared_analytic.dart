import 'package:sam_api_calls/models/analytic/analytic.dart';
import 'package:sam_api_calls/models/user/user.dart';

class SharedAnalytic {
  final String id;
  final String vcode;
  AnalyticWidget sharedItem;
  UserAccount sharedFrom;

  SharedAnalytic({this.id, this.vcode, this.sharedItem, this.sharedFrom});

  factory SharedAnalytic.fromJson(Map<String, dynamic> json) {
    return SharedAnalytic(
        id: json["id"].toString(),
        vcode: json["vcode"].toString(),
        sharedItem: AnalyticWidget.fromJson(json["share_item"]),
        sharedFrom: UserAccount.fromJson(json["share_from"]));
  }
}
