import 'package:flutter/material.dart';

import '../pages/helpers/styles.dart';

class CheckBoxInput extends StatefulWidget {
  final String label;
  final Function? onChange;

  const CheckBoxInput({Key? key, required this.label, this.onChange}) : super(key: key);

  @override
  State<CheckBoxInput> createState() => _CheckBoxInputState();
}

class _CheckBoxInputState extends State<CheckBoxInput> {
  bool _value = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: FormStyles.lightGrayColor),
      ),
      child: Row(
        children: <Widget>[
          Checkbox(
            activeColor: FormStyles.secondaryColor,
            onChanged: _handleChange,
            value: _value,
          ),
          Text(widget.label, style: FormStyles.inputLabel),
        ],
      ),
    );
  }

  void _handleChange(bool? value) {
    setState(() {
      _value = value ?? false;
    });
  }
}
