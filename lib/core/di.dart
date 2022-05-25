import 'package:get_it/get_it.dart';
import 'package:isar_testing/data/source/local/impl/user_repository_impl.dart';
import 'package:isar_testing/data/source/local/user_repository.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<UserRepository>(UserRepositoryImpl());
}
