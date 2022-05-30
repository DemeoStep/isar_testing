import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_testing/data/model/department/department.dart';
import 'package:isar_testing/data/source/local/department_repository.dart';

part 'department_event.dart';

part 'department_state.dart';

class DepartmentsBloc extends Bloc<DepartmentsEvent, DepartmentsState> {
  final _departmentRepository = GetIt.I<DepartmentRepository>();

  DepartmentsBloc() : super(DepartmentsInitial()) {
    on<GetAllDepartmentsEvent>((event, emit) => _getAll(event, emit));
    on<DeleteDepartmentEvent>((event, emit) => _deleteDepartment(event, emit));
    on<UpdateDepartmentEvent>((event, emit) => _updateDepartment(event, emit));
    add(GetAllDepartmentsEvent());
  }

  _getAll(GetAllDepartmentsEvent event, Emitter<DepartmentsState> emit) async {
    var departments = await _departmentRepository.getAll();
    emit(GetAllDepartmentsSuccess(departments: departments));
  }

  _deleteDepartment(
      DeleteDepartmentEvent event, Emitter<DepartmentsState> emit) async {
    await _departmentRepository.deleteDepartment(event.id);

    add(GetAllDepartmentsEvent());
  }

  _updateDepartment(
      UpdateDepartmentEvent event, Emitter<DepartmentsState> emit) async {
    await _departmentRepository.updateDepartment(event.department);
    add(GetAllDepartmentsEvent());
  }
}
