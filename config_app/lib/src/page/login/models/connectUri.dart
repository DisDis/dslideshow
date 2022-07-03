import 'package:formz/formz.dart';

enum ConnectUriValidationError { empty, invalid }

class ConnectUri extends FormzInput<String, ConnectUriValidationError> {
  const ConnectUri.pure({String defaultValue = /*'ws://127.0.0.1:8080/ws'*/ 'ws://dslideshow4.local:8080/ws'})
      : super.pure(defaultValue);
  const ConnectUri.dirty([String value = '']) : super.dirty(value);

  @override
  ConnectUriValidationError? validator(String? value) {
    if (value?.isNotEmpty == true) {
      final connectUri = Uri.tryParse(value!);
      if (connectUri != null && connectUri.scheme == 'ws' && connectUri.hasAuthority && !connectUri.hasEmptyPath) {
        return null;
      } else {
        return ConnectUriValidationError.invalid;
      }
    } else {
      return ConnectUriValidationError.empty;
    }
  }
}
