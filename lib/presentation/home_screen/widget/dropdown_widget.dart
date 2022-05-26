import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  final ValueChanged<int?> onChanged;
  final List<String> list;
  final int? value;

  const DropdownWidget(
      {Key? key, required this.onChanged, required this.list, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<int>(
      value: value,
      dropdownMaxHeight: 200,
      validator: (value) {
        if (value == null) {
          return 'required';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: null,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onChanged: (value) {
        onChanged(value);
      },
      items: _generateList(list),
    );
  }

  List<DropdownMenuItem<int>> _generateList(List<String> list) {
    return List<DropdownMenuItem<int>>.generate(
      list.length,
      (index) => DropdownMenuItem(
        child: Text(list[index]),
        value: index,
      ),
    );
  }
}
