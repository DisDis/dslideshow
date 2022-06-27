import 'package:formz/formz.dart';

enum UsernameValidationError { empty }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure({String defaultValue = ''}) : super.pure(defaultValue);
  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : UsernameValidationError.empty;
  }
}
