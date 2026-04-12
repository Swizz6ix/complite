import 'package:complite/core/events/fetch_company_data.dart';
import 'package:complite/core/handlers/event_handler.dart';
import 'package:complite/core/providers/network_info.dart';
import 'package:complite/core/states/results.dart';
import 'package:complite/features/company/data/dto/company_dto.dart';
import 'package:complite/features/company/data/repositories/company_repository.dart';
import 'package:complite/features/company/data/repositories/queue_repository.dart';

class FetchCompanyHandler implements EventHandler<FetchCompanyData, Results<List<CompanyDto>>> {
  final CompanyRepository repository;

  FetchCompanyHandler(this.repository);

  @override
  Future<Results<List<CompanyDto>>> handle(FetchCompanyData event) async {
    event.stopwatch?.start();

    try {
      // Optional simulated API delay
      await Future.delayed(Duration(milliseconds: 300));

      // fetch from API
      return await repository.fetchCompany(event.requestId,
        // page: event.page,
        // limit: event.limit,
      );

    } finally {
      event.stopwatch?.stop();
    }
  }
}