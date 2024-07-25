import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskapp/feature/task/model/task.dart';
import 'package:taskapp/feature/task/task_create/bloc/task_create_bloc.dart';
import 'package:taskapp/feature/task/task_list/bloc/task_bloc.dart';
import 'package:taskapp/feature/task/task_list/view/task_view.dart';
import 'package:taskapp/product/util/notification/notification_manager.dart';
import 'package:taskapp/theme/app_theme.dart';
import 'package:taskapp/theme/theme_manager.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'product/util/hive/hive_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationManager.init();
  // await ThemeManager().getThemeFromLocal();

  tz.initializeTimeZones();

  await HiveManager.init<Task>(boxName: "task");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData appThemeMode = AppTheme.darkTheme;
  void changeTheme() {
    setState(() {
      appThemeMode = appThemeMode == AppTheme.lightTheme
          ? AppTheme.darkTheme
          : AppTheme.lightTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeManager().isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TaskBloc(),
          ),
          BlocProvider(
            create: (context) =>
                TaskCreateBloc(taskBloc: context.read<TaskBloc>()),
          ),
        ],
        child: TaskView(changeTheme: changeTheme),
      ),
    );
  }
}
