// ignore_for_file: file_names

import 'package:formz/formz.dart' show FormzInput;

class ConnectUri extends FormzInput<String, ConnectUriValidationError> {
  static const manualTemplate = 'ws://192.168.50.xx:8080/ws';
  static final _placeholderHost = RegExp(r'^\d{1,3}(?:\.\d{1,3}){2}\.xx$');

  const ConnectUri.pure({String defaultValue = manualTemplate}) : super.pure(defaultValue);
  const ConnectUri.dirty([super.value = '']) : super.dirty();

  @override
  ConnectUriValidationError? validator(String value) {
    if (value.isNotEmpty == true) {
      final connectUri = Uri.tryParse(value);
      if (connectUri != null &&
          connectUri.scheme == 'ws' &&
          connectUri.hasAuthority &&
          !connectUri.hasEmptyPath &&
          !_placeholderHost.hasMatch(connectUri.host)) {
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
