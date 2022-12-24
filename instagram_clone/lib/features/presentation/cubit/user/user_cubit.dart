import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/user/follow_unfollow_user_usecase.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/user/get_users_usecase.dart';

import '../../../domain/entities/user/user_entity.dart';
import '../../../domain/usecases/firebase_usecases/user/update_user_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UpdateUserUseCase updateUserUseCase;
  final GetUsersUseCase getUsersUseCase;
  final FollowUnFollowUseCase followUnFollowUseCase;

  UserCubit(
    this.updateUserUseCase,
    this.getUsersUseCase,
    this.followUnFollowUseCase,
  ) : super(UserInitial());

  Future<void> getUsers(UserEntity user) async {
    emit(UserLoading());
    try {
      final streamResponse = getUsersUseCase(user);
      streamResponse.listen((users) => emit(UserLoaded(users)));
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> updateUser(UserEntity user) async {
    try {
      await updateUserUseCase(user);
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> followUnFollowUser(UserEntity user) async {
    try {
      await followUnFollowUseCase(user);
    } catch (_) {
      emit(UserFailure());
    }
  }
}
