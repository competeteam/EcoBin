import 'package:flutter/material.dart';

class CommonCheckbox extends StatefulWidget {
  final Widget componentValue;
  final void Function()? setStateFunction;
  final bool isChecked;
  final bool isError;

  const CommonCheckbox(
      {super.key,
      required this.componentValue,
      required this.setStateFunction,
      required this.isChecked,
      required this.isError});

  @override
  State<CommonCheckbox> createState() => _CommonCheckboxState();
}

class _CommonCheckboxState extends State<CommonCheckbox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.setStateFunction,
        child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: const Color(0xFF3B3B3B),
                borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                border: widget.isError
                    ? Border.all(color: Colors.red.shade900)
                    : null),
            child: Row(children: <Widget>[
              widget.isChecked
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                          width: 20.0,
                          height: 20.0,
                          decoration: const ShapeDecoration(
                            color: Color(0xFF75BC7B),
                            shape: OvalBorder(),
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 16.0,
                          )),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        width: 20.0,
                        height: 20.0,
                        decoration: const ShapeDecoration(
                            shape: OvalBorder(
                                side:
                                    BorderSide(width: 1, color: Colors.white))),
                      ),
                    ),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: widget.componentValue))
            ])));
  }
}
