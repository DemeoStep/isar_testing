part of 'users_bloc.dart';

@immutable
abstract class UsersEvent {}

class GetAllUsersEvent extends UsersEvent {}

class UpdateUserEvent extends UsersEvent {
  final User user;

  UpdateUserEvent({required this.user});
}

class DeleteLastEvent extends UsersEvent {}

class DeleteUserEvent extends UsersEvent {
  final int id;

  DeleteUserEvent({required this.id});
}
