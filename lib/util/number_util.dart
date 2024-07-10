part of sam_utils;

class NumberUtil {
  static String removeTrailingZero(num n) {
    String numStr = n.toString();
    if (numStr.contains(".")) {
      String newNumStr = "";

      // 0.01

      bool foundDot = false;
      for (int i = numStr.length - 1; i >= 0; i--) {
        if (numStr[i] == ".") {
          foundDot = true;
          if (newNumStr.length > 0) {
            newNumStr = "." + newNumStr;
          }
          continue;
        }

        if (foundDot == true) {
          newNumStr = numStr[i] + newNumStr;
        } else if (foundDot == false && numStr[i] == "0") {
          // abaikan
        } else {
          newNumStr = numStr[i] + newNumStr;
          foundDot = true;
        }
      }

      return newNumStr;
    }

    return numStr;
  }
}
