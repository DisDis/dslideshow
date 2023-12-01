import 'package:dslideshow_common/core/resources/data_exception.dart';

abstract class DataState<T> {
  final T? data;
  final DataException? exception;

  const DataState({this.data, this.exception});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T? data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(DataException exception) : super(exception: exception);
}
