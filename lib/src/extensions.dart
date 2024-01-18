
import 'dart:ui';

extension OffsetOperations on Offset{
  Offset addToY(double value) {
    return Offset(dx, dy + value);
  }

  Offset addToX(double value) {
    return Offset(dx + value, dy);
  }


  Offset subtractFromY(double value) {
    return Offset(dx, dy - value);
  }

  Offset subtractFromX(double value) {
    return Offset(dx - value, dy);
  }

  Offset multiply(double value) {
    return Offset(dx * value, dy * value);
  }

  Offset divide(double value) {
    return Offset(dx / value, dy / value);
  }

  Offset subtract(Offset offset) {
    return Offset(dx - offset.dx, dy - offset.dy);
  }
}