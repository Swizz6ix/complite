import 'package:complite/features/company/data/dto/company_dto.dart';

abstract class LocalDataSource {
  Stream<List<CompanyDto>> watchCompanies();
  Future<void> saveCompanies(List<CompanyDto> companies);
  Future<List<CompanyDto>> getCompanies();
}