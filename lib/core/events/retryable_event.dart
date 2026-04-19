
import 'package:complite/core/events/company_event.dart';

abstract base class RetryableEvent<T extends CompanyEvent<T>> extends CompanyEvent<T> {

  RetryableEvent({
    super.requestId,
    super.stopwatch,
    super.retryCount,
  });

  T createWithRetry() {
    return createInternal(
      requestId: requestId,
      stopwatch:  stopwatch,
      retryCount:  retryCount,
    );
  }
}