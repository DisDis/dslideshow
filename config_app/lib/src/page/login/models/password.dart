import 'package:formz/formz.dart';

enum PasswordValidationError { empty }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure({String defaultValue = ''}) : super.pure(defaultValue);
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : PasswordValidationError.empty;
  }
}
