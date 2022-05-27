part of 'department_bloc.dart';

@immutable
abstract class DepartmentsEvent {}

class GetAllDepartmentsEvent extends DepartmentsEvent {}

class UpdateDepartmentEvent extends DepartmentsEvent {
  final Department department;

  UpdateDepartmentEvent({required this.department});
}

class DeleteDepartmentEvent extends DepartmentsEvent {
  final int id;

  DeleteDepartmentEvent({required this.id});
}
