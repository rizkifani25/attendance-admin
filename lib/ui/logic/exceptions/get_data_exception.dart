class GetDataExceptions implements Exception {
  final String message;

  GetDataExceptions({this.message = 'Unknown error occurred. '});
}
