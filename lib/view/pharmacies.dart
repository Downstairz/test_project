import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/models/order.dart';
import 'package:test_project/widgets/dialog.dart';
import '../constants.dart';
import '../cubits/pharmacy_cubit.dart';
import '../cubits/pharmacy_states.dart';
import '../models/pharmacy_tier.dart';
import '../on_generate_route.dart';
import 'package:collection/collection.dart';

class Pharmacies extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PharmaciesState();
}

class _PharmaciesState extends State<Pharmacies> {
  PharmacyCubit get cubit => context.read();
  List<PharmacyTier>? _pharmacies;
  List<Order>? _orders = [];

  @override
  initState() {
    super.initState();
    cubit.loadData();
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<PharmacyCubit, PharmacyState>(
        listenWhen: (_, next) => next is PharmacyError || next is PharmacyData,
        listener: (_, state) {
          if (state is PharmacyError) {
            DialogAlert.alert(context, state.message);
            return;
          }

          if (state is PharmacyData) {
            _pharmacies = state.pharmacies;
            _orders = state.orders;
          }
        },
        buildWhen: (_, next) => !(next is PharmacyError),
        builder: (_, state) {
          if (state is PharmacyLoading) return CircularProgressIndicator();
          return Scaffold(
            appBar: AppBar(title: Text(Constants.pharmacies)),
            body: _body(),
          );
        },
      );

  Widget _body() => Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(child: PharmacyListView(_pharmacies, _orders)),
          TextButton(
            style: TextButton.styleFrom(textStyle: TextStyle(fontSize: 20.0)),
            onPressed: _orderMedication,
            child: Text(Constants.orderMedication),
          ),
        ],
      ),
    );

  Future<void> _orderMedication() async {
    final noPharmacyNearBy = (_orders?.length ?? 0) == (_pharmacies?.length ?? 0);
    if (noPharmacyNearBy) {
      DialogAlert.alert(context, Constants.noPharmacy);
      return;
    }
    await Navigator.of(context).pushNamed(NameRoutes.medicationOrder);
    cubit.loadData();
  }
}

typedef showOrderInProgress = void Function(int index);

class PharmacyListView extends StatelessWidget {
  final List<PharmacyTier>? pharmacies;
  final List<Order>? orders;

  PharmacyListView(this.pharmacies, this.orders,);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pharmacies?.length ?? 0,
      itemBuilder: (_, int index) => GestureDetector(
        onTap: () => _goToDetails(index, context),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Card(
            child: ListTile(
              leading: Icon(
                _showOrderInProgress(index)
                    ? Icons.check_box_outlined
                    : Icons.check_box_outline_blank_rounded,
                color: Colors.blue,
                size: 30,
              ),
              title: Text(
                  pharmacies?[index].name ?? Constants.missingPharmacyName),
            ),
          ),
        ),
      ),
    );
  }

  bool _showOrderInProgress(int index) {
    String? pharmacyId = pharmacies?[index].pharmacyId;
    return orders?.any((order) => order.pharmacyId == pharmacyId) ?? false;
  }

  Future<void> _goToDetails(int index, context) async {
    final pharmacyId = pharmacies?[index].pharmacyId;
    Navigator.of(context).pushNamed(NameRoutes.pharmacyDetails,
        arguments: {'pharmacyId': pharmacyId, 'order': _getOrder(pharmacyId!)});
  }

  Order? _getOrder(String pharmacyId) =>
      orders?.firstWhereOrNull((order) => order.pharmacyId == pharmacyId);

}
