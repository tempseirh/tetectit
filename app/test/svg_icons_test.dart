import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:detect_it/resources/resources.dart';

void main() {
  test('svg_icons assets test', () {
    expect(File(SvgIcons.capture).existsSync(), isTrue);
    expect(File(SvgIcons.scan).existsSync(), isTrue);
    expect(File(SvgIcons.sun).existsSync(), isTrue);
  });
}
