import 'package:flutter/foundation.dart';
import '../models/todo.dart';
import '../services/todo_service.dart';

class TodoProvider with ChangeNotifier {
  final TodoService _todoService = TodoService();

  List<Todo> _todos = [];
  List<Todo> _filteredTodos = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';

  List<Todo> get todos => _todos;
  List<Todo> get filteredTodos =>
      _filteredTodos.isEmpty && _searchQuery.isEmpty ? _todos : _filteredTodos;
  bool get isLoading => _isLoading;
  String? get error => _error;

  TodoProvider() {
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _todos = await _todoService.getAllTodos();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createTodo(Todo todo) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newTodo = await _todoService.createTodo(todo);
      _todos.add(newTodo);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateTodo(int id, Todo todo) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final updatedTodo = await _todoService.updateTodo(id, todo);
      final index = _todos.indexWhere((t) => t.id == id);
      if (index != -1) {
        _todos[index] = updatedTodo;
      }
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteTodo(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final success = await _todoService.deleteTodo(id);
      if (success) {
        _todos.removeWhere((todo) => todo.id == id);
      }
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchTodos(String query) async {
    _searchQuery = query;
    if (query.isEmpty) {
      _filteredTodos = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      _filteredTodos = await _todoService.searchTodos(query);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sortByPriority() async {
    _isLoading = true;
    notifyListeners();

    try {
      _todos = await _todoService.sortByPriority();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkDeadlines() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final nearDeadlines = await _todoService.checkDeadlines();
      // Update the state with nearDeadlines
      _todos = nearDeadlines; // Or use a separate list for near deadlines
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
