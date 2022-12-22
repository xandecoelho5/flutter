import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/post/read_posts_usecase.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/post/update_post_usecase.dart';

import '../../../domain/entities/posts/post_entity.dart';
import '../../../domain/usecases/firebase_usecases/post/create_post_usecase.dart';
import '../../../domain/usecases/firebase_usecases/post/delete_post_usecase.dart';
import '../../../domain/usecases/firebase_usecases/post/like_post_usecase.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final CreatePostUseCase createPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final LikePostUseCase likePostUseCase;
  final ReadPostsUseCase readPostsUseCase;

  PostCubit(
    this.createPostUseCase,
    this.deletePostUseCase,
    this.updatePostUseCase,
    this.likePostUseCase,
    this.readPostsUseCase,
  ) : super(PostInitial());

  Future<void> getPosts(PostEntity post) async {
    emit(PostLoading());
    try {
      final streamResponse = readPostsUseCase(post);
      streamResponse.listen((posts) => emit(PostLoaded(posts)));
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> likePost(PostEntity post) async {
    try {
      await likePostUseCase(post);
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> updatePost(PostEntity post) async {
    try {
      await updatePostUseCase(post);
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> deletePost(PostEntity post) async {
    try {
      await deletePostUseCase(post);
    } catch (_) {
      emit(PostFailure());
    }
  }

  Future<void> createPost(PostEntity post) async {
    try {
      await createPostUseCase(post);
    } catch (_) {
      emit(PostFailure());
    }
  }
}
