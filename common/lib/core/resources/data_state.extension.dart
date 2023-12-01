// import 'package:dio/dio.dart';
import 'package:dslideshow_common/core/resources/data_exception.dart';
import 'package:dslideshow_common/core/resources/data_exception_type.dart';
import 'package:dslideshow_common/core/resources/data_state.dart';

// Future<DataState<ET>> convertToDataState<ET, DT>(Future<Response<DT>> response, {ET Function(DT dataObject)? mapping, ET? defaultValue}) async {
//   try {
//     final httpResponse = await response;
//     final statusCode = httpResponse.statusCode ?? 0;
//     if (statusCode >= /*HttpStatus.ok*/ 200 && statusCode < 300) {
//       if (mapping != null) {
//         //ignore: avoid-non-null-assertion
//         return DataSuccess(mapping(httpResponse.data!));
//       } else {
//         return DataSuccess(defaultValue as ET);
//       }
//     } else {
//       return DataFailed(DataException(
//         error: httpResponse.statusMessage,
//         message: 'The request returned an '
//             'invalid status code of ${httpResponse.statusCode}.',
//         type: DataExceptionType.badResponse,
//         //ignore: invalid_use_of_internal_member
//         stackTrace: httpResponse.requestOptions.sourceStackTrace,
//       ));
//     }
//   } on DioException catch (e) {
//     return DataFailed(DataException(error: e, message: e.message, stackTrace: e.stackTrace, type: DataExceptionType.unknown));
//   }
// }
