import 'package:complite/features/company/presentation/company_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (_) => const CompanyScreen(),
                ),
              );
            }, 
            child: const Text("Open Companies"),
          ),
        ),
      );
  }
}