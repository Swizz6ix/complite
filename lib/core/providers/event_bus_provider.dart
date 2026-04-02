import 'package:complite/core/events/event_bus.dart';
import 'package:complite/core/events/fetch_company_data.dart';
import 'package:complite/core/handlers/fetch_company_handler.dart';
import 'package:complite/core/middlewares/pipeline.dart';
import 'package:complite/core/providers/company_repository_provider.dart';
import 'package:complite/core/providers/network_provider.dart';
import 'package:complite/core/providers/queue_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventBusProvider = Provider<EventBus>((ref) {
  final repo = ref.read(companyRepositoryProvider);
  final queueRepo = ref.read(queueRepositoryProvider);
  final network = ref.read(networkProvider); 

  final bus = EventBus(middlewares: deFaultPipeline.all, handlers: {
    FetchCompanyData: [FetchCompanyHandler(repo, queueRepo, network)],
  });


  return bus;
});