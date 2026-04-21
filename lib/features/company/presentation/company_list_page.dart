import 'package:complite/core/providers/company_providers.dart';
import 'package:complite/core/utilities/cancellation_token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompanyListPage extends ConsumerWidget {
  const CompanyListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(companyProvider);

    return Center(
      child: state.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        data: (companies) => RefreshIndicator(
          onRefresh: () async {
            await ref.read(companyProvider.notifier).refresh();
          }, 
          child: Column(
            children: [ 
              Expanded(
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                itemCount: companies.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(companies[index].name),
                    subtitle: Text(companies[index].industry),
                  );
                }),
              ),
            ]
          )
        ),
        error: (err, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Error: $err"),
              const SizedBox(width: 12,),
              ElevatedButton(
                onPressed: () {
                  ref.read(companyProvider.notifier).refresh();
                }, 
                child: const Text("Retry"),
              ),
            ],
          ),
        )
      ),
    );
  }
}