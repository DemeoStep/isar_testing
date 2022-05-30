import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar_testing/data/model/department/department.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar_testing/presentation/bloc/department_bloc/department_bloc.dart';
import 'package:isar_testing/presentation/departments_screen/widget/add_edit_department_dialog.dart';

class DepartmentsScreen extends StatelessWidget {
  const DepartmentsScreen({Key? key}) : super(key: key);

  Future<Department?> _showDepartmentsDialog(
      {required BuildContext context, Department? department}) async {
    var result = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AddEditDepartmentDialog(
            department: department,
          );
        }) as Department?;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Departments'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<DepartmentsBloc, DepartmentsState>(
                  builder: (context, state) {
                    if (state is GetAllDepartmentsSuccess) {
                      return ListView.builder(
                        itemCount: state.departments.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    var result = await _showDepartmentsDialog(
                                        context: context,
                                        department: state.departments[index]);
                                    if (result != null) {
                                      context.read<DepartmentsBloc>().add(
                                          UpdateDepartmentEvent(
                                              department: result));
                                    }
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.grey),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      state.departments[index].id.toString(),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.grey),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      state.departments[index].name,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    context.read<DepartmentsBloc>().add(
                                        DeleteDepartmentEvent(
                                            id: state.departments[index].id!));
                                  },
                                  icon: const Icon(Icons.delete),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
                onPressed: () async {
                  var result = await _showDepartmentsDialog(context: context);
                  if (result != null) {
                    context
                        .read<DepartmentsBloc>()
                        .add(UpdateDepartmentEvent(department: result));
                  }
                },
                child: const Text(
                  'Add department',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
