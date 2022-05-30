import 'package:flutter/material.dart';
import 'package:isar_testing/data/model/department/department.dart';
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
              Navigator.pop(
                  context,
                  department == null
                      ? Department(name: _departmentController.text)
                      : Department(
                          id: department?.id,
                          name: _departmentController.text));
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
