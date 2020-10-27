import 'package:intl/intl.dart';

extension UtilDateTime on DateTime {
  String get formatedDate => DateFormat('yyyy-MM-dd   kk:mm').format(this);
}
