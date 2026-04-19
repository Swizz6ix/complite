import 'package:complite/core/events/company_event.dart';

abstract class QueueRepository {
  Future<void> enqueue(CompanyEvent event);
  Future<List<CompanyEvent>> getPending();
  Future<void> markProcessing(String requestId);
  Future<void> markCompleted(String requestId);
  Future<void> markFailed(String requestId);
  Future<void> incrementRetry(String requestId);
  Future<void> remove(String requestId);
  Future<void> moveToDeadLetter(CompanyEvent event);
  Future<List<CompanyEvent>> getDeadLetter();
}