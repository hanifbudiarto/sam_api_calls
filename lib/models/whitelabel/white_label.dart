import 'package:sam_api_calls/util/util.dart';

class WhiteLabel {
  final bool enable;
  final String domain;
  final String emailNoReply;
  final String emailSupport;
  final String brand;
  final String tagline;
  final String urlLogo;
  final String urlTos;
  final String urlPrivacy;
  final String urlAndroid;
  final String urlIos;
  final String urlOtherApp;

  WhiteLabel(
      {required this.enable,
      required this.domain,
      required this.emailNoReply,
      required this.emailSupport,
      required this.brand,
      required this.tagline,
      required this.urlLogo,
      required this.urlTos,
      required this.urlPrivacy,
      required this.urlAndroid,
      required this.urlIos,
      required this.urlOtherApp});

  WhiteLabel.fromJson(Map<String, dynamic> json)
      : enable = json['enable'] == true,
        domain = ifNullReturnEmpty(json['domain']),
        emailNoReply = ifNullReturnEmpty(json['email_noreply']),
        emailSupport = ifNullReturnEmpty(json['email_support']),
        brand = ifNullReturnEmpty(json['brand']),
        tagline = ifNullReturnEmpty(json['tagline']),
        urlLogo = ifNullReturnEmpty(json['url_logo']),
        urlTos = ifNullReturnEmpty(json['url_tos']),
        urlPrivacy = ifNullReturnEmpty(json['url_privacy']),
        urlAndroid = ifNullReturnEmpty(json['url_android']),
        urlIos = ifNullReturnEmpty(json['url_ios']),
        urlOtherApp = ifNullReturnEmpty(json['url_otherapp']);

  Map<String, dynamic> toJson() => {
        'enable': this.enable,
        'domain': this.domain,
        'email_noreply': this.emailNoReply,
        'email_support': this.emailSupport,
        'brand': this.brand,
        'tagline': this.tagline,
        'url_logo': this.urlLogo,
        'url_tos': this.urlTos,
        'url_privacy': this.urlPrivacy,
        'url_android': this.urlAndroid,
        'url_ios': this.urlIos,
        'url_otherapp': this.urlOtherApp,
      };
}
