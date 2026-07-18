import 'package:flutter/material.dart';
import 'package:flutter_ces/pages/helpers/demo_data.dart';
import 'package:flutter_ces/pages/helpers/styles.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import 'input_validator.dart';

class TextInput extends StatefulWidget {
  final String label;
  final String helper;
  final String initialValue;
  final bool isRequired;
  final InputType type;
  final Function onValidate;
  final Function? onChange;
  final bool isActive;
  final ValueNotifier? valueNotifier;

  const TextInput({
    Key? key,
    this.helper = '',
    this.isRequired = true,
    this.initialValue = '',
    this.type = InputType.text,
    required this.onValidate,
    this.label = '',
    this.isActive = true,
    this.onChange,
    this.valueNotifier,
  }) : super(key: key);

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool _isAutoValidating = false;
  bool? _isValid;

  String _value = '';
  String _errorText = '';
  MaskedTextController? _maskedController;

  String get _keyValue => (widget.key as ValueKey).value as String;

  @override
  initState() {
    super.initState();
    if (widget.type == InputType.telephone) {
      _maskedController = MaskedTextController(
        mask: '000-000-000',
        text: widget.initialValue,
      );
      _maskedController!.addListener(() {
        _value = _maskedController!.text;
        widget.onChange?.call(_keyValue, _value);
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted) setState(() {});
        });
      });
    }
    if (widget.valueNotifier != null) {
      widget.valueNotifier?.addListener(() => _isValid = false);
    }
  }

  @override
  dispose() {
    _maskedController?.dispose();
    super.dispose();
  }

  set isValid(bool isValid) {
    if (isValid != _isValid) {
      _isValid = isValid;
      widget.onValidate(_keyValue, _isValid, value: _value);
    }
  }

  @override
  Widget build(BuildContext context) {
    //Validate based on initial value, only do this once. We do it here instead of initState as it may trigger rebuilds up the tree
    if (_isValid == null && widget.initialValue.isNotEmpty) {
      _validateField(widget.initialValue);
    }

    //build input
    return Container(
      padding: EdgeInsets.only(top: widget.label.isNotEmpty ? 18 : 0),
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          if (widget.label.isNotEmpty)
            Positioned(
                top: -24, child: Text(widget.label, style: FormStyles.inputLabel)),
          TextFormField(
            initialValue: _maskedController == null ? widget.initialValue : null,
            controller: _maskedController,
            style: FormStyles.orderTotalLabel,
            enabled: widget.isActive,
            onChanged: _maskedController == null ? _handleChange : null,
            keyboardType: _setKeyboardType(),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: _validateField,
            decoration: FormStyles.getInputDecoration(helper: widget.helper),
          ),
          Positioned(
            top: 6,
            left: 12,
            child: Text(_getLabel().toUpperCase(), style: FormStyles.labelOptional),
          ),
          if (_errorText.isNotEmpty)
            Positioned(
              top: 8,
              right: 14,
              child:
                  Text(_errorText.toUpperCase(), style: FormStyles.labelNotValid),
            ),
        ],
      ),
    );
  }

  String _getLabel() {
    String label = '';
    if (!widget.isRequired && _value.isEmpty) label = 'Opcional';
    if ((_value.isNotEmpty && widget.label.isEmpty) ||
        widget.initialValue.isNotEmpty) { return widget.helper; }
    return label;
  }

  void _handleChange(String value) {
    // save value status
    _value = value;
    widget.onChange?.call(_keyValue, value);

    // activate validation
    Future.delayed(const Duration(milliseconds: 100), () => setState(() {}));
    if (!_isAutoValidating) {
      setState(() {
        _isAutoValidating = true;
      });
    }
  }

  TextInputType? _setKeyboardType() {
    TextInputType type;
    switch (widget.type) {
      case InputType.email:
        type = TextInputType.emailAddress;
        break;
      case InputType.telephone:
        type = TextInputType.numberWithOptions(decimal: true);
        break;

      case InputType.number:
        type = TextInputType.numberWithOptions(signed: true, decimal: true);
        break;
      case InputType.text:
        return TextInputType.text;
    }
    return type;
  }

  String? _validateField(String? value) {
    _value = value ?? '';
    // if the value is required
    if (widget.isRequired && _value.isEmpty) {
      isValid = false;
      _errorText = 'Requerido';
      // Update error label, wait a frame because this was causing markAsBuild errors
      Future.delayed(const Duration(milliseconds: 17), () => setState(() {}));
      return _errorText;
    }
    // if it is optional
    else if (!widget.isRequired && _value.isEmpty) {
      isValid = true;
      _errorText = '';
      return null;
    }
    // validate when the input has a value
    else if (_value.isNotEmpty &&
        InputValidator.validate(widget.type, _value)) {
      isValid = true;
      _errorText = '';
      return null;
    }
    // in other case, the item is not valid
    else {
      isValid = false;
      _errorText = 'No es valido';
      return _errorText;
    }
  }
}
