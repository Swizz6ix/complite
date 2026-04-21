import 'package:complite/core/states/results.dart';
import 'package:complite/features/company/data/dto/company_dto.dart';

abstract class CompanyRepository {
  Future<List<CompanyDto>> fetchCompany(
    String requestId, 
    //{int page, int limit}
      );  
}