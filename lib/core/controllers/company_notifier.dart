import 'package:complite/core/events/event_bus.dart';
import 'package:complite/core/events/fetch_company_data.dart';
import 'package:complite/core/providers/event_bus_provider.dart';
import 'package:complite/core/providers/selected_company_id_provider.dart';
import 'package:complite/core/states/results.dart';
import 'package:complite/core/utilities/cancellation_token.dart';
import 'package:complite/features/company/data/dto/company_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompanyNotifier extends AsyncNotifier<List<CompanyDto>> {
  // final _logger = Logger('complite.notifier');
  CancellationToken? _activeToken;

  @override
  Future<List<CompanyDto>> build() async {
    // Rebuild automatically whenever selected company changes
    final companyId = ref.watch(selectedCompanyIdProvider);

    // No company selected
    if (companyId == null || companyId.isEmpty) {
      print("companyId null $companyId");
      return const [];
    }

    //cleanup when provider rebuilds/dispose
    ref.onDispose(() => _activeToken?.cancel());

    print("companyId not null $companyId");

    return _load(companyId);
  }
  

  Future<List<CompanyDto>> _load(String companyId) async {
    // Cancel previous in-flight request
    _activeToken?.cancel();
    
    final token = CancellationToken();
    _activeToken = token;

    final EventBus bus = ref.read(eventBusProvider);
   
    final result = await bus.dispatch<List<CompanyDto>>(
      FetchCompanyData(companyId),
      token: token,
    );

    print("result");

    return result;
  }

  Future<void> refresh() async {
    final companyId = ref.read(selectedCompanyIdProvider);
    if (companyId == null || companyId.isEmpty) {
      state = const AsyncData([]);
      return;
    }

    state = const AsyncLoading();

    state = await AsyncValue.guard(() => _load(companyId));
  }

  void selectCompany(String? companyId) {
    ref.read(selectedCompanyIdProvider.notifier).state = companyId;
  }
}