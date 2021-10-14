part of sam_models_shared;

class SharedAnalytic {
  late final String id;
  late final String vcode;
  late final AnalyticWidget sharedItem;
  late final UserAccount sharedFrom;

  SharedAnalytic(
      {required this.id,
      required this.vcode,
      required this.sharedItem,
      required this.sharedFrom});

  SharedAnalytic.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.vcode = json['vcode'];
    this.sharedItem = AnalyticWidget.fromJson(json['share_item']);
    this.sharedFrom = UserAccount.fromJson(json['share_from']);
  }
}
