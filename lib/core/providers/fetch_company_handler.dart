import 'package:complite/core/events/fetch_company_data.dart';
import 'package:complite/core/handlers/event_handler.dart';
import 'package:complite/core/handlers/fetch_company_handler.dart';
import 'package:complite/core/providers/company_repository_provider.dart';
import 'package:complite/core/providers/network_provider.dart';
import 'package:complite/core/providers/queue_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fetchCompanyHandlerProvider = Provider<EventHandler<FetchCompanyData, void>>((ref) {
  final repo = ref.read(companyRepositoryProvider);
  final queue = ref.read(queueRepositoryProvider);
  final network = ref.read(networkProvider);

  return FetchCompanyHandler(repo, queue, network);
});