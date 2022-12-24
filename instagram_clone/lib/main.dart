import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:instagram_clone/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:instagram_clone/features/presentation/cubit/user/get_single_other_user/get_single_other_user_cubit.dart';
import 'package:instagram_clone/features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:instagram_clone/features/presentation/cubit/user/user_cubit.dart';
import 'package:instagram_clone/features/presentation/pages/credential/sign_in_page.dart';
import 'package:instagram_clone/features/presentation/pages/main_screen/main_screen.dart';
import 'package:instagram_clone/utils/consts.dart';
import 'package:instagram_clone/utils/on_generate_route.dart';

import './utils/injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthCubit>()..appStarted(context)),
        BlocProvider(create: (_) => di.sl<CredentialCubit>()),
        BlocProvider(create: (_) => di.sl<UserCubit>()),
        BlocProvider(create: (_) => di.sl<GetSingleUserCubit>()),
        BlocProvider(create: (_) => di.sl<GetSingleOtherUserCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Instagram Clone",
        darkTheme: ThemeData.dark(),
        onGenerateRoute: OnGenerateRoute.route,
        initialRoute: PageConst.home,
        routes: {
          PageConst.home: (context) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated) {
                  return MainScreen(uid: authState.uid);
                }
                return const SignInPage();
              },
            );
          }
        },
      ),
    );
  }
}
