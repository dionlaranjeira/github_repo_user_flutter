import 'package:intl/intl.dart';

class FormatStrings{

  static dateFormart(String date) {
    var parsedDate = DateTime.parse(date);
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(parsedDate);
    return formatted;
  }

}