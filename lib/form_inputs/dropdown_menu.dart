import 'package:flutter/material.dart';

import '../pages/helpers/styles.dart';

class AppDropdownMenu extends StatefulWidget {
  final Function onValidate;
  final String label;
  final String? defaultOption;
  final List<String> options;

  const AppDropdownMenu(
      {Key? key, required this.options, required this.label, required this.onValidate, this.defaultOption})
      : super(key: key);

  @override
  State<AppDropdownMenu> createState() => _AppDropdownMenuState();
}

class _AppDropdownMenuState extends State<AppDropdownMenu> {
  String? _selectedOption = '';
  bool? _isValid;
  String get _keyValue => (widget.key as ValueKey).value as String;

  set isValid(bool isValid) {
    _isValid = isValid;
    widget.onValidate(_keyValue, _isValid, value: _selectedOption);
  }

  @override
  initState() {
    super.initState();
    _selectedOption = widget.defaultOption ?? "";
  }

  @override
  Widget build(BuildContext context) {
    if (_isValid == null && _selectedOption!.isNotEmpty) {
      isValid = true;
    }
    final items = _buildMenuItems();
    //items.forEach((i)=>debugPrint("----> ${i.value}"));

    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        DropdownButtonFormField<String>(
          key: UniqueKey(),
          onChanged: (val) {},
          initialValue: _selectedOption,
          items: items,
          validator: _validate,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: FormStyles.secondaryColor)),
            errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: FormStyles.errorColor)),
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: FormStyles.lightGrayColor)),
            border: const OutlineInputBorder(),
            errorStyle: const TextStyle(color: Colors.transparent),
            helperText: '',
            hintText: widget.label,
            hintStyle: FormStyles.helperStyle,
          ),
        ),
        Positioned(
          top: 10,
          right: 15,
          child: Text('▼', style: FormStyles.iconDropdown),
        ),
        GestureDetector(
          onTap: _showOptions,
          child: Container(
            width: double.infinity,
            height: 60,
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _buildMenuItems() {
    final items = widget.options.map((o) {
      return DropdownMenuItem(
        value: o,
        child: Text(o, style: FormStyles.orderTotalLabel),
      );
    }).toList();
    return items;
  }

  String? _validate(value) {
    if (value == null) {
      return 'hay un error';
    } else {
      return null;
    }
  }

  _showOptions() async {
    _selectedOption = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DropdownOptions(
            title: widget.label,
            selectedOption: _selectedOption ?? '',
            options: widget.options,
          ),
        ));
    if (_selectedOption != null && _selectedOption!.isNotEmpty) {
      isValid = true;
    }
    setState(() {});
  }
}

class DropdownOptions extends StatefulWidget {
  final String title;
  final List<String> options;
  final String? selectedOption;

  const DropdownOptions({Key? key, required this.title, required this.options, this.selectedOption}) : super(key: key);

  @override
  State<DropdownOptions> createState() => _DropdownOptionsState();
}

class _DropdownOptionsState extends State<DropdownOptions> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _selectedOption = '';
  @override
  void initState() {
    _selectedOption = widget.selectedOption ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(child: Text(widget.title, style: FormStyles.optionsTitle)),
        actions: <Widget>[
          TextButton(
            onPressed: _sendSelectedOption,
            child: Text('Listo', style: FormStyles.textButton),
          )
        ],
      ),
      backgroundColor: const Color(0xfff4f4f4),
      body: Container(
        decoration: BoxDecoration(border: Border(top: BorderSide(color: FormStyles.grayColor))),
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[for (String option in widget.options) _buildOption(option)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String option) {
    return GestureDetector(
      onTap: () => _selectOption(option),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        decoration:
            BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: FormStyles.lightGrayColor))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(option, style: FormStyles.orderTotalLabel),
            Icon(Icons.check, color: _selectedOption == option ? FormStyles.secondaryColor : Colors.transparent, size: 40)
          ],
        ),
      ),
    );
  }

  void _sendSelectedOption() {
    if (_selectedOption.isNotEmpty) {
      Navigator.pop(context, _selectedOption);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Selecciona una de las opciones')));
    }
  }

  void _selectOption(String option) {
    setState(() {
      _selectedOption = option;
    });
  }
}
