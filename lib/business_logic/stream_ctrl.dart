import 'dart:async';

class Controller {
  final StreamController<int> _ctrl = StreamController<int>();

  Stream<int> get counterStream => _ctrl.stream;

  int counter = 0;

  void increment() {
    _ctrl.add(++counter);
  }

  void decrement() {
    _ctrl.add(--counter);
  }
}
