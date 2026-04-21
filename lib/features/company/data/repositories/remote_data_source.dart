import 'package:complite/core/states/results.dart';
import 'package:complite/features/company/data/dto/company_dto.dart';

abstract class RemoteDataSource {
  Future<List<CompanyDto>> fetchCompanies(
    // string requestId, {int page, int limit}
  );
}