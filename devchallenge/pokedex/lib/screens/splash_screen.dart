import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pokedex/blocs/pokemon/pokemon_cubit.dart';

import '../services/graphql/queries.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
    BlocProvider.of<PokemonCubit>(context).loadInitialPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Query(
        options: QueryOptions(document: gql(pokeAPIQuery)),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.isLoading) {
            return Center(
              child: Column(
                children: const [
                  CircularProgressIndicator(),
                  Text('Fetching Pokemons...'),
                ],
              ),
            );
          }

          var repositories = result.data;
          print(repositories);

          if (repositories == null) {
            return const Text('No pokemon data found!');
          }

          return const Text('No pokemon data found!');
        },
      ),
    );
  }
}
