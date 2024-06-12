import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    required this.label,
    required this.onChanged,
    this.textInputType = TextInputType.name,
    this.textInputAction = TextInputAction.done,
    super.key,
  });
  final String label;
  final void Function(String value) onChanged;
  final TextInputType textInputType;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          onChanged: onChanged,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            labelText: label,
          ),
        ),
      ],
    );
  }
}
