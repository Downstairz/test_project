// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pharmacy _$PharmacyFromJson(Map<String, dynamic> json) => Pharmacy(
      responseCode: json['responseCode'] as String?,
      href: json['href'] as String?,
      details: json['details'] as String?,
      generatedTs: json['generatedTs'] as String?,
      value: json['value'] == null
          ? null
          : PharmacyValue.fromJson(json['value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PharmacyToJson(Pharmacy instance) => <String, dynamic>{
      'responseCode': instance.responseCode,
      'href': instance.href,
      'details': instance.details,
      'generatedTs': instance.generatedTs,
      'value': instance.value,
    };
