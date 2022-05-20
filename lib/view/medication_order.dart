import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/models/order.dart';
import 'package:test_project/widgets/dialog.dart';
import '../constants.dart';
import '../cubits/pharmacy_cubit.dart';
import '../cubits/pharmacy_states.dart';
import '../models/pharmacy_value.dart';

class MedicationOrder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MedicationOrderState();
}

class _MedicationOrderState extends State<MedicationOrder> {
  PharmacyCubit get cubit => context.read();
  late List<String>? _medications;
  late PharmacyValue? _nearestPharmacy;
  final _medicationListViewKey = GlobalKey<MedicationListViewState>();

  @override
  initState() {
    super.initState();
    cubit.getOrderingData();
  }

  bool _buildWhen(_, next) => !(next is PharmacyError);

  bool _listenWhen(_, next) =>
      next is PharmacyError ||
      next is PharmacyOrderData ||
      next is PharmacyOrderComplete;

  void _listener(_, state) {
    if (state is PharmacyError) {
      DialogAlert.alert(context, state.message);
      return;
    }

    if (state is PharmacyOrderComplete) {
      Navigator.of(context).pop();
    }

    if (state is PharmacyOrderData) {
      _medications = state.medications;
      _nearestPharmacy = state.nearestPharmacy;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PharmacyCubit, PharmacyState>(
      listenWhen: _listenWhen,
      listener: _listener,
      buildWhen: _buildWhen,
      builder: (_, state) {
        if (state is PharmacyLoading) return CircularProgressIndicator();
        return Scaffold(
          appBar: AppBar(title: Text(Constants.pharmacyDetail)),
          body: _body(),
        );
      },
    );
  }

  Widget _body() => Column(
        children: [
          Expanded(
            child: MedicationListView(
              _medications,
              _completeOrder,
              key: _medicationListViewKey,
            ),
          ),
          TextButton(
            onPressed: _completeOrder,
            style: TextButton.styleFrom(textStyle: TextStyle(fontSize: 20.0)),
            child: Text(Constants.completeOrder),
          ),
        ],
      );

  void _completeOrder() {
    final selectedMedication =
        _medicationListViewKey.currentState?.selectedMedication;
    if (selectedMedication?.isEmpty ?? true) {
      DialogAlert.alert(context, Constants.makeSelection);
      return;
    }

    final order = Order(
        pharmacyId: _nearestPharmacy!.id,
        medications: selectedMedication?.toList());
    cubit.saveOrder(order: order);
  }
}

typedef CompleteOrderCallback = void Function();

class MedicationListView extends StatefulWidget {
  final List<String>? medications;
  final CompleteOrderCallback completeOrderCallback;

  MedicationListView(this.medications, this.completeOrderCallback, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => MedicationListViewState();
}

class MedicationListViewState extends State<MedicationListView> {
  Set<String> _selectedMedication = {};
  List<String> get selectedMedication => _selectedMedication.toList();

  bool _isSelected(int index) =>
      _selectedMedication.contains(widget.medications?[index]);
  bool _hasBeenAdded(String medicine) => _selectedMedication.contains(medicine);

  @override
  Widget build(BuildContext context) => ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: widget.medications?.length ?? 0,
        itemBuilder: (_, int index) => GestureDetector(
          onTap: () => _handleMedication(widget.medications![index]),
          child: Card(
            child: ListTile(
              leading: Icon(
                _isSelected(index)
                    ? Icons.check_box_outlined
                    : Icons.check_box_outline_blank_rounded,
                color: Colors.blue,
                size: 30,
              ),
              title: Text(widget.medications?[index] ??
                  Constants.missingMedicationName),
            ),
          ),
        ),
      );

  void _handleMedication(String medication) {
    setState(() {
      if (_hasBeenAdded(medication)) {
        _selectedMedication.remove(medication);
      } else {
        _selectedMedication.add(medication);
      }
    });
  }
}
