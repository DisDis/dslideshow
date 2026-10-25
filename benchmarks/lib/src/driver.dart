import 'metrics.dart';
import 'plan.dart';

class RunMeasurement {
  final Map<String, Object?> values;
  final List<FrameSample> frames;
  RunMeasurement(this.values, this.frames);
}

abstract class BenchmarkDriver {
  Map<String, Object?> get display;
  Future<Map<String, Object?>> prepare(BenchmarkCase test);
  Future<RunMeasurement> run(BenchmarkCase test);
  Future<List<String>> capture(BenchmarkCase test);
  Future<void> release();
}
