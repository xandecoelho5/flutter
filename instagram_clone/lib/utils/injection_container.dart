import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram_clone/features/data/data_sources/remote_data_source/firebase_remote_data_source.dart';
import 'package:instagram_clone/features/data/data_sources/remote_data_source/firebase_remote_data_source_impl.dart';
import 'package:instagram_clone/features/data/repository/firebase_repository_impl.dart';
import 'package:instagram_clone/features/domain/repository/firebase_repository.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/comment/create_comment_usecase.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/comment/delete_comment_usecase.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/comment/like_comment_usecase.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/comment/read_comments_usecase.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/comment/update_comment_usecase.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/post/delete_post_usecase.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/post/like_post_usecase.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/post/read_posts_usecase.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/post/read_single_post_usecase.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/post/update_post_usecase.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/reply/create_reply_usecase.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/reply/delete_reply_usecase.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/reply/like_reply_usecase.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/reply/read_reply_usecase.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/reply/update_reply_usecase.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:instagram_clone/features/domain/usecases/firebase_usecases/user/sign_out_usecase.dart';
import 'package:instagram_clone/features/presentation/cubit/comment/comment_cubit.dart';
import 'package:instagram_clone/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:instagram_clone/features/presentation/cubit/post/get_single_post/get_single_post_cubit.dart';
import 'package:instagram_clone/features/presentation/cubit/post/post_cubit.dart';
import 'package:instagram_clone/features/presentation/cubit/reply/reply_cubit.dart';
import 'package:instagram_clone/features/presentation/cubit/user/user_cubit.dart';

import '../features/domain/usecases/firebase_usecases/post/create_post_usecase.dart';
import '../features/domain/usecases/firebase_usecases/user/create_user_usecase.dart';
import '../features/domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import '../features/domain/usecases/firebase_usecases/user/get_single_user_usecase.dart';
import '../features/domain/usecases/firebase_usecases/user/get_users_usecase.dart';
import '../features/domain/usecases/firebase_usecases/user/is_sign_in_usecase.dart';
import '../features/domain/usecases/firebase_usecases/user/sign_in_user_usecase.dart';
import '../features/domain/usecases/firebase_usecases/user/sign_up_user_usecase.dart';
import '../features/domain/usecases/firebase_usecases/user/update_user_usecase.dart';
import '../features/presentation/cubit/auth/auth_cubit.dart';
import '../features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubits
  //// User
  sl.registerFactory(() => AuthCubit(sl(), sl(), sl()));
  sl.registerFactory(() => CredentialCubit(sl(), sl()));
  sl.registerFactory(() => UserCubit(sl(), sl()));
  sl.registerFactory(() => GetSingleUserCubit(sl()));
  //// Post
  sl.registerFactory(() => PostCubit(sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => GetSinglePostCubit(sl()));
  //// Comment
  sl.registerFactory(() => CommentCubit(sl(), sl(), sl(), sl(), sl()));
  //// Reply
  sl.registerFactory(() => ReplyCubit(sl(), sl(), sl(), sl(), sl()));

  // Use Cases
  //// User
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => IsSignInUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUidUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUserUseCase(sl()));
  sl.registerLazySingleton(() => SignInUserUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserUseCase(sl()));
  sl.registerLazySingleton(() => GetUsersUseCase(sl()));
  sl.registerLazySingleton(() => CreateUserUseCase(sl()));
  sl.registerLazySingleton(() => GetSingleUserUseCase(sl()));
  //// Cloud Storage
  sl.registerLazySingleton(() => UploadImageToStorageUseCase(sl()));
  //// Post
  sl.registerLazySingleton(() => CreatePostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => ReadPostsUseCase(sl()));
  sl.registerLazySingleton(() => ReadSinglePostUseCase(sl()));
  sl.registerLazySingleton(() => LikePostUseCase(sl()));
  //// Comment
  sl.registerLazySingleton(() => CreateCommentUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCommentUseCase(sl()));
  sl.registerLazySingleton(() => DeleteCommentUseCase(sl()));
  sl.registerLazySingleton(() => ReadCommentsUseCase(sl()));
  sl.registerLazySingleton(() => LikeCommentUseCase(sl()));
  //// Reply
  sl.registerLazySingleton(() => CreateReplyUseCase(sl()));
  sl.registerLazySingleton(() => UpdateReplyUseCase(sl()));
  sl.registerLazySingleton(() => DeleteReplyUseCase(sl()));
  sl.registerLazySingleton(() => ReadRepliesUseCase(sl()));
  sl.registerLazySingleton(() => LikeReplyUseCase(sl()));

  // Repository
  sl.registerLazySingleton<FirebaseRepository>(
    () => FirebaseRepositoryImpl(sl()),
  );

  // Remote Data Source
  sl.registerLazySingleton<FirebaseRemoteDataSource>(
    () => FirebaseRemoteDataSourceImpl(sl(), sl(), sl()),
  );

  // Externals
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
}
