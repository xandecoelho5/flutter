import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queue_management/src/configuration/pages/configuration_page.dart';
import 'package:queue_management/src/home/home_page.dart';
import 'package:queue_management/src/queue/queue_module.dart';

import 'configuration/configuration_module.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...queueModule,
        ...configurationModule,
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        routes: {
          '/': (_) => const HomePage(),
          '/config': (_) => const ConfigurationPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
