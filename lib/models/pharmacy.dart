import 'package:json_annotation/json_annotation.dart';
import 'pharmacy_value.dart';

part 'pharmacy.g.dart';

@JsonSerializable()
class Pharmacy {
  final String? responseCode;
  final String? href;
  final String? details;
  final String? generatedTs;
  final PharmacyValue? value;

  Pharmacy({
    this.responseCode,
    this.href,
    this.details,
    this.generatedTs,
    this.value,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) =>
      _$PharmacyFromJson(json);
  Map<String, dynamic> toJson() => _$PharmacyToJson(this);
}
