part of sam_utils;

class DateUtil {
  static DateTime convertToLocalDate(String dateTime) {
    DateFormat formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');

    return formatter.parse(dateTime, true).toLocal();
  }
}