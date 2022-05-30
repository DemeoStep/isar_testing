import 'package:get_it/get_it.dart';
import 'package:isar_testing/data/source/local/department_repository.dart';
import 'package:isar_testing/data/source/local/impl/department_repository_impl.dart';
import 'package:isar_testing/data/source/local/impl/user_repository_impl.dart';
import 'package:isar_testing/data/source/local/user_repository.dart';
import 'package:isar_testing/presentation/bloc/department_bloc/department_bloc.dart';
import 'package:isar_testing/presentation/bloc/home_bloc/home_bloc.dart';

final getIt = GetIt.instance;

void setupServiceLocator() async {
  getIt.registerSingleton<UserRepository>(UserRepositoryImpl());
  getIt.registerSingleton<DepartmentRepository>(DepartmentRepositoryImpl());
  getIt.registerSingleton<HomeBloc>(HomeBloc());
  getIt.registerSingleton<DepartmentsBloc>(DepartmentsBloc());
}
