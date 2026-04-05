import 'dart:async';

import 'package:complite/features/company/data/dto/company_dto.dart';
import 'package:complite/features/company/data/repositories/local_data_source.dart';

class InMemoryLocalDataSource implements LocalDataSource {
  final _controller = StreamController<List<CompanyDto>>.broadcast();
  List<CompanyDto> _cache = [];

  @override
  Stream<List<CompanyDto>> watchCompanies() => _controller.stream;

  @override
  Future<void> saveCompanies(List<CompanyDto> companies) async {
    _cache = companies;
    _controller.add(_cache);
  }
  @override
  Future<List<CompanyDto>> getCompanies() async => _cache;
}