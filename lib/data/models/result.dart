class Result<T> implements Exception {
  bool error;
  String message;
  T? data;

  Result({this.error = false, this.message = '', this.data});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Result &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          message == other.message &&
          data == other.data;

  @override
  int get hashCode => error.hashCode ^ message.hashCode ^ data.hashCode;
}