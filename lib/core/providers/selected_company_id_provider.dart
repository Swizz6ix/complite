import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedCompanyIdProvider = StateProvider<String?>((ref){
  ref.listenSelf((prev, next) {
    print("companyId $prev --> $next");
  });
  return '14';
});