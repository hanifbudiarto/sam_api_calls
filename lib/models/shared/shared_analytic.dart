part of sam_models_shared;

class SharedAnalytic {
  final String id;
  final String vcode;
  final AnalyticWidget sharedItem;
  final UserAccount sharedFrom;

  SharedAnalytic(
      {required this.id,
      this.vcode = "",
      required this.sharedItem,
      required this.sharedFrom});

  SharedAnalytic.fromJson(Map<String, dynamic> json)
      : this.id = json['id'].toString(),
        this.vcode = ifNullReturnEmpty(json['vcode']),
        this.sharedItem = AnalyticWidget.fromJson(json['share_item']),
        this.sharedFrom = UserAccount.fromJson(json['share_from']);
}
