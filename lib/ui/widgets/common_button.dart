import 'dart:developer';

import 'package:app_architecture_example/services/base_api_service.dart';
import 'package:app_architecture_example/ui/dialogs/exeption_dialog.dart';
import 'package:app_architecture_example/ui/dialogs/no_connection_dialog.dart';
import 'package:app_architecture_example/ui/styling/shadows/button_shadow.dart';
import 'package:app_architecture_example/ui/styling/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommonButton extends ConsumerStatefulWidget {
  final String label;
  final Function onTap;
  final Color? labelColor;
  final Color? buttonColor;

  const CommonButton({
    required this.label,
    required this.onTap,
    this.buttonColor = appGreen,
    this.labelColor,
    super.key,
  });

  @override
  ConsumerState<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends ConsumerState<CommonButton> {
  bool _loading = false;

  ///it is Container and GestureDetector because this tandem are totally flexible for complicated UI and prohibits issues when Flutter team decide to deprecate some Buttons
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          FocusScope.of(context).unfocus();

          setState(() {
            _loading = true;
          });
          await widget.onTap().then((_) {
            if (mounted) {
              setState(() {
                _loading = false;
              });
            }
            return _;
          });
        } catch (e, stacktrace) {
          if (context.mounted) {
            setState(() {
              _loading = false;
            });
            if (e is NoConnectionException) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const NoConnectionDialog(),
              );
            } else {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => ExceptionDialog(
                  errorText: e.toString(),
                ),
              );
            }
          }
          debugPrintStack(stackTrace: stacktrace);
          log('Exception happens *${e.runtimeType}*');
        }
      },
      child: Container(
        height: 38.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: widget.buttonColor,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: buttonShadow,
        ),
        child: Center(
            child: _loading
                ? SizedBox(
                    height: 15.0,
                    width: 15.0,
                    child: CircularProgressIndicator(
                      color: widget.labelColor ?? Colors.white,
                    ))
                : Text(
                    widget.label,
                    style: widget.labelColor != null
                        ? Theme.of(context).textTheme.labelSmall?.copyWith(color: widget.labelColor)
                        : Theme.of(context).textTheme.labelSmall,
                  )),
      ),
    );
  }
}
