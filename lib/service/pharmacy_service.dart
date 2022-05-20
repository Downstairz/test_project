import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:test_project/models/pharmacies.dart';
import 'package:path_provider/path_provider.dart';

class PharmacyService {
  static final PharmacyService _singleton = PharmacyService._internal();
  static PharmacyService get instance => _singleton;
  factory PharmacyService() => _singleton;
  PharmacyService._internal();

  static String get _baseUrl => 'https://api-qa-demo.nimbleandsimple.com';
  static String get _pharmacyUrl => 'pharmacies/info';
  static String get _medicationListUrl =>
      'https://s3-us-west-2.amazonaws.com/assets.nimblerx.com/prod/medicationListFromNIH/medicationListFromNIH.txt';

  final _dio = Dio();

  Future<Response?> getPharmacy(pharmacyId) async {
    Response? pharmacyResponse;
    try {
      pharmacyResponse = await _dio.get('$_baseUrl/$_pharmacyUrl/$pharmacyId');
      print(pharmacyResponse);
    } on DioError catch (e) {
      print('Dio Error ${e.response?.statusCode ?? ''}');
    }
    return pharmacyResponse;
  }

  Future<Pharmacies?> getPharmacies() async {
    final String response =
        await rootBundle.loadString('assets/pharmacies.json');
    final data = await json.decode(response);
    final pharmacies = Pharmacies.fromJson(data);
    return pharmacies;
  }

  Future<Response<String>?> getMedications() async {
    Response<String>? medicationsResponse;
    try {
      medicationsResponse = await _dio.get(_medicationListUrl,
          options: Options(responseType: ResponseType.plain));
    } on DioError catch (e) {
      print('Dio Error ${e.response?.statusCode ?? ''}');
    }

    return medicationsResponse;
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';
    Directory dir = await getApplicationDocumentsDirectory();
    path = '${dir.path}/$uniqueFileName.text';
    return path;
  }
}
