part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetAllEvent extends HomeEvent {}

class GetAllFilteredEvent extends HomeEvent {
  final Department department;

  GetAllFilteredEvent({required this.department});
}

class UpdateUserEvent extends HomeEvent {
  final User user;

  UpdateUserEvent({required this.user});
}

class DeleteLastEvent extends HomeEvent {}

class DeleteUserEvent extends HomeEvent {
  final int id;

  DeleteUserEvent({required this.id});
}
