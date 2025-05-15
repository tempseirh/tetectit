import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:detect_it/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.detect).existsSync(), isTrue);
    expect(File(Images.dogs).existsSync(), isTrue);
  });
}
