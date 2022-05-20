import '../models/pharmacies.dart';
import '../models/pharmacy.dart';
import '../models/pharmacy_tier.dart';
import '../service/pharmacy_service.dart';

abstract class PharmacyRepository {
  Future<Pharmacy?> getPharmacy({required String pharmacyId});
  Future<List<PharmacyTier>?> getPharmacies();
  Future<String?> getMedications();
}

class ServicePharmacyRepository extends PharmacyRepository {
  PharmacyService get _service => PharmacyService.instance;

  @override
  Future<Pharmacy?> getPharmacy({required String pharmacyId}) async => _service
      .getPharmacy(pharmacyId)
      .then((resp) => Pharmacy.fromJson(resp?.data));

  Future<List<PharmacyTier>?> getPharmacies() async =>
      _service.getPharmacies().then((resp) => resp?.pharmacies);

  @override
  Future<String?> getMedications() async =>
      _service.getMedications().then((resp) => resp?.data);
}
