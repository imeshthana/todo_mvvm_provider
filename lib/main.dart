import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_mvvm_provider/src/view/todo_view.dart';
import 'package:todo_mvvm_provider/src/viewmodel/todo_viewmodel.dart';

void main() {
  runApp(DevicePreview(builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoViewModel(),
      child: MaterialApp(
        title: 'Todo App',
        home: TodoView(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}