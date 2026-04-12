import 'package:complite/core/events/company_event.dart';
import 'package:complite/core/events/fetch_company_data.dart';
import 'package:complite/core/providers/pipeline_provider.dart';
import 'package:complite/core/registrations/pipeline_registration.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pipelineRegistrationProvider = Provider((ref) {
  return [
    PipelineRegistration(
      FetchCompanyData,
      ref.read(pipelineProvider),
    ),
  ];
});