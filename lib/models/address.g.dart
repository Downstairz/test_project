// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      streetAddress1: json['streetAddress1'] as String?,
      city: json['city'] as String?,
      usTerritory: json['usTerritory'] as String?,
      postalCode: json['postalCode'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      addressType: json['addressType'] as String?,
      externalType: json['externalType'] as String?,
      externalId: json['externalId'] as String?,
      isValid: json['isValid'] as bool?,
      googlePlaceId: json['googlePlaceId'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'streetAddress1': instance.streetAddress1,
      'city': instance.city,
      'usTerritory': instance.usTerritory,
      'postalCode': instance.postalCode,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'addressType': instance.addressType,
      'externalType': instance.externalType,
      'externalId': instance.externalId,
      'isValid': instance.isValid,
      'googlePlaceId': instance.googlePlaceId,
    };
