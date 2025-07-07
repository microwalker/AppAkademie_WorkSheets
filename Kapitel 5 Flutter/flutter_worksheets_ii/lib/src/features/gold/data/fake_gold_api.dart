import 'dart:math';

/// Returns a stream of a fake gold prices.
/// The prices are generated randomly.
Stream<double> getGoldPriceStream(int seconds) {
  // Random random = Random();
  return Stream<double>.periodic(
    Duration(seconds: seconds),
    (int _) {
      return 60 + Random().nextDouble() * 20;
    },
  );
}
