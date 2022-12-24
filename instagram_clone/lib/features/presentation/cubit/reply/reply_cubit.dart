import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/domain/entities/reply/reply_entity.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/reply/create_reply_usecase.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/reply/delete_reply_usecase.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/reply/like_reply_usecase.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/reply/read_reply_usecase.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/reply/update_reply_usecase.dart';

part 'reply_state.dart';

class ReplyCubit extends Cubit<ReplyState> {
  final CreateReplyUseCase createReplyUseCase;
  final DeleteReplyUseCase deleteReplyUseCase;
  final UpdateReplyUseCase updateReplyUseCase;
  final LikeReplyUseCase likeReplyUseCase;
  final ReadRepliesUseCase readRepliesUseCase;

  ReplyCubit(
    this.createReplyUseCase,
    this.deleteReplyUseCase,
    this.updateReplyUseCase,
    this.likeReplyUseCase,
    this.readRepliesUseCase,
  ) : super(ReplyInitial());

  Future<void> getReplies(ReplyEntity reply) async {
    emit(ReplyLoading());
    try {
      final streamResponse = readRepliesUseCase(reply);
      streamResponse.listen((replies) => emit(ReplyLoaded(replies)));
    } catch (_) {
      emit(ReplyFailure());
    }
  }

  Future<void> likeReply(ReplyEntity reply) async {
    try {
      await likeReplyUseCase(reply);
    } catch (_) {
      emit(ReplyFailure());
    }
  }

  Future<void> updateReply(ReplyEntity reply) async {
    try {
      await updateReplyUseCase(reply);
    } catch (_) {
      emit(ReplyFailure());
    }
  }

  Future<void> deleteReply(ReplyEntity reply) async {
    try {
      await deleteReplyUseCase(reply);
    } catch (_) {
      emit(ReplyFailure());
    }
  }

  Future<void> createReply(ReplyEntity reply) async {
    try {
      await createReplyUseCase(reply);
    } catch (_) {
      emit(ReplyFailure());
    }
  }
}
