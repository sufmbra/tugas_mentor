import 'package:flutter/foundation.dart';
import '../models/todo_category.dart'; // Update the import
import '../services/category_service.dart';

class CategoryProvider with ChangeNotifier {
  final CategoryService _categoryService = CategoryService();

  List<TodoCategory> _categories = []; // Update the type
  bool _isLoading = false;
  String? _error;

  List<TodoCategory> get categories => _categories; // Update the type
  bool get isLoading => _isLoading;
  String? get error => _error;

  CategoryProvider() {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _categories = await _categoryService.getAllCategories();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createCategory(TodoCategory category) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newCategory = await _categoryService.createCategory(category);
      _categories.add(newCategory);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateCategory(int id, TodoCategory category) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final updatedCategory =
          await _categoryService.updateCategory(id, category);
      final index = _categories.indexWhere((c) => c.id == id);
      if (index != -1) {
        _categories[index] = updatedCategory;
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

  Future<void> deleteCategory(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final success = await _categoryService.deleteCategory(id);
      if (success) {
        _categories.removeWhere((category) => category.id == id);
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
}
