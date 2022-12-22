import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user/user_entity.dart';
import '../../../domain/usecases/firebase_usecases/user/sign_in_user_usecase.dart';
import '../../../domain/usecases/firebase_usecases/user/sign_up_user_usecase.dart';

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final SignInUserUseCase signInUseCase;
  final SignUpUserUseCase signUpUseCase;

  CredentialCubit(
    this.signInUseCase,
    this.signUpUseCase,
  ) : super(CredentialInitial());

  Future<void> signInUser(String email, String password) async {
    emit(CredentialLoading());
    try {
      await signInUseCase(UserEntity(email: email, password: password));
      emit(CredentialSuccess());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> signUpUser(UserEntity user) async {
    emit(CredentialLoading());
    try {
      await signUpUseCase(user);
      emit(CredentialSuccess());
    } catch (_) {
      emit(CredentialFailure());
    }
  }
}
