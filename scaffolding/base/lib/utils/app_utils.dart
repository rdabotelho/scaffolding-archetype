import 'package:${context.projectName.toLowerCase()}/models/base_model.dart';
import 'package:${context.projectName.toLowerCase()}/enums/base_enum.dart';
import 'package:intl/intl.dart' show DateFormat;

bool strToBool(String value) {
  return "$value" == "true";
}

int strToInt(String value) {
  return int.tryParse("$value");
}

double strToDouble(String value) {
  return double.tryParse("$value".replaceAll("\\.", "").replaceAll(",", "."));
}

DateTime strToDateTimeFormat(String value, String format) {
  if (value == null) return null;
  return DateFormat(format).parse(value);
}

DateTime strToDateTime(String value) {
  return strToDateTimeFormat(value, 'dd/MM/yyyy');
}

DateTime strToDate(String value) {
  return strToDateTimeFormat(value, 'dd/MM/yyyy');
}

int strToModelId(String value) {
  if (value == null || value == '') {
    return null;
  }
  return strToInt(value.split('|')[0]);
}

int strToModelLabel(String value) {
  if (value == null || value == '') {
    return null;
  }
  return strToInt(value.split('|')[1]);
}

String boolToStr(bool value) {
  if (value == null) return "";
  return "$value";
}

String intToStr(int value) {
  if (value == null) return "";
  return "$value";
}

String doubleToStr(double value) {
  if (value == null) return "";
  return "$value".replaceAll("\\.", ",");
}

String dateTimeToStrFormat(DateTime value, String format) {
  if (value == null) return "";
  return DateFormat(format).format(value);
}

String dateTimeToStr(DateTime value) {
  return dateTimeToStrFormat(value, 'dd/MM/yyyy HH:mm:ss');
}

String dateToStr(DateTime value) {
  return dateTimeToStrFormat(value, 'dd/MM/yyyy');
}

String modelToStr(BaseModel value) {
  if (value == null) {
    return null;
  }
  return "$value.getId()" + "|" + value.getLabel();
}

List<EnumValue> appendItem(EnumValue item, List<EnumValue> items) {
  List<EnumValue> newItems = List();
  newItems.add(item);
  items.forEach((it) => newItems.add(it));
  return newItems;
}
