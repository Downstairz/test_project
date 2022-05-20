import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/cubits/pharmacy_cubit.dart';
import 'package:test_project/data/pharmacy_repo.dart';
import 'package:test_project/view/pharmacies.dart';

import 'on_generate_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => PharmacyCubit(repo: ServicePharmacyRepository())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Pharmacies(),
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
