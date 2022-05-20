import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  final String? streetAddress1;
  final String? city;
  final String? usTerritory;
  final String? postalCode;
  final double? latitude;
  final double? longitude;
  final String? addressType;
  final String? externalType;
  final String? externalId;
  final bool? isValid;
  final String? googlePlaceId;

  Address({
     this.streetAddress1,
     this.city,
     this.usTerritory,
     this.postalCode,
     this.latitude,
     this.longitude,
     this.addressType,
     this.externalType,
     this.externalId,
     this.isValid,
     this.googlePlaceId,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
