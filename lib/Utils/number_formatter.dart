import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class IndianRupeeFormatter {
  static String inegralValue = '';
  static String fractionalValue = '';
  static String decimalPoint = '.';

  // amount changing to indian format
  static String amountFormatter(String text, TextEditingController controller) {

    var formatNumber = NumberFormat('#,##,###',);
    String rupeeSplittedText = text.split('₹').last.trim().toString();
    String replacedText = rupeeSplittedText.replaceAll(',', '').trim();
    int textLength = replacedText.length;

    if (text.isEmpty) {
      controller.clear();
    } else if (replacedText.contains(decimalPoint)) {
      doubleValueFormating(formatNumber, text, controller);
    } else {
      if (textLength > 8) {
        controller.text = inegralValue;  // for getting last text while adding input at custom position of integral part
        controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length));
      } else if (textLength == 0) {
        controller.clear();
        controller.selection =
            TextSelection.fromPosition(const TextPosition(offset: 1));
      } else {
        controller.text =
            "₹${formatNumber.format(int.parse(replacedText.toString()))}";
        inegralValue = controller.text;
        controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length));
      }
    }
    return controller.text;
  }

  // formting amount containing dot
  static void doubleValueFormating(NumberFormat formatter, String text, TextEditingController controller) {

    String formatString;
    List<String> textSplitted;

    if (text == decimalPoint) {
      controller.text = "₹0$decimalPoint";
      controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
    } else {
      formatString = text.split('₹').last.trim().toString();
      textSplitted = formatString.split(decimalPoint);

      if (textSplitted.last == '') {
        textSplitted.last = textSplitted[1];
      }

      // for getting last text while adding input at custom position of integral part
      if (textSplitted.first.length > 8) {
        textSplitted.first = inegralValue;
      }
      inegralValue = textSplitted.first;

      // for getting last text while adding input at custom position of fractional part
      if (textSplitted.last.length > 2) {
        textSplitted.last = fractionalValue;
      }
      fractionalValue = textSplitted[1];   
      
      controller.text =
          "₹${formatter.format(int.parse(textSplitted.first.toString())).toString()}$decimalPoint${textSplitted.last.toString().length > 2 ? textSplitted.last.toString().substring(0, 2).toString() : textSplitted.last.toString()}";
      
      controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
    }
  }

}