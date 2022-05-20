import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/widgets/dialog.dart';
import '../constants.dart';
import '../cubits/pharmacy_cubit.dart';
import '../cubits/pharmacy_states.dart';
import '../models/order.dart';
import '../models/pharmacy.dart';
import '../models/pharmacy_value.dart';

class PharmacyDetail extends StatefulWidget {
  final String pharmacyId;
  final Order? order;
  PharmacyDetail({required this.pharmacyId, this.order});

  @override
  State<StatefulWidget> createState() => _PharmacyDetailState();
}

class _PharmacyDetailState extends State<PharmacyDetail> {
  PharmacyCubit get cubit => context.read();
  late final Pharmacy? _pharmacy;

  @override
  initState() {
    cubit.getPharmacy(pharmacyId: widget.pharmacyId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<PharmacyCubit, PharmacyState>(
        listenWhen: _listenWhen,
        listener: _listener,
        buildWhen: _buildWhen,
        builder: (_, state) {
          if (state is PharmacyLoading) return Container();
          return Scaffold(
            appBar: AppBar(title: Text(Constants.pharmacyDetail)),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: _body(),
            ),
          );
        },
      );

  bool _buildWhen(_, next) => !(next is PharmacyError);

  bool _listenWhen(_, next) =>
      next is PharmacyError || next is PharmacyDetailData;

  void _listener(_, state) {
    if (state is PharmacyError) {
      DialogAlert.alert(context, state.message);
      return;
    }

    if (state is PharmacyDetailData) {
      _pharmacy = state.pharmacy;
    }
  }

  Widget _rowWidget(String title, String value) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text(
            value,
            maxLines: 2,
            style: TextStyle(
              fontSize: 16.0,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      );

  Widget _body() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 16.0),
          Text(
            _pharmacy?.details ?? '',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 16.0),
          _rowWidget(
            Constants.address,
            _pharmacy?.value?.addressDisplay ?? 'No Address',
          ),
          SizedBox(height: 16.0),
          _rowWidget(
            Constants.phoneNumber,
            _pharmacy?.value?.primaryPhoneNumber ??
                'Pharmacy phone number not available',
          ),
          SizedBox(height: 16.0),
          _rowWidget(
              'Hours',
              _pharmacy?.value?.pharmacyHours?.replaceAll('\\n', '\n') ??
                  'Pharmacy Hours not available'),
          SizedBox(height: 20.0),
          Expanded(child: MedicationListView(widget.order)),
        ],
      );
}

class MedicationListView extends StatelessWidget {
  final Order? order;

  MedicationListView(this.order);

  @override
  Widget build(BuildContext context) {
    if (order?.medications?.isEmpty ?? true) return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Constants.listOfMedication,
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(height: 16.0),
        Expanded(
          child: ListView.builder(
            itemCount: order?.medications?.length ?? 0,
            itemBuilder: (_, int index) => Container(
              color: Colors.white,
              child: Card(
                child: ListTile(
                  leading: Icon(
                    Icons.medical_information,
                    color: Colors.blue,
                    size: 30,
                  ),
                  title: Text(order?.medications?[index] ?? ''),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
