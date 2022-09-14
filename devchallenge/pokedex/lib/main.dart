import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokedex/blocs/filter/filter_cubit.dart';
import 'package:pokedex/blocs/pokemon/pokemon_cubit.dart';
import 'package:pokedex/screens/home/home_screen.dart';
import 'package:pokedex/screens/splash_screen.dart';
import 'package:pokedex/services/http/i_http_service.dart';
import 'package:pokedex/services/http/uno_service.dart';
import 'package:pokedex/utils/constants.dart';
import 'package:pokedex/widgets/custom_scroll_behavior.dart';
import 'package:provider/provider.dart';
import 'package:uno/uno.dart';

void main() async {
  await initHiveForFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    final theme = ThemeData(
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
    );

    final client = ValueNotifier(
      GraphQLClient(
        link: HttpLink('https://beta.pokeapi.co/graphql/v1beta'),
        cache: GraphQLCache(store: HiveStore()),
      ),
    );

    return MultiProvider(
      providers: [
        Provider(create: (_) => Uno()),
        Provider<IHttpService>(create: (_) => UnoService(_.read())),
        BlocProvider<PokemonCubit>(
          create: (_) => PokemonCubit(_.read()),
        ),
        BlocProvider<FilterCubit>(
          create: (_) => FilterCubit(),
        ),
      ],
      child: GraphQLProvider(
        client: client,
        child: MaterialApp(
          title: 'Pokédex',
          initialRoute: '/',
          theme: theme,
          scrollBehavior: CustomScrollBehavior(),
          debugShowCheckedModeBanner: false,
          routes: {
            '/home': (BuildContext context) => const HomeScreen(),
            '/': (BuildContext context) => const SplashScreen(),
          },
        ),
      ),
    );
  }
}
