import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news_app/core/network/api_client.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/features/news/data/data_sources/news_mock_datasource.dart';
import 'package:news_app/features/news/domain/use_cases/get_articles.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';
import 'package:news_app/features/news/data/repositories/news_repository_impl.dart';
import 'package:news_app/features/news/data/data_sources/news_remote_datasource.dart';
import 'package:news_app/features/news/domain/use_cases/get_mock_articles.dart';
import 'package:news_app/features/news/presentation/bloc/news_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/search/search_cubit.dart';
import 'package:news_app/features/news/presentation/bloc/view_mode/view_mode_cubit.dart';

final locator = GetIt.instance;

Future<void> init() async {
  //! Features - News
  // BLoCs and Cubits - Register as Factory (new instance each time)
  locator.registerFactory(() => NewsBloc(getArticles: locator(), getMockArticles: locator()));
  locator.registerFactory(() => SearchCubit());
  locator.registerFactory(() => ViewModeCubit());

  // Use cases
  locator.registerLazySingleton(() => GetArticles(locator()));
  locator.registerLazySingleton(() => GetMockArticles(locator()));

  // Repository
  locator.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(remoteDataSource: locator(), networkInfo: locator(), remoteMockDataSource: locator()),
  );

  // Data sources
  locator.registerLazySingleton<NewsRemoteDataSource>(() => NewsRemoteDataSourceImpl(apiClient: locator()));
  locator.registerLazySingleton<NewsMockDataSource>(() => NewsMockDataSourceImpl());

  //! Core
  locator.registerLazySingleton(() => ApiClient());
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  //! External
  locator.registerLazySingleton(() => Connectivity());
}
