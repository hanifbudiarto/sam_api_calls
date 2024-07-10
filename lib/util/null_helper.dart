part of sam_utils;

dynamic ifNullReturnEmpty(dynamic jsonValue) {
  if (jsonValue.runtimeType == Null) {
    return '';
  } else
    return jsonValue.toString();
}