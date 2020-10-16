import 'dart:async';
import 'dart:math' show Random;



class CalcBloc {
  /// [define initial]
  final _startController = StreamController<void>();   /// [start]
  final _calcController = StreamController<int>();   /// [calc]
  final _outputController = StreamController<String>();   /// [output]
  final _btnController = StreamController<bool>();   /// [btn]

  StreamSink<void> get start => _startController.sink;   /// [start]controller.sink
  Stream<String> get onAdd => _outputController.stream;   /// [output]controller.stream  onAddで
  Stream<bool> get onToggle => _btnController.stream;   /// [btn]controller.stream  onToggleで

  static const _repeat = 6;
  int _sum;
  Timer _timer;


  CalcBloc() {
    _startController.stream.listen((_) => _start());
    _calcController.stream.listen((count) => _calc(count));
    _btnController.sink.add(true);
  }


  void _start() {
    _sum = 0;
    _outputController.sink.add('');
    _btnController.sink.add(false);

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      _calcController.sink.add(t.tick);
    });
  }


  void _calc(int count) {
    if (count < _repeat + 1) {
      final num = Random().nextInt(99) + 1;
      _outputController.sink.add('$num');
      _sum += num;
    } else {
      _timer.cancel();
      _outputController.sink.add('Answer: $_sum');
      _btnController.sink.add(true);
    }
  }




  /// [== dispose() ==]
  void dispose() {
    _startController.close();
    _calcController.close();
    _outputController.close();
    _btnController.close();
  }
}