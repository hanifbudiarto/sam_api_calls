import 'package:sam_api_calls/util/util.dart';

class RoundingSettings {
  final bool isRounding;
  final int roundingToDecimalPlaces;
  final String roundingMethod;

  const RoundingSettings({
    this.isRounding = false, this.roundingToDecimalPlaces = 0, this.roundingMethod = "Round"});

  RoundingSettings.fromJson(Map<String, dynamic> json)
      : isRounding = json['is_rounding'],
        roundingMethod = ifNullReturnEmpty(json['rounding_method']),
        roundingToDecimalPlaces = json['decimal_places'];

  Map<String, dynamic> toJson() => {
    'is_rounding': this.isRounding,
    'decimal_places': this.roundingToDecimalPlaces,
    'rounding_method': this.roundingMethod,
  };
}