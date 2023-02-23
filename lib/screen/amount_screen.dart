import 'package:flutter/material.dart';
import 'package:input_formatter/widgets/indian_format_textfield.dart';

class AmountScreen extends StatefulWidget {
  const AmountScreen({Key? key}) : super(key: key);

  @override
  State<AmountScreen> createState() => _AmountScreenState();
}

class _AmountScreenState extends State<AmountScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Indian Rupee Formatter"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,           
            children: const <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20, right: 8, left: 8),
                  child: IndianFormatTextField(),
                )
              ],
          ),
        ),
      ),
    );
  }
}
