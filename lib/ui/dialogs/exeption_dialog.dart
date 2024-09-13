import 'package:app_architecture_example/ui/styling/colors.dart';
import 'package:app_architecture_example/ui/widgets/common_button.dart';
import 'package:app_architecture_example/ui/widgets/error_text_widget.dart';
import 'package:flutter/material.dart';

class ExceptionDialog extends StatelessWidget {
  final String errorText;

  const ExceptionDialog({
    required this.errorText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12.0),
            Text(
              'Something went wrong',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 12.0),
            ErrorTextWidget(errorText: errorText),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 58.0),
              child: CommonButton(
                  label: 'OK',
                  buttonColor: appBlue,
                  labelColor: Colors.white,
                  onTap: () {
                    Navigator.of(context).pop();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
