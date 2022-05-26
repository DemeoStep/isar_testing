import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar_testing/data/model/department/department.dart';
import 'package:isar_testing/data/model/user/user.dart';
import 'package:isar_testing/presentation/bloc/department_bloc/department_bloc.dart';
import 'package:isar_testing/presentation/bloc/users_bloc/users_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

class AddEditDepartmentDialog extends StatelessWidget {
  AddEditDepartmentDialog({Key? key, this.department}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _departmentController = TextEditingController();
  final Department? department;

  _init() {
    if (department != null) {
      _departmentController.text = department!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    _init();
    return AlertDialog(
      actions: [
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() == true) {
              department == null
                  ? context.read<DepartmentsBloc>().add(AddDepartmentEvent(
                      department: Department(name: _departmentController.text)))
                  : context.read<DepartmentsBloc>().add(EditDepartmentEvent(
                      department: Department(
                          id: department?.id,
                          name: _departmentController.text)));
              Navigator.pop(context);
            }
          },
          child: department == null ? const Text('Add') : const Text('Apply'),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel')),
      ],
      content: Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _departmentController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
                validator: RequiredValidator(errorText: 'required'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
