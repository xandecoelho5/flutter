import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/user/user_entity.dart';

import '../../../../domain/usecases/firebase_usecases/user/get_single_user_usecase.dart';

part 'get_single_user_state.dart';

class GetSingleUserCubit extends Cubit<GetSingleUserState> {
  final GetSingleUserUseCase getSingleUserUseCase;

  GetSingleUserCubit(this.getSingleUserUseCase) : super(GetSingleUserInitial());

  Future<void> getSingleUser(String uid) async {
    emit(GetSingleUserLoading());
    try {
      final streamResponse = getSingleUserUseCase(uid);
      streamResponse.listen((users) => emit(GetSingleUserLoaded(users.first)));
    } catch (_) {
      emit(GetSingleUserFailure());
    }
  }
}
