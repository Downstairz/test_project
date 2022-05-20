import 'package:json_annotation/json_annotation.dart';
import 'address.dart';

part 'pharmacy_value.g.dart';

@JsonSerializable()
class PharmacyValue {
  final String? id;
  final String? pharmacyChainId;
  final String? name;
  final bool? active;
  final String? localId;
  final bool? testPharmacy;
  final Address? address;
  final String? primaryPhoneNumber;
  final String? defaultTimeZone;
  final String? pharmacistInCharge;
  final List<String>? postalCodes;
  final List<String>? deliverableStates;
  final String? pharmacyHours;
  final String? deliverySubsidyAmount;
  final String? pharmacySystem;
  final bool? acceptInvalidAddress;
  final String? pharmacyType;
  final bool? checkoutPharmacy;
  final bool? marketplacePharmacy;
  final bool? importActive;

  PharmacyValue({
    this.id,
    this.pharmacyChainId,
    this.name,
    this.active,
    this.localId,
    this.testPharmacy,
    this.address,
    this.primaryPhoneNumber,
    this.defaultTimeZone,
    this.pharmacistInCharge,
    this.postalCodes,
    this.deliverableStates,
    this.pharmacyHours,
    this.deliverySubsidyAmount,
    this.pharmacySystem,
    this.acceptInvalidAddress,
    this.pharmacyType,
    this.checkoutPharmacy,
    this.marketplacePharmacy,
    this.importActive,
  });

  factory PharmacyValue.fromJson(Map<String, dynamic> json) =>
      _$PharmacyValueFromJson(json);
  Map<String, dynamic> toJson() => _$PharmacyValueToJson(this);
}

extension AddressExt on PharmacyValue {
  String get addressDisplay => "${address?.streetAddress1 ?? ''}\n${address?.usTerritory ?? ''}, ${address?.city ?? ''}, ${address?.postalCode ?? ''}";

}
