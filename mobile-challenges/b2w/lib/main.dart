import 'package:b2w/screens/categoria_screen.dart';
import 'package:b2w/screens/home_screen.dart';
import 'package:b2w/screens/produto_screen.dart';
import 'package:b2w/screens/sobre_screen.dart';
import 'package:b2w/services/banner_service.dart';
import 'package:b2w/services/categoria_service.dart';
import 'package:b2w/services/produto_service.dart';
import 'package:b2w/services/uno_service.dart';
import 'package:b2w/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uno/uno.dart';

final getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<UnoService>(
    UnoService(Uno(baseURL: 'https://alodjinha.herokuapp.com')),
  );
  getIt.registerSingleton<CategoriaService>(
    CategoriaService(getIt.get<UnoService>()),
  );
  getIt.registerSingleton<BannerService>(
    BannerService(getIt.get<UnoService>()),
  );
  getIt.registerSingleton<ProdutoService>(
    ProdutoService(getIt.get<UnoService>()),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'a Lodjinha',
      theme: ThemeData(
        colorScheme: const ColorScheme.light().copyWith(
          primary: kWarmPurple,
          secondary: kWarmPurple,
        ),
        fontFamily: 'Roboto',
      ),
      initialRoute: Routes.home,
      debugShowCheckedModeBanner: false,
      routes: {
        Routes.home: (context) => const HomeScreen(),
        Routes.categoria: (context) => const CategoriaScreen(),
        Routes.produto: (context) => const ProdutoScreen(),
        Routes.sobre: (context) => const SobreScreen(),
      },
    );
  }
}
