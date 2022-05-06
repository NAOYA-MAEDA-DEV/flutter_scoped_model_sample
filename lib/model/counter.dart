import 'package:scoped_model/scoped_model.dart';

class Counter extends Model {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }
}