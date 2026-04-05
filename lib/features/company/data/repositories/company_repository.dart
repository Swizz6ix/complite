import 'package:complite/core/states/results.dart';
import 'package:complite/features/company/data/dto/company_dto.dart';
import 'package:complite/features/company/data/repositories/local_data_source.dart';

abstract class CompanyRepository {
  final LocalDataSource local;
  final RemoteDataSource remote;

  CompanyRepository(this.local, this.remote);

  Future<void> fetchAndCache() async {
    final result = await remote.fetchCompanies();

    if (result is Success<List<CompanyDto>>) {
      await local.saveCompanies(result.data);
    }
  }
  Future<Results<List<CompanyDto>>> fetchCompany(
    // String requestId, 
    // {
      // int page, 
      // int limit
      // }
      );
}