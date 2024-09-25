import 'package:intl/intl.dart';


String get generatedNewOrderId {
  return 'Order_${getFormattedDateTime(DateTime.now(), pattern: 'yyyy-MM-dd_hh-mm-ss')}';
}

String getFormattedDateTime(DateTime dt, {String pattern = 'dd/MM/yyyy'}) {
  return DateFormat(pattern).format(dt);
}