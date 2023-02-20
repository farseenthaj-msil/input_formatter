import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:input_formatter/Utils/number_formatter.dart';

class AmountScreen extends StatefulWidget {
  const AmountScreen({Key? key}) : super(key: key);

  @override
  State<AmountScreen> createState() => _AmountScreenState();
}

class _AmountScreenState extends State<AmountScreen> {
  
  TextEditingController _controller = TextEditingController();
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
