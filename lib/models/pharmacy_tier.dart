import 'package:json_annotation/json_annotation.dart';
part 'pharmacy_tier.g.dart';

@JsonSerializable()
class PharmacyTier {
  final String? name;
  final String? pharmacyId;

  PharmacyTier({
    this.name,
    this.pharmacyId,
  });

  factory PharmacyTier.fromJson(Map<String, dynamic> json) =>
      _$PharmacyTierFromJson(json);
  Map<String, dynamic> toJson() => _$PharmacyTierToJson(this);
}
