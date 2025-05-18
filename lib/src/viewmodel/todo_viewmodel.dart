import 'package:flutter/foundation.dart';
import 'package:todo_mvvm_provider/services/api_service.dart';
import 'package:todo_mvvm_provider/src/model/todo_model.dart';

class TodoViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<TodoModel> _todos = [];
  bool _isLoading = false;

  TodoViewModel() {
    loadTodos();
  }

  // Getters
  List<TodoModel> get todos => _todos;
  bool get isLoading => _isLoading;

  // Initialize and load todos
  Future<void> loadTodos() async {
    _isLoading = true;
    notifyListeners();

    try {
      List<dynamic> response = await _apiService.get();
      if (response != null) {
        _todos =
            (response as List).map((item) => TodoModel.fromJson(item)).toList();
      } else {
        _todos = [];
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add a new todo
  Future<void> addTodo(String text) async {
    if (text.isEmpty) return;

    _isLoading = true;
    notifyListeners();

    try {
      final newTodo = TodoModel(text: text);
      final Map<String, dynamic> todoData = newTodo.toJson();

      final success = await _apiService.post(todoData);
      if (success) {
        await loadTodos();
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Toggle todo completion status
  Future<void> toggleTodoCompletion(TodoModel todo) async {
    notifyListeners();

    try {
      final updatedTodo = todo.toggleCompletion();

      final success = await _apiService.put('/${todo.id}', updatedTodo.toJson());
      if (success) {
        final index = _todos.indexWhere((t) => t.id == todo.id);
        if (index != -1) {
          _todos[index] = updatedTodo;
        }
      }
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  // Delete a todo
  Future<void> deleteTodo(TodoModel todo) async {
    if (todo.id == null) return;
    notifyListeners();

    try {
      final success = await _apiService.delete('/${todo.id}');
      if (success) {
        _todos.removeWhere((t) => t.id == todo.id);
      }
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }
}
