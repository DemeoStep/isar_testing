import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_testing/data/model/department/department.dart';
import 'package:isar_testing/data/model/user/user.dart';
import 'package:isar_testing/data/source/local/department_repository.dart';
import 'package:isar_testing/data/source/local/user_repository.dart';

part 'department_event.dart';

part 'department_state.dart';

class DepartmentsBloc extends Bloc<DepartmentsEvent, DepartmentsState> {
  final _departmentRepository = GetIt.I<DepartmentRepository>();

  DepartmentsBloc() : super(DepartmentsInitial()) {
    on<GetAllDepartmentsEvent>((event, emit) => _getAll(event, emit));
    on<AddDepartmentEvent>((event, emit) => _addDepartment(event, emit));
    on<DeleteLastEvent>((event, emit) => _deleteLastDepartment(event, emit));
    on<DeleteDepartmentEvent>((event, emit) => _deleteDepartment(event, emit));
    on<EditDepartmentEvent>((event, emit) => _editDepartment(event, emit));
  }

  _getAll(GetAllDepartmentsEvent event, Emitter<DepartmentsState> emit) async {
    emit(GetAllDepartmentsSuccess(
        departments: await _departmentRepository.getAll()));
  }

  _addDepartment(
      AddDepartmentEvent event, Emitter<DepartmentsState> emit) async {
    await _departmentRepository.addDepartment(event.department);
    add(GetAllDepartmentsEvent());
  }

  _deleteLastDepartment(
      DeleteLastEvent event, Emitter<DepartmentsState> emit) async {
    await _departmentRepository.deleteLast();
    add(GetAllDepartmentsEvent());
  }

  _deleteDepartment(
      DeleteDepartmentEvent event, Emitter<DepartmentsState> emit) async {
    await _departmentRepository.deleteDepartment(event.id);
    add(GetAllDepartmentsEvent());
  }

  _editDepartment(
      EditDepartmentEvent event, Emitter<DepartmentsState> emit) async {
    await _departmentRepository.updateDepartment(event.department);
    add(GetAllDepartmentsEvent());
  }
}
