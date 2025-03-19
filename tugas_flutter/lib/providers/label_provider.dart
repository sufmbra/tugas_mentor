import 'package:flutter/foundation.dart';
import '../models/label.dart';
import '../services/label_service.dart';

class LabelProvider with ChangeNotifier {
  final LabelService _labelService = LabelService();

  List<Label> _labels = [];
  bool _isLoading = false;
  String? _error;

  List<Label> get labels => _labels;
  bool get isLoading => _isLoading;
  String? get error => _error;

  LabelProvider() {
    fetchLabels();
  }

  Future<void> fetchLabels() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _labels = await _labelService.getAllLabels();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createLabel(Label label) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newLabel = await _labelService.createLabel(label);
      _labels.add(newLabel);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateLabel(int id, Label label) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final updatedLabel = await _labelService.updateLabel(id, label);
      final index = _labels.indexWhere((l) => l.id == id);
      if (index != -1) {
        _labels[index] = updatedLabel;
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

  Future<void> deleteLabel(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final success = await _labelService.deleteLabel(id);
      if (success) {
        _labels.removeWhere((label) => label.id == id);
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
