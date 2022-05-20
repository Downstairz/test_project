import 'package:json_annotation/json_annotation.dart';
import 'package:test_project/models/pharmacy_tier.dart';

part 'pharmacies.g.dart';

@JsonSerializable()
class Pharmacies {
  final List<PharmacyTier>? pharmacies;

  Pharmacies({
    this.pharmacies,
  });

  factory Pharmacies.fromJson(Map<String, dynamic> json) =>
      _$PharmaciesFromJson(json);
  Map<String, dynamic> toJson() => _$PharmaciesToJson(this);
}
