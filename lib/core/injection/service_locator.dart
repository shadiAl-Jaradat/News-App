import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news_app/core/network/api_client.dart';
import 'package:news_app/core/network/network_info.dart';
import 'package:news_app/features/news/domain/use_cases/get_articles.dart';
import 'package:news_app/features/news/domain/repositories/news_repository.dart';
import 'package:news_app/features/news/data/repositories/news_repository_impl.dart';
import 'package:news_app/features/news/data/data_sources/news_remote_datasource.dart';

/// Service Locator for dependency injection using GetIt, you can access it from anywhere in the app.
final locator = GetIt.instance;

Future<void> init() async {

  // Use cases
  locator.registerLazySingleton(() => GetArticles(locator()));

  // Repository
  locator.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(remoteDataSource: locator(), networkInfo: locator()));

  // Data sources
  locator.registerLazySingleton<NewsRemoteDataSource>(() => NewsRemoteDataSourceImpl(apiClient: locator()));

  // Core
  locator.registerLazySingleton(() => ApiClient());
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // External
  locator.registerLazySingleton(() => Connectivity());
}
