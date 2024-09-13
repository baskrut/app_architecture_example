import 'package:app_architecture_example/models/login_model.dart';
import 'package:app_architecture_example/providers/login_provider.dart';
import 'package:app_architecture_example/ui/pages/home_page.dart';
import 'package:app_architecture_example/ui/styling/colors.dart';
import 'package:app_architecture_example/ui/widgets/common_button.dart';
import 'package:app_architecture_example/ui/widgets/elevated_white_box.dart';
import 'package:app_architecture_example/ui/widgets/error_text_widget.dart';
import 'package:app_architecture_example/ui/widgets/layouts/main_layout.dart';
import 'package:app_architecture_example/ui/widgets/text_input_field.dart';
import 'package:app_architecture_example/utils/auth_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  static const String id = '/';

  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late final TextEditingController phoneController = TextEditingController();
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController nameController = TextEditingController();

  String? errorText;

  String? phoneError;
  String? emailError;
  String? nameError;

  late final FocusNode phoneFocusNode = FocusNode();
  late final FocusNode emailFocusNode = FocusNode();
  late final FocusNode nameFocusNode = FocusNode();

  @override
  void dispose() {
    phoneController.dispose();
    emailController.dispose();
    nameController.dispose();
    super.dispose();
  }

  final snackBar = const SnackBar(
    content: Text('Success !'),
    duration: Duration(seconds: 2),
  );

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      children: [
        const SizedBox(height: 12),
        ElevatedWhiteBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Focus(
                focusNode: nameFocusNode,
                onFocusChange: (val) {
                  if (!val) {
                    if (nameController.text.length < 2) {
                      setState(() {
                        nameError = 'Name too short';
                      });
                    }
                  }
                },
                child: TextInputField(
                  label: 'Name',
                  textController: nameController,
                  errorText: nameError,
                  autofocus: true,
                  onChanged: (x) {
                    if (nameError != null) {
                      setState(() {
                        nameError = null;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              Focus(
                focusNode: emailFocusNode,
                onFocusChange: (val) {
                  if (!val) {
                    if (!const EmailValidator().validate(emailController.text)) {
                      setState(() {
                        emailError = 'Please enter valid email';
                      });
                    }
                  }
                },
                child: TextInputField(
                  label: 'Email',
                  textController: emailController,
                  errorText: emailError,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (x) {
                    if (emailError != null) {
                      setState(() {
                        emailError = null;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              Focus(
                focusNode: phoneFocusNode,
                onFocusChange: (val) {
                  if (!val) {
                    if (!const PhoneValidator().validate(phoneController.text)) {
                      setState(() {
                        phoneError = 'Please enter valid phone number';
                      });
                    }
                  }
                },
                child: TextInputField(
                  label: 'Phone',
                  textController: phoneController,
                  errorText: phoneError,
                  keyboardType: TextInputType.phone,
                  onChanged: (x) {
                    if (phoneError != null || x.length == 13) {
                      setState(() {
                        phoneError = null;
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ErrorTextWidget(
                  errorText: errorText,
                ),
              ),
              const SizedBox(height: 24),
              CommonButton(
                label: 'Send',
                buttonColor: (nameController.text.length > 1 &&
                        emailController.text.isNotEmpty &&
                        phoneController.text.length == 13 &&
                        nameError == null &&
                        emailError == null &&
                        phoneError == null)
                    ? appGreen
                    : borderGrey,
                labelColor: (nameController.text.length > 1 &&
                        emailController.text.isNotEmpty &&
                        phoneController.text.length == 13 &&
                        nameError == null &&
                        emailError == null &&
                        phoneError == null)
                    ? null
                    : textDarkGrey,
                onTap: () async {
                  if (nameError == null && emailError == null && phoneError == null) {
                    ///use .then() to be sure request run

                    Future.delayed(const Duration(seconds: 1)).then((_) async {
                      await ref
                          .read(authProvider)
                          .login(LoginModel(
                              name: nameController.text, email: emailController.text, phone: phoneController.text))
                          .then((response) async {
                        ///"errorText != null" just feature to emulate success result after first fail
                        if (response?.isSuccess == true || errorText != null) {
                          setState(() {
                            errorText = null;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          await Future.delayed(const Duration(seconds: 3))
                              .then((_) => Navigator.of(context).pushNamed(HomePage.id));
                        } else {
                          setState(() {
                            errorText = response?.errorText;
                          });
                        }
                      });
                    });
                  }
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
