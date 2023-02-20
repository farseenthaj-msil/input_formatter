import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class IndianRupeeFormatter {
  
  // amount changing to indian format
  static void amountFormatter(String text, TextEditingController controller) {

    var formatNumber = NumberFormat('#,##,###',);
    String rupeeSplittedText = text.split('₹').last.trim().toString();
    String replacedText = rupeeSplittedText.replaceAll(',', '').trim();
    int textLength = replacedText.length;

    if (replacedText.contains('.')) {
      doubleValueFormating(formatNumber, text, controller);
    } else {
      if (textLength > 8) {
        controller.text =
            "₹${formatNumber.format(int.parse(replacedText.toString().substring(0, 8)))}";
        
        controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length));
      } else if (textLength == 0) {
        controller.clear();
        controller.text = '₹';
        controller.selection =
            TextSelection.fromPosition(const TextPosition(offset: 1));
      } else {
        controller.text =
            "₹${formatNumber.format(int.parse(replacedText.toString()))}";
        controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length));
      }
    }
  }

  // formting amount containing dot
  static void doubleValueFormating(NumberFormat formatter, String text, TextEditingController controller) {

    String formatString;
    List<String> textSplitted;
    
    if (text == '.') {
      controller.text = "₹ 0";
      controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
    } else {
      formatString = text.split('₹').last.trim().toString();

      textSplitted = formatString.split('.');
      controller.text =
          "₹${formatter.format(int.parse(textSplitted.first.toString())).toString()}.${textSplitted.last.toString().length > 2 ? textSplitted.last.toString().substring(0, 2).toString() : textSplitted.last.toString()}";
      controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
    }
  }

}