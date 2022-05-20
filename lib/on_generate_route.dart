import 'package:flutter/material.dart';
import 'package:test_project/view/pharmacy_detail.dart';

import 'view/medication_order.dart';

class NameRoutes {
  static const pharmacyDetails = 'pharmacy-details';
  static const medicationOrder = 'medication-order';
}

Route<dynamic>? onGenerateRoute(settings) {
  if (settings.name == NameRoutes.pharmacyDetails) {
    final data = settings.arguments;
    return MaterialPageRoute(
      builder: (context) => PharmacyDetail(
          pharmacyId: data['pharmacyId'], order: data['order']),
    );
  }

  if (settings.name == NameRoutes.medicationOrder)
    return MaterialPageRoute(builder: (context) => MedicationOrder());

  return null;
}
