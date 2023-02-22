import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:input_formatter/utils/number_formatter.dart';
import 'package:input_formatter/widgets/indian_format_textfield.dart';
import '../utils/keyboard_overlay.dart';

class AmountScreen extends StatefulWidget {
  const AmountScreen({Key? key}) : super(key: key);

  @override
  State<AmountScreen> createState() => _AmountScreenState();
}

class _AmountScreenState extends State<AmountScreen> {

  TextEditingController _controller = TextEditingController();
  FocusNode numberFocusNode = FocusNode();
  late TextfieldProperties properties;
  final style = const TextStyle(fontWeight: FontWeight.bold, fontSize: 25);
  final formatter = [
    FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
  ];
  final decortaion = const InputDecoration(
      border: OutlineInputBorder(), hintText: '₹0', filled: true);

  @override
  void initState() {
    super.initState();

    numberFocusNode.addListener(() {
      bool hasFocus = numberFocusNode.hasFocus;
      if (hasFocus && Platform.isIOS) {
        KeyboardOverlay.showOverlay(context);
      } else {
        KeyboardOverlay.removeOverlay();
      }
    });

    _controller = TextEditingController();
    properties = TextfieldProperties(
        _controller,
        decortaion,
        style,
        formatter,
        numberFocusNode,
        const TextInputType.numberWithOptions(decimal: true),
        TextAlign.center);
  }

  @override
  void dispose() {
    numberFocusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  String onChanged(TextEditingController controller, String text) {
    return IndianRupeeFormatter.amountFormatter(text, controller);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        numberFocusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Indian Rupee Formatter"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 8, left: 8),
                child: Column(
                  children: [
                    indianFormatTextField(properties, onChanged),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
