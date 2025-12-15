import 'package:flutter/material.dart';

class USwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const USwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
