import 'dart:math';

class HoleCirclePattern {
  double patternDiameter;
  double patternCenterX;
  double patternCenterY;
  double startAngle;
  double incrementAngle;
  double circleSpan;
  double holeDiameter;
  double toolDiameter;
  int numOfHoles;
  String operationType;

  HoleCirclePattern(
      {this.operationType = 'Usinagem int.',
      this.circleSpan = 360,
      this.startAngle = 0,
      this.patternCenterX = 0,
      this.patternCenterY = 0,
      this.patternDiameter = 100,
      this.toolDiameter = 10,
      this.numOfHoles = 10});

  coordX(int n) {
    double finalDiam;
    if (operationType == 'Furação') {
      finalDiam = patternDiameter;
    }

    if (operationType == 'Usinagem Externa') {
      finalDiam = patternDiameter + toolDiameter;
    }

    if (operationType == 'Usinagem Interna') {
      finalDiam = patternDiameter - toolDiameter;
    }

    if (circleSpan == 360) {
      incrementAngle = circleSpan / numOfHoles;
    } else {
      incrementAngle = circleSpan / (numOfHoles - 1);
    }
    return patternCenterX +
        finalDiam /
            2 *
            cos(n * (incrementAngle) * pi / 180 + startAngle * pi / 180);
  }

  coordY(int n) {
    double finalDiam;
    if (operationType == 'Furação') {
      finalDiam = patternDiameter;
    }

    if (operationType == 'Usinagem Externa') {
      finalDiam = patternDiameter + toolDiameter;
    }

    if (operationType == 'Usinagem Interna') {
      finalDiam = patternDiameter - toolDiameter;
    }

    if (circleSpan == 360) {
      incrementAngle = circleSpan / numOfHoles;
    } else {
      incrementAngle = circleSpan / (numOfHoles - 1);
    }
    return patternCenterY +
        finalDiam /
            2 *
            sin(n * incrementAngle * pi / 180 + startAngle * pi / 180);
  }

  coordXandY() {
    var coordArray = new List(numOfHoles);
    for (int i = 0; i < numOfHoles; i++) {
      coordArray[i] =
          'N${i + 1} X${coordX(i).toStringAsFixed(3)} Y${coordY(i).toStringAsFixed(3)}';
    }

    return coordArray;
  }

  arrayCoordX() {
    var coordArray = new List(numOfHoles);
    for (int i = 0; i < numOfHoles; i++) {
      coordArray[i] = 'X ${coordX(i).toStringAsFixed(3)}';
    }

    return coordArray;
  }

  arrayCoordY() {
    var coordArray = new List(numOfHoles);
    for (int i = 0; i < numOfHoles; i++) {
      coordArray[i] = 'Y ${coordY(i).toStringAsFixed(3)}';
    }

    return coordArray;
  }

  arrayXandY() {
    List coordArray = new List(numOfHoles);
    for (int i = 0; i < numOfHoles; i++) {
      coordArray[i] = [
        'N${i + 1}',
        'X${coordX(i).toStringAsFixed(3)}',
        'Y${coordY(i).toStringAsFixed(3)}'
      ];
    }

    return coordArray;
  }
}
