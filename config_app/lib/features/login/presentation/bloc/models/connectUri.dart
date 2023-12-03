// ignore_for_file: file_names

import 'package:formz/formz.dart' show FormzInput;

class ConnectUri extends FormzInput<String, ConnectUriValidationError> {
  const ConnectUri.pure({String defaultValue = /*'ws://127.0.0.1:8080/ws'*/ 'ws://dslideshow1.local:8080/ws'}) : super.pure(defaultValue);
  const ConnectUri.dirty([super.value = '']) : super.dirty();

  @override
  ConnectUriValidationError? validator(String value) {
    if (value.isNotEmpty == true) {
      final connectUri = Uri.tryParse(value);
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

enum ConnectUriValidationError { empty, invalid }
