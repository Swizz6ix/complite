import 'package:complite/core/controllers/company_notifier.dart';
import 'package:complite/core/providers/pipeline_provider.dart';
import 'package:complite/core/providers/event_bus_provider.dart';
import 'package:complite/core/states/results.dart';
import 'package:complite/features/company/data/dto/company_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final companyProvider = AsyncNotifierProvider<CompanyNotifier, List<CompanyDto>>(
  CompanyNotifier.new
);