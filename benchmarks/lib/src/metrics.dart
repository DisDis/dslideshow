import 'dart:math' as math;

double? percentile(Iterable<num> source, double fraction) {
  final values = source.map((v) => v.toDouble()).toList()..sort();
  if (values.isEmpty) return null;
  final index = (values.length - 1) * fraction;
  final low = index.floor();
  final high = index.ceil();
  return values[low] + (values[high] - values[low]) * (index - low);
}

Map<String, Object?> distribution(Iterable<num> values) {
  final list = values.map((v) => v.toDouble()).toList();
  return {
    'count': list.length,
    'p50': percentile(list, .5),
    'p95': percentile(list, .95),
    'p99': percentile(list, .99),
    'max': list.isEmpty ? null : list.reduce((a, b) => math.max(a, b)),
  };
}

class FrameSample {
  final int vsyncUs;
  final int buildUs;
  final int rasterUs;
  final int totalUs;
  const FrameSample(this.vsyncUs, this.buildUs, this.rasterUs, this.totalUs);
  Map<String, Object?> toJson() => {
    'vsync_us': vsyncUs,
    'build_us': buildUs,
    'raster_us': rasterUs,
    'total_us': totalUs,
  };
}

class ProgressProbe {
  double previous = 0;
  double maxStep = 0;
  bool monotonic = true;
  int ticks = 0;
  void add(double value) {
    final step = value - previous;
    if (step < -1e-9) monotonic = false;
    maxStep = math.max(maxStep, step);
    previous = value;
    ticks++;
  }

  // The production controller truncates deltas to integer milliseconds before
  // capping values above 10 ms. A 10.999 ms delta therefore remains possible.
  bool smooth(int nominalMs) => monotonic && maxStep <= 11 / nominalMs + 1e-6;
}

Map<String, Object?> frameMetrics(
  List<FrameSample> frames,
  double refreshRate,
) {
  final sorted = [...frames]..sort((a, b) => a.vsyncUs.compareTo(b.vsyncUs));
  final intervals = <double>[];
  for (var i = 1; i < sorted.length; i++) {
    intervals.add((sorted[i].vsyncUs - sorted[i - 1].vsyncUs) / 1000);
  }
  final budget = 1000 / refreshRate;
  return {
    'frames': frames.length, 'refresh_hz': refreshRate, 'budget_ms': budget,
    'ui_ms': distribution(frames.map((f) => f.buildUs / 1000)),
    'raster_ms': distribution(frames.map((f) => f.rasterUs / 1000)),
    'total_span_ms': distribution(frames.map((f) => f.totalUs / 1000)),
    'vsync_interval_ms': distribution(intervals),
    'sampled_fps': intervals.isEmpty || intervals.reduce((a, b) => a + b) == 0
        ? null
        : 1000 * intervals.length / intervals.reduce((a, b) => a + b),
    'slow_ui_frames': frames.where((f) => f.buildUs / 1000 > budget).length,
    'slow_raster_frames': frames
        .where((f) => f.rasterUs / 1000 > budget)
        .length,
    // An estimate from submitted Flutter frames, not a hardware display counter.
    'estimated_missed_vsyncs': intervals.isEmpty
        ? null
        : intervals.fold<int>(
            0,
            (sum, interval) =>
                sum + math.max(0, (interval / budget).round() - 1),
          ),
  };
}
