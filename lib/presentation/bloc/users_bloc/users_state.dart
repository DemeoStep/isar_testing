part of 'users_bloc.dart';

@immutable
abstract class UsersState {}

class UsersInitial extends UsersState {}

class GetAllUsersSuccess extends UsersState {
  final List<User> users;

  GetAllUsersSuccess({required this.users});
}
