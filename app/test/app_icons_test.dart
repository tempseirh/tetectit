import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:detect_it/resources/resources.dart';

void main() {
  test('app_icons assets test', () {
    expect(File(AppIcons.apple).existsSync(), isTrue);
    expect(File(AppIcons.google).existsSync(), isTrue);
  });
}
