import 'package:app_architecture_example/ui/styling/colors.dart';
import 'package:flutter/material.dart';

class ErrorTextWidget extends StatelessWidget {
  final String? errorText;
  final Color? errorColor;

  const ErrorTextWidget({
    required this.errorText,
    this.errorColor = appError,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: errorText != null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.error_outline_outlined,
            color: errorColor,
          ),
          const SizedBox(width: 6.0),
          Expanded(
            child: Text(
              errorText ?? '',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: errorColor),
            ),
          )
        ],
      ),
      // )
    );
  }
}
