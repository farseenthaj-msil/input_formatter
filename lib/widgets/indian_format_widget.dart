import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextfieldProperties {

  TextfieldProperties(this.controller, this.decoration, this.style,
      this.formatter,  this.focusNode, this.keyboardType,this.textAlign);

  TextEditingController? controller;
  TextAlign textAlign = TextAlign.start;
  TextStyle? style;
  List<TextInputFormatter>? formatter;
  InputDecoration? decoration;
  FocusNode? focusNode;
  TextInputType? keyboardType;

}

Widget indianFormatTextField (TextfieldProperties textfieldProperties, Function onChanged) {
  return TextField(
      controller: textfieldProperties.controller,
      focusNode: textfieldProperties.focusNode,
      textAlign: textfieldProperties.textAlign,
      onChanged: (text) => onChanged(textfieldProperties.controller, text),
      style: textfieldProperties.style,
      inputFormatters: textfieldProperties.formatter,
      keyboardType: textfieldProperties.keyboardType,
      decoration: textfieldProperties.decoration);
}
