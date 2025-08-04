
class NavigationHistoryManager {
  final List<int> _history = [];

  void push(int index) {
    _history.add(index);
  }

  int? pop() {
    if (_history.isNotEmpty) {
      final popped = _history.removeLast();
      return popped;
    }
    return null;
  }

  bool canGoBack() {
    return _history.isNotEmpty;
  }

  void clear() {
    _history.clear();
  }

  List<int> getHistory() {
    return List.from(_history);
  }
}