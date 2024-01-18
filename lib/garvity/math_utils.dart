
class MathUtils{
  static double calculateSigma(double start, double end, double Function(double) term) {
    double sum = 0.0;
    for (double i = start; i <= end; i++) {
      sum += term(i);
    }
    return sum;
  }
}