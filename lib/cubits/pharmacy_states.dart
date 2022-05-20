import 'package:equatable/equatable.dart';
import 'package:test_project/models/pharmacy_value.dart';
import '../models/order.dart';
import '../models/pharmacy.dart';
import '../models/pharmacy_tier.dart';

abstract class PharmacyState extends Equatable {
  const PharmacyState();

  @override
  List<Object?> get props => const [];

  @override
  bool get stringify => true;
}

class PharmacyInit extends PharmacyState {}

class PharmacyOrderComplete extends PharmacyState {}

class PharmacyLoading extends PharmacyState {
  final String message;

  const PharmacyLoading(this.message);

  @override
  List<Object> get props => [message];
}

class PharmacyError extends PharmacyState {
  final String message;

  const PharmacyError(this.message);

  @override
  List<Object> get props => [message];
}

class PharmacyData extends PharmacyState {
  final List<PharmacyTier>? pharmacies;
  final List<Order>? orders;

  const PharmacyData({this.pharmacies, this.orders});

  @override
  List<Object?> get props => [pharmacies];
}

class PharmacyDetailData extends PharmacyState {
  final Pharmacy? pharmacy;

  const PharmacyDetailData({this.pharmacy});

  @override
  List<Object?> get props => [pharmacy];
}

class PharmacyOrderData extends PharmacyState {
  final List<String>? medications;
  final PharmacyValue? nearestPharmacy;

  const PharmacyOrderData({this.medications, this.nearestPharmacy});

  @override
  List<Object?> get props => [medications, nearestPharmacy];
}


