import 'package:flutter/material.dart';
import 'Screens/taskscreen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'widgets/data.dart';


Future main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox('Task');
  //Hive.box('Task').clear();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TasksScreen(),
    );
  }
}

