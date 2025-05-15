import 'dart:io';

import 'package:detect_it/resources/resources.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('icons assets test', () {
    expect(File(AppIcons.google).existsSync(), isTrue);
    expect(File(AppIcons.apple).existsSync(), isTrue);
  });
}
