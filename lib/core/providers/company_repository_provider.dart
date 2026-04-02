import 'package:complite/features/company/data/api/company_api.dart';
import 'package:complite/features/company/data/repositories/company_repository.dart';

final companyRepositoryProvider = Provider<CompanyRepository>((ref) {
  return CompanyApi();
});