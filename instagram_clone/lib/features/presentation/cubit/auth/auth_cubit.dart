import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import '../../../domain/usecases/firebase_usecases/user/is_sign_in_usecase.dart';
import '../../../domain/usecases/firebase_usecases/user/sign_out_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignOutUseCase signOutUseCase;
  final IsSignInUseCase isSignInUseCase;
  final GetCurrentUidUseCase getCurrentUidUseCase;

  AuthCubit(
    this.signOutUseCase,
    this.isSignInUseCase,
    this.getCurrentUidUseCase,
  ) : super(AuthInitial());

  Future<void> appStarted(BuildContext context) async {
    try {
      final isSignIn = await isSignInUseCase();
      if (isSignIn) {
        final uid = await getCurrentUidUseCase();
        emit(Authenticated(uid));
      } else {
        emit(UnAuthenticated());
      }
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUidUseCase();
      emit(Authenticated(uid));
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async {
    try {
      await signOutUseCase();
      emit(UnAuthenticated());
    } catch (_) {
      emit(UnAuthenticated());
    }
  }
}
