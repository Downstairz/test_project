import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/constants.dart';
import 'package:test_project/models/pharmacy_tier.dart';
import '../data/pharmacy_repo.dart';
import '../helper.dart';
import '../models/order.dart';
import '../models/pharmacy_value.dart';
import 'pharmacy_states.dart';

class Coordinates {
  static const double lat = 37.48771670017411;
  static const double long = -122.22652739630438;
}

class PharmacyCubit extends Cubit<PharmacyState> {
  final PharmacyRepository repo;
  List<String>? _medications;
  PharmacyValue? _nearestPharmacy;
  List<Order> _orders = [];
  List<PharmacyTier> _pharmacies = [];
  List<PharmacyValue>? _pharmaciesWithDetails = [];

  PharmacyCubit({required this.repo}) : super(PharmacyInit());

  Future<void> loadData() async {
    emit(PharmacyLoading('loading'));
    await getPharmacies();
    emit(PharmacyData(pharmacies: _pharmacies, orders: _orders));
  }

  Future<void> getPharmacy({required String pharmacyId}) async {
    emit(PharmacyLoading('loading'));
    final pharmacyData = await repo.getPharmacy(pharmacyId: pharmacyId);

    if (pharmacyData == null) {
      emit(PharmacyError(Constants.gettingPharmacyFailed));
      return;
    }

    emit(PharmacyDetailData(pharmacy: pharmacyData));
  }

  Future<void> getPharmacies() async {
    final pharmacies = await repo.getPharmacies();

    if (pharmacies == null) {
      emit(PharmacyError(Constants.readingPharmacyFileFailed));
      return;
    }

    _pharmacies = pharmacies;
  }

  Future<void> getMedications() async {
    emit(PharmacyLoading('loading'));
    final medicationData = await repo.getMedications();

    if (medicationData == null) {
      emit(PharmacyError(Constants.getMedicationListFailed));
      return;
    }

    final medications = medicationData.split(',');

    _medications = medications;
  }

  Future<void> getNearPharmacy() async {
    await Future.forEach(_pharmacies, (PharmacyTier pharmacy) async {
      final pharmacyId = pharmacy.pharmacyId!;
      final p = await repo.getPharmacy(pharmacyId: pharmacyId);
      if (p == null) return;
      _pharmaciesWithDetails?.add(p.value!);
    });

    _filterLastOrder();

    _nearestPharmacy = _pharmaciesWithDetails?.reduce((curr, next) {
      final pLat = curr.address!.latitude!;
      final pLong = curr.address!.longitude;
      final currDistance = GeoLocation.getDistanceFromLatLonInKm(
          Coordinates.lat, Coordinates.long, pLat, pLong);
      final nextDistance = GeoLocation.getDistanceFromLatLonInKm(
          Coordinates.lat, Coordinates.long, pLat, pLong);

      if (currDistance < nextDistance) return next;

      return curr;
    });
  }

  void _filterLastOrder() {
    _pharmaciesWithDetails?.removeWhere(
        (pv) => _orders.any((order) => order.pharmacyId == pv.id));
  }

  Future<void> getOrderingData() async {
    await getMedications();
    await getNearPharmacy();

    emit(PharmacyOrderData(
        medications: _medications, nearestPharmacy: _nearestPharmacy));
  }

  Future<void> saveOrder({required Order order}) async {
    _orders.add(order);
    emit(PharmacyOrderComplete());
  }
}
