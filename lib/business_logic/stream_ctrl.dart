import 'dart:async';

class Controller {

  Controller._internal();

  //--  Make a singleton
  static final Controller _instance = Controller._internal();
  static Controller get instance => _instance;

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
