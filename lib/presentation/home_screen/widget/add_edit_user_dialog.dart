import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar_testing/data/model/user/user.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:isar_testing/presentation/bloc/department_bloc/department_bloc.dart';
import 'package:isar_testing/presentation/bloc/users_bloc/users_bloc.dart';
import 'package:isar_testing/presentation/home_screen/widget/dropdown_widget.dart';

class AddEditUserDialog extends StatelessWidget {
  AddEditUserDialog({Key? key, this.user}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  late final User? user;

  _init(BuildContext context) {
    context.read<DepartmentsBloc>().add(GetAllDepartmentsEvent());
    if (user != null) {
      _firstNameController.text = user!.firstName;
      _lastNameController.text = user!.lastName;
    }
  }

  @override
  Widget build(BuildContext context) {
    _init(context);
    return BlocBuilder<DepartmentsBloc, DepartmentsState>(
      builder: (context, state) {
        if (state is GetAllDepartmentsSuccess) {
          var departments = state.departments;
          var userDepartment = departments.first;

          return AlertDialog(
            actions: [
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    user == null
                        ? context.read<UsersBloc>().add(UpdateUserEvent(
                            user: User(
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text)
                              ..department.value = userDepartment))
                        : context.read<UsersBloc>().add(UpdateUserEvent(
                            user: User(
                                id: user?.id,
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text)
                              ..department.value = userDepartment));
                    Navigator.pop(context, true);
                  }
                },
                child: user == null ? const Text('Add') : const Text('Apply'),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
            ],
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    validator: RequiredValidator(errorText: 'required'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    validator: RequiredValidator(errorText: 'required'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 10),
                  departments.isNotEmpty
                      ? DropdownWidget(
                          onChanged: (value) {
                            userDepartment = departments[value!];
                          },
                          value: user == null
                              ? 0
                              : departments.indexWhere((element) =>
                                  element.name == user?.department.value?.name),
                          list: departments
                              .map((e) => e.name.toString())
                              .toList())
                      : Container(),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
