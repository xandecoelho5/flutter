import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/blocs/filter/filter_cubit.dart';
import 'package:pokedex/screens/home/home_screen.dart';
import 'package:pokedex/services/i_http_service.dart';
import 'package:pokedex/services/uno_service.dart';
import 'package:pokedex/utils/constants.dart';
import 'package:pokedex/widgets/custom_scroll_behavior.dart';
import 'package:uno/uno.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<Uno>(Uno());
  getIt.registerSingleton<IHttpService>(UnoService(getIt<Uno>()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return MaterialApp(
      title: 'Pokédex',
      home: BlocProvider(
        create: (BuildContext context) => FilterCubit(),
        child: const HomeScreen(),
      ),
      theme: ThemeData(
        primaryColor: kTypePsychic,
        fontFamily: 'SF Pro Display',
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: kTypePsychic,
            ),
        buttonTheme: ButtonThemeData(
          buttonColor: kTypePsychic,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        ),
      ),
      scrollBehavior: CustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
    );
  }
}
