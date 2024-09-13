import 'package:app_architecture_example/ui/styling/colors.dart';
import 'package:app_architecture_example/ui/widgets/layouts/focusLayout.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final List<Widget> children;
  final PreferredSizeWidget? appBar;

  const MainLayout({
    required this.children,
    this.appBar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FocusLayout(
      child: SafeArea(
        child: Scaffold(
            backgroundColor: appLightBlue,
            resizeToAvoidBottomInset: true,
            appBar: appBar,
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [...children],
                  ),
                ),
              ),
            )),
      ),
      // ),
    );
  }
}
