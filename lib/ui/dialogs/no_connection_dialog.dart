import 'package:app_architecture_example/ui/styling/colors.dart';
import 'package:app_architecture_example/ui/widgets/common_button.dart';
import 'package:flutter/material.dart';

class NoConnectionDialog extends StatelessWidget {
  const NoConnectionDialog({
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
            const Icon(
              Icons.details_rounded,
              color: appError,
            ),
            const SizedBox(height: 12.0),
            Text(
              'No Connection',
              style: Theme.of(context).textTheme.displaySmall,
            ),
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
