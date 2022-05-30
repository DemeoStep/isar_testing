import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:isar_testing/core/di.dart';
import 'package:isar_testing/data/model/department/department.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar_testing/presentation/bloc/department_bloc/department_bloc.dart';
import 'package:isar_testing/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:isar_testing/presentation/departments_screen/departments_screen.dart';
import 'package:isar_testing/presentation/home_screen/home_screen.dart';
import 'package:path_provider/path_provider.dart';

import 'data/model/user/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var isarDir = await getApplicationSupportDirectory();
  await Isar.open(
    schemas: [UserSchema, DepartmentSchema],
    directory: isarDir.path,
  );
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        'home': (context) => BlocProvider(
              create: (context) => GetIt.I<HomeBloc>(),
              child: const HomeScreen(),
            ),
        'departments': (context) => BlocProvider(
              create: (context) => DepartmentsBloc(),
              child: const DepartmentsScreen(),
            )
      },
      initialRoute: 'home',
    );
  }
}
