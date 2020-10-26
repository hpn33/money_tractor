import 'package:flutter/material.dart';

import 'translation/TranslationDialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void resetData(BuildContext context) {
  context.read(typeProvider).state = true;
  context.read(amoungProvider).state = '0';
  context.read(idProvider).state = -1;
  context.read(activeProvider).state = true;
}
