import 'package:complite/core/events/fetch_company_data.dart';
import 'package:complite/core/providers/fetch_company_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final companyEventHandlersProvider = Provider((ref) {
  return {
    FetchCompanyData: [
      ref.read(fetchCompanyHandlerProvider),
    ],
  };
});