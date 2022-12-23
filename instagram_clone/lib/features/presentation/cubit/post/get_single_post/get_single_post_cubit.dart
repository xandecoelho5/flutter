import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/posts/post_entity.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/post/read_single_post_usecase.dart';

part 'get_single_post_state.dart';

class GetSinglePostCubit extends Cubit<GetSinglePostState> {
  final ReadSinglePostUseCase readSinglePostUseCase;

  GetSinglePostCubit(this.readSinglePostUseCase)
      : super(GetSinglePostInitial());

  Future<void> getSinglePost(String postId) async {
    emit(GetSinglePostLoading());
    try {
      final streamResponse = readSinglePostUseCase(postId);
      streamResponse.listen((post) => emit(GetSinglePostLoaded(post.first)));
    } catch (_) {
      emit(GetSinglePostFailure());
    }
  }
}
