part of 'users_bloc.dart';

@immutable
abstract class UsersEvent {}

class GetAllEvent extends UsersEvent {}

class AddUserEvent extends UsersEvent {
  final User user;

  AddUserEvent({required this.user});
}

class DeleteLastEvent extends UsersEvent {}
