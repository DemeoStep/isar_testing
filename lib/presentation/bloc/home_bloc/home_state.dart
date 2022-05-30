part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class GetAllSuccess extends HomeState {
  final List<User> users;
  final List<Department> departments;

  GetAllSuccess({required this.users, required this.departments});
}

class GetByDepartmentSuccess extends HomeState {
  final List<User> users;
  final List<Department> departments;

  GetByDepartmentSuccess({required this.users, required this.departments});
}

class HomeErrorState extends HomeState {
  final String error;

  HomeErrorState({required this.error});
}
