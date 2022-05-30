import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_testing/data/model/department/department.dart';
import 'package:isar_testing/data/model/user/user.dart';
import 'package:isar_testing/data/source/local/department_repository.dart';
import 'package:isar_testing/data/source/local/user_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _userRepository = GetIt.I<UserRepository>();
  final _departmentsRepository = GetIt.I<DepartmentRepository>();

  HomeBloc() : super(HomeInitial()) {
    on<GetAllEvent>((event, emit) => _getAll(emit));
    on<GetAllFilteredEvent>((event, emit) => _getAllFiltered(event, emit));
    on<DeleteLastEvent>((event, emit) => _deleteLastUser(emit));
    on<DeleteUserEvent>((event, emit) => _deleteUser(event, emit));
    on<UpdateUserEvent>((event, emit) => _updateUser(event, emit));
    add(GetAllEvent());
  }

  _getAll(Emitter<HomeState> emit) async {
    await _userRepository.getAll();
    await _departmentsRepository.getAll();

    emit(GetAllSuccess(
        users: _userRepository.users,
        departments: _departmentsRepository.departments));
  }

  _deleteLastUser(Emitter<HomeState> emit) async {
    await _userRepository.deleteLast();
    add(GetAllEvent());
  }

  _deleteUser(DeleteUserEvent event, Emitter<HomeState> emit) async {
    await _userRepository.deleteUser(event.id);
    add(GetAllEvent());
  }

  _updateUser(UpdateUserEvent event, Emitter<HomeState> emit) async {
    var result = await _userRepository.updateUser(event.user);
    if (result != null) {
      emit(HomeErrorState(error: result.message));
    }
    add(GetAllEvent());
  }

  _getAllFiltered(GetAllFilteredEvent event, Emitter<HomeState> emit) async {
    var list = await _userRepository.getByDepartment(event.department);
    emit(GetAllSuccess(
        users: list, departments: _departmentsRepository.departments));
  }
}
