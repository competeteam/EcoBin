import 'package:flutter/material.dart';

class ProfileFormField extends StatelessWidget {
  final String formTitle;
  final String formValue;
  final String? Function(String?)? validatorFunction;
  final void Function(String)? onChangedFunction;

  const ProfileFormField({
    super.key,
    required this.formTitle,
    required this.formValue,
    required this.validatorFunction,
    required this.onChangedFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(formTitle,
            style: const TextStyle(color: Colors.white, fontSize: 16.0)),
        const SizedBox(height: 10.0),
        TextFormField(
          validator: validatorFunction,
          onChanged: onChangedFunction,
          decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.all(10.0),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              labelText: formValue,
              labelStyle: const TextStyle(
                color: Color(0xFF646464),
                fontSize: 14,
              )),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
