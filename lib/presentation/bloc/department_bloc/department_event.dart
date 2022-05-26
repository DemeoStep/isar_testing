part of 'department_bloc.dart';

@immutable
abstract class DepartmentsEvent {}

class GetAllDepartmentsEvent extends DepartmentsEvent {}

class AddDepartmentEvent extends DepartmentsEvent {
  final Department department;

  AddDepartmentEvent({required this.department});
}

class EditDepartmentEvent extends DepartmentsEvent {
  final Department department;

  EditDepartmentEvent({required this.department});
}

class DeleteLastEvent extends DepartmentsEvent {}

class DeleteDepartmentEvent extends DepartmentsEvent {
  final int id;

  DeleteDepartmentEvent({required this.id});
}
