import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/events/event_pipeline.dart';
import 'package:complite/core/middlewares/middleware.dart';
import 'package:complite/core/providers/middleware_group_provider.dart';
import 'package:complite/core/providers/timeout_middleware_provider.dart';
import 'package:complite/core/registrations/middleware_registry.dart';
import 'package:complite/core/states/middleware_phase.dart';
import 'package:complite/core/states/results.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pipelineProvider = Provider<MiddlewareRegistry>((ref) {
  final all = ref.read(middlewareGroupProvider);

  return MiddlewareRegistry.fromList(all);
});