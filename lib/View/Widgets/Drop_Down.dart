import 'package:flutter/material.dart';

class DropDownValore extends StatefulWidget {
  final TextEditingController controle;
  final List<String> dropdownValues;

  const DropDownValore({
    required this.controle,
    required this.dropdownValues,
    Key? key,
    required String? Function(dynamic value) validator,
    required Null Function(dynamic value) onChanged,
  }) : super(key: key);

  @override
  _DropDownValoreState createState() => _DropDownValoreState();
}

class _DropDownValoreState extends State<DropDownValore> {
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.controle.text;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(labelText: 'Turmas'),
      value: dropdownValue,
      onChanged: (value) {
        setState(() {
          dropdownValue = value!;
          widget.controle.text = dropdownValue!;
        });
      },
      items: widget.dropdownValues
          .map((option) => DropdownMenuItem(
                value: option,
                child: Text(option),
              ))
          .toList(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Selecione uma opção válida';
        }
        return null;
      },
    );
  }
}
