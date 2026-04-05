import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/events/event_bus.dart';
import 'package:complite/core/events/fetch_company_data.dart';
import 'package:complite/features/company/data/dto/company_dto.dart';
import 'package:complite/features/company/data/repositories/queue_repository.dart';

class ReplayEngine {
  final QueueRepository queue;
  final EventBus bus;

  ReplayEngine(this.queue, this.bus);

  Future<void> replay() async {
    final events = await queue.getPending();

    for (final event in events) {
      try {
        if (event is FetchCompanyData) {
          await bus.dispatch(event);
        }
        await queue.remove(event);
      } catch (e) {
        // Stop on first failure (preserve order)
        break;
      }
    }
  }
}