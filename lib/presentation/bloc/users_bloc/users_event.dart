part of 'users_bloc.dart';

@immutable
abstract class UsersEvent {}

class GetAllUsersEvent extends UsersEvent {}

class AddUserEvent extends UsersEvent {
  final User user;

  AddUserEvent({required this.user});
}

class EditUserEvent extends UsersEvent {
  final User user;

  EditUserEvent({required this.user});
}

class DeleteLastEvent extends UsersEvent {}

class DeleteUserEvent extends UsersEvent {
  final int id;

  DeleteUserEvent({required this.id});
}
