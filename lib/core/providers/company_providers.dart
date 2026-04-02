import 'package:complite/core/controllers/company_notifier.dart';
import 'package:complite/core/providers/event_bus_provider.dart';
import 'package:complite/features/company/data/dto/company_dto.dart';

final companyProvider = StateNotifierProvider<CompanyNotifier, Results<List<CompanyDto>>>((ref) {
  return CompanyNotifier(ref.read(eventBusProvider));
});