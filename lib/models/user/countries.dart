
import 'package:sam_api_calls/models/user/country.dart';

class Countries {
  List<Country> list;

  Countries({this.list});

  factory Countries.fromJson(Map<String, dynamic> json) {
    List<Country> countries = [];

    if (json.containsKey("body")) {
      var list = json["body"] as List;
      countries = list.map((item) => Country.fromJson(item)).toList();
    }

    return Countries(list: countries);
  }
}
