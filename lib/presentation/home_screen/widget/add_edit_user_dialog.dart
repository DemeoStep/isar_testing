import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_testing/data/model/department/department.dart';
import 'package:isar_testing/data/model/user/user.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:isar_testing/data/source/local/department_repository.dart';
import 'package:isar_testing/presentation/bloc/department_bloc/department_bloc.dart';
import 'package:isar_testing/presentation/bloc/users_bloc/users_bloc.dart';
import 'package:isar_testing/presentation/home_screen/widget/dropdown_widget.dart';

class AddEditUserDialog extends StatelessWidget {
  AddEditUserDialog({Key? key, this.user}) : super(key: key);

  final _departmentRepository = GetIt.I<DepartmentRepository>();

  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  late User? user;
  late Department userDepartment;

  _init(BuildContext context) {
    userDepartment = _departmentRepository.departments.first;
    if (user != null) {
      _firstNameController.text = user!.firstName;
      _lastNameController.text = user!.lastName;
    }
  }

  @override
  Widget build(BuildContext context) {
    _init(context);
    return AlertDialog(
      actions: [
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() == true) {
              Navigator.pop(
                  context,
                  user == null
                      ? (User(
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text)
                        ..department.value = userDepartment)
                      : (User(
                          id: user?.id,
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text)
                        ..department.value = userDepartment));
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
            _departmentRepository.departments.isNotEmpty
                ? DropdownWidget(
                    onChanged: (value) {
                      userDepartment =
                          _departmentRepository.departments[value!];
                    },
                    value: user == null
                        ? 0
                        : _departmentRepository.departments.indexWhere(
                            (element) =>
                                element.name == user?.department.value?.name),
                    list: _departmentRepository.departments
                        .map((e) => e.name.toString())
                        .toList())
                : Container(),
          ],
        ),
      ),
    );
  }
}
