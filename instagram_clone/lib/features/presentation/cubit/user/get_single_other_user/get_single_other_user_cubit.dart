import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/user/get_single_other_user_usecase.dart';

part 'get_single_other_user_state.dart';

class GetSingleOtherUserCubit extends Cubit<GetSingleOtherUserState> {
  final GetSingleOtherUserUseCase getSingleOtherUserUseCase;

  GetSingleOtherUserCubit(this.getSingleOtherUserUseCase)
      : super(GetSingleOtherUserInitial());

  Future<void> getSingleOtherUser(String otherUid) async {
    emit(GetSingleOtherUserLoading());
    try {
      final streamResponse = getSingleOtherUserUseCase(otherUid);
      streamResponse.listen(
        (users) => emit(GetSingleOtherUserLoaded(users.first)),
      );
    } catch (_) {
      emit(GetSingleOtherUserFailure());
    }
  }
}
