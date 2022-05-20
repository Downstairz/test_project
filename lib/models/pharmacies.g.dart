// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pharmacies _$PharmaciesFromJson(Map<String, dynamic> json) => Pharmacies(
      pharmacies: (json['pharmacies'] as List<dynamic>?)
          ?.map((e) => PharmacyTier.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PharmaciesToJson(Pharmacies instance) =>
    <String, dynamic>{
      'pharmacies': instance.pharmacies,
    };
