import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:input_formatter/utils/number_formatter.dart';
import '../utils/keyboard_overlay.dart';

class IndianFormatTextField extends StatefulWidget {
  const IndianFormatTextField({Key? key}) : super(key: key);

  @override
  State<IndianFormatTextField> createState() => _IndianFormatTextFieldState();
}

class _IndianFormatTextFieldState extends State<IndianFormatTextField> {

  final TextEditingController _controller = TextEditingController();
  FocusNode numberFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    numberFocusNode.addListener(() {
      bool hasFocus = numberFocusNode.hasFocus;
      if (hasFocus && Platform.isIOS) {
        KeyboardOverlay.showOverlay(context);
      } else {
        if (_controller.text.endsWith('.')) {
          _controller.text = _controller.text.replaceAll('.', '');
        }
        KeyboardOverlay.removeOverlay();
      }
    });
  }

  @override
  void dispose() {
    numberFocusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
     
        TextField(
          controller: _controller,
          focusNode: numberFocusNode,
          textAlign: TextAlign.center,
          onChanged: (text) {
            IndianRupeeFormatter.amountFormatter(text, _controller);
          },
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
          ],
          keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: '₹0',
            filled: true
          ),
        );
     
  }
}
