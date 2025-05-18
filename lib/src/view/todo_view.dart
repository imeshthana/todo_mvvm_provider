import 'package:flutter/material.dart';
import 'package:todo_mvvm_provider/src/viewmodel/todo_viewmodel.dart';
import 'package:provider/provider.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  void _showAddTodoBox(BuildContext context) {
    final textController = TextEditingController();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Cancel')),
                TextButton(
                    onPressed: () {
                      if (textController.text.isNotEmpty) {
                        Provider.of<TodoViewModel>(context, listen: false)
                            .addTodo(textController.text);
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text('Add'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final todocontroller = Provider.of<TodoViewModel>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showAddTodoBox(context),
      ),
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: todocontroller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : todocontroller.todos.isEmpty
              ? Center(child: const Text('Empty List'))
              : Column(
                  children: [
                    ListView.builder(
                        itemCount: todocontroller.todos.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, i) {
                          final todo = todocontroller.todos[i];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(todo.text),
                              leading: Checkbox(
                                onChanged: (value) {
                                  todocontroller.toggleTodoCompletion(todo);
                                },
                                value: todo.isCompleted,
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  todocontroller.deleteTodo(todo);
                                },
                              ),
                            ),
                          );
                        })
                  ],
                ),
    );
  }
}
