import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AmountScreen extends StatefulWidget {
  const AmountScreen({Key? key}) : super(key: key);

  @override
  State<AmountScreen> createState() => _AmountScreenState();
}

class _AmountScreenState extends State<AmountScreen> {
  TextEditingController _controller = TextEditingController();
  var formatNumber = NumberFormat('#,##,###',);
  FocusNode numberFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // amount changing to indian format
  void amountFormatter(String text) {

    String rupeeSplittedText = text.split('₹').last.trim().toString();
    String replacedText = rupeeSplittedText.replaceAll(',', '').trim();

    int textLength = replacedText.length;

    if (replacedText.contains('.')) {
      doubleValueFormating(formatNumber, text);
    } else {
      if (textLength > 8) {
        _controller.text =
            "₹${formatNumber.format(int.parse(replacedText.toString().substring(0, 8)))}";
        
        _controller.selection = TextSelection.fromPosition(
            TextPosition(offset: _controller.text.length.toInt()));
      } else if (textLength == 0) {
        _controller.clear();
        _controller.text = '₹';
        _controller.selection =
            TextSelection.fromPosition(const TextPosition(offset: 1));
      } else {
        _controller.text =
            "₹${formatNumber.format(int.parse(replacedText.toString()))}";
        _controller.selection = TextSelection.fromPosition(
            TextPosition(offset: _controller.text.length.toInt()));
      }
    }
  }

  // formting amount containing dot
  void doubleValueFormating(NumberFormat formatter, String text) {
    String formatString;
    List<String> textSplitted;
    if (text == '.') {
      _controller.text = "₹ 0";
      _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length.toInt()));
    } else {
      formatString = text.split('₹').last.trim().toString();

      textSplitted = formatString.split('.');
      _controller.text =
          "₹${formatter.format(int.parse(textSplitted.first.toString())).toString()}.${textSplitted.last.toString().length > 2 ? textSplitted.last.toString().substring(0, 2).toString() : textSplitted.last.toString()}";
      _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length.toInt()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Input Screen"),
      ),
      body: SingleChildScrollView(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 8, left: 8),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  focusNode: numberFocusNode,
                  textAlign: TextAlign.center,
                  onChanged: (text) {
                    amountFormatter(text);    
                  },
                  onTap: () {
                      if (_controller.text.isEmpty) {
                        _controller.text = '₹';
                      }
                  },
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                  ],
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(

                    ),
                    hintText: '₹ 0',
                    filled: true
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                  }, 
                  child: const Text('OK'))
              ],
            ),
            
          )
        ],
            ),
      ),
    );
  }

}
