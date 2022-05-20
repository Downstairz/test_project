// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacy_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PharmacyValue _$PharmacyValueFromJson(Map<String, dynamic> json) =>
    PharmacyValue(
      id: json['id'] as String?,
      pharmacyChainId: json['pharmacyChainId'] as String?,
      name: json['name'] as String?,
      active: json['active'] as bool?,
      localId: json['localId'] as String?,
      testPharmacy: json['testPharmacy'] as bool?,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      primaryPhoneNumber: json['primaryPhoneNumber'] as String?,
      defaultTimeZone: json['defaultTimeZone'] as String?,
      pharmacistInCharge: json['pharmacistInCharge'] as String?,
      postalCodes: (json['postalCodes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      deliverableStates: (json['deliverableStates'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      pharmacyHours: json['pharmacyHours'] as String?,
      deliverySubsidyAmount: json['deliverySubsidyAmount'] as String?,
      pharmacySystem: json['pharmacySystem'] as String?,
      acceptInvalidAddress: json['acceptInvalidAddress'] as bool?,
      pharmacyType: json['pharmacyType'] as String?,
      checkoutPharmacy: json['checkoutPharmacy'] as bool?,
      marketplacePharmacy: json['marketplacePharmacy'] as bool?,
      importActive: json['importActive'] as bool?,
    );

Map<String, dynamic> _$PharmacyValueToJson(PharmacyValue instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pharmacyChainId': instance.pharmacyChainId,
      'name': instance.name,
      'active': instance.active,
      'localId': instance.localId,
      'testPharmacy': instance.testPharmacy,
      'address': instance.address,
      'primaryPhoneNumber': instance.primaryPhoneNumber,
      'defaultTimeZone': instance.defaultTimeZone,
      'pharmacistInCharge': instance.pharmacistInCharge,
      'postalCodes': instance.postalCodes,
      'deliverableStates': instance.deliverableStates,
      'pharmacyHours': instance.pharmacyHours,
      'deliverySubsidyAmount': instance.deliverySubsidyAmount,
      'pharmacySystem': instance.pharmacySystem,
      'acceptInvalidAddress': instance.acceptInvalidAddress,
      'pharmacyType': instance.pharmacyType,
      'checkoutPharmacy': instance.checkoutPharmacy,
      'marketplacePharmacy': instance.marketplacePharmacy,
      'importActive': instance.importActive,
    };
