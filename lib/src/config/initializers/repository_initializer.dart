import 'package:get_it/get_it.dart';
import 'package:wolnelektury/src/data/audiobook_repository.dart';
import 'package:wolnelektury/src/data/auth_repository.dart';
import 'package:wolnelektury/src/data/author_repository.dart';
import 'package:wolnelektury/src/data/bookmarks_repository.dart';
import 'package:wolnelektury/src/data/books_repository.dart';
import 'package:wolnelektury/src/data/likes_repository.dart';
import 'package:wolnelektury/src/data/lists_repository.dart';
import 'package:wolnelektury/src/data/progress_repository.dart';
import 'package:wolnelektury/src/data/tags_repository.dart';
import 'package:wolnelektury/src/presentation/cubits/auth/auth_cubit.dart';
import 'package:wolnelektury/src/presentation/cubits/connectivity/connectivity_cubit.dart';

Future<void> initializeRepositories({required GetIt getIt}) async {
  // Repositories
  getIt.registerSingleton<BooksRepository>(
    BooksRepositoryImplementation(getIt.get(), getIt.get()),
  );
  getIt.registerSingleton<BookmarksRepository>(
    BookmarksRepositoryImplementation(getIt.get(), getIt.get(), getIt.get()),
  );
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImplementation(getIt.get()),
  );
  getIt.registerSingleton<TagsRepository>(
    TagsRepositoryImplementation(getIt.get()),
  );
  getIt.registerSingleton<LikesRepository>(
    FavouritesRepositoryImplementation(getIt.get(), getIt.get(), getIt.get()),
  );
  getIt.registerSingleton<AudiobookRepository>(
    AudiobookRepositoryImplementation(getIt.get(), getIt.get()),
  );
  getIt.registerSingleton<ProgressRepository>(
    ProgressRepositoryImplementation(getIt.get(), getIt.get(), getIt.get()),
  );
  getIt.registerSingleton<AuthorRepository>(
    AuthorRepositoryImplementation(getIt.get()),
  );
  getIt.registerSingleton<ListsRepository>(
    ListsRepositoryImplementation(getIt.get()),
  );
  // Cubit
  getIt.registerSingleton<AuthCubit>(AuthCubit(getIt.get()));
  getIt.registerSingleton<ConnectivityCubit>(ConnectivityCubit());
}
