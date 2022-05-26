part of 'department_bloc.dart';

@immutable
abstract class DepartmentsState {}

class DepartmentsInitial extends DepartmentsState {}

class GetAllDepartmentsSuccess extends DepartmentsState {
  final List<Department> departments;

  GetAllDepartmentsSuccess({required this.departments});
}
