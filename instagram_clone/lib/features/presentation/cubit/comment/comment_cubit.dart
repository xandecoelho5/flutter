import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/comment/create_comment_usecase.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/comment/delete_comment_usecase.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/comment/like_comment_usecase.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/comment/read_comments_usecase.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/comment/update_comment_usecase.dart';

import '../../../domain/entities/comment/comment_entity.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  final CreateCommentUseCase createCommentUseCase;
  final DeleteCommentUseCase deleteCommentUseCase;
  final UpdateCommentUseCase updateCommentUseCase;
  final LikeCommentUseCase likeCommentUseCase;
  final ReadCommentsUseCase readCommentsUseCase;

  CommentCubit(
    this.createCommentUseCase,
    this.deleteCommentUseCase,
    this.updateCommentUseCase,
    this.likeCommentUseCase,
    this.readCommentsUseCase,
  ) : super(CommentInitial());

  Future<void> getComments(String postId) async {
    emit(CommentLoading());
    try {
      final streamResponse = readCommentsUseCase(postId);
      streamResponse.listen((comments) => emit(CommentLoaded(comments)));
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> likeComment(CommentEntity comment) async {
    try {
      await likeCommentUseCase(comment);
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> updateComment(CommentEntity comment) async {
    try {
      await updateCommentUseCase(comment);
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> deleteComment(CommentEntity comment) async {
    try {
      await deleteCommentUseCase(comment);
    } catch (_) {
      emit(CommentFailure());
    }
  }

  Future<void> createComment(CommentEntity comment) async {
    try {
      await createCommentUseCase(comment);
    } catch (_) {
      emit(CommentFailure());
    }
  }
}
