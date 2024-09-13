import 'package:app_architecture_example/ui/styling/colors.dart';
import 'package:flutter/material.dart';

class CommonTextButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final double fontSize;

  const CommonTextButton({
    required this.label,
    required this.onTap,
    this.fontSize = 20.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: appBlue),
      ),
    );
  }
}
