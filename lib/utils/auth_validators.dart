final RegExp _phoneRegex = RegExp(r"^[+]+[0-9]{12}$");
final RegExp _emailRegex = RegExp(r"^[a-zA-Z0-9.!#$%&'*+=^`()~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

class PhoneValidator {
  const PhoneValidator();

  bool validate(String input) => _phoneRegex.hasMatch(input);
}

class EmailValidator {
  const EmailValidator();

  bool validate(String input) => _emailRegex.hasMatch(input);
}
