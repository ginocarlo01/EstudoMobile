import 'dart:async';
import 'dart:math';

class CounterProvider {
  static CounterProvider helper = CounterProvider._();
  final StreamController<bool> _controller = StreamController<bool>();

  Stream get stream => _controller.stream;

  Random random = Random();

  CounterProvider._() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      _controller.sink.add(random.nextBool());
    });
  }
}
