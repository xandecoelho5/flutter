part of 'get_single_user_cubit.dart';

abstract class GetSingleUserState extends Equatable {
  const GetSingleUserState();
}

class GetSingleUserInitial extends GetSingleUserState {
  @override
  List<Object> get props => [];
}

class GetSingleUserLoading extends GetSingleUserState {
  @override
  List<Object> get props => [];
}

class GetSingleUserLoaded extends GetSingleUserState {
  final UserEntity user;

  const GetSingleUserLoaded(this.user);

  @override
  List<Object> get props => [];
}

class GetSingleUserFailure extends GetSingleUserState {
  @override
  List<Object> get props => [];
}
