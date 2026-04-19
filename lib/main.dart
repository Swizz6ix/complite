import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:logging/logging.dart';

import 'package:complite/core/providers/database_provider.dart';
import 'package:complite/core/utilities/queue_item.dart';
import 'package:complite/features/company/presentation/company_list_page.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initFileLogger('compile');
  // final logger = Logger('compile-app');
  // logger.info('app start');

  final dir = await getApplicationDocumentsDirectory();

  final isar = await Isar.open(
    [QueueItemSchema],
    directory: dir.path,
  );

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(isar),
      ],
      // observers: [ProviderLogger()],
      child: const MainApp()
    )
    );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.menu_rounded),
          ),
          title: Text('COMPLITE'),
          actions: const [
            IconButton(
              onPressed: null, 
              icon: Icon(Icons.search),
            ),

            IconButton(
              onPressed: null, 
              icon: Icon(Icons.more_vert)
            )
          ],
        ),
        body: CompanyListPage(),
      ),
    );
  }
}