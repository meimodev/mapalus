class Result<T> implements Exception {
  bool error;
  String message;
  T? data;

  Result({this.error = false, this.message = '', this.data});
}